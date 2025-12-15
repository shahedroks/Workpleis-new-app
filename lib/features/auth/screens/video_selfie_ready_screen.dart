import 'dart:io';
import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:workpleis/features/auth/screens/video_selfie_ready_screen1.dart';

import '../../../core/constants/color_control/all_color.dart';
import '../../../core/widget/global_get_started_button.dart';
import '../data/front_id_data.dart';

class VideoSelfieReadyScreen extends StatefulWidget {
  const VideoSelfieReadyScreen({super.key});
  static const routeName = '/video-selfie-ready';

  /// ✅ তোমার next route এখানে
  static const String nextRoute = '/liveness-check';

  @override
  State<VideoSelfieReadyScreen> createState() => _VideoSelfieReadyScreenState();
}

class _VideoSelfieReadyScreenState extends State<VideoSelfieReadyScreen>
    with WidgetsBindingObserver {
  CameraController? _controller;
  Future<void>? _initFuture;
  String? _cameraError;

  late final FaceDetector _detector = FaceDetector(
    options: FaceDetectorOptions(
      performanceMode: FaceDetectorMode.fast,
      enableContours: true,
      enableLandmarks: false,
      enableClassification: true, // ✅ blink probability দরকার
      minFaceSize: 0.15,
    ),
  );

  bool _streamStarted = false;
  bool _detecting = false;
  DateTime _lastDetect = DateTime.fromMillisecondsSinceEpoch(0);

  Size? _lastImageSize;
  InputImageRotation? _lastRotation;

  List<_ContourPolyline> _polylines = const [];

  // ✅ liveness flags
  bool _blinkDone = false;
  bool _mouthDone = false;
  bool _turnLeftDone = false;
  bool _turnRightDone = false;
  int _blinkStage = 0; // 0=open -> wait close, 1=closed -> wait open

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    _initCamera();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _stopStream();
    _controller?.dispose();
    _detector.close();

    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    final c = _controller;
    if (c == null || !c.value.isInitialized) return;

    if (state == AppLifecycleState.inactive || state == AppLifecycleState.paused) {
      try {
        await c.pausePreview();
      } catch (_) {}
      _stopStream();
    } else if (state == AppLifecycleState.resumed) {
      try {
        await c.resumePreview();
      } catch (_) {}
      if (mounted) _startStream();
    }
  }

  Future<void> _initCamera() async {
    try {
      final cams = await availableCameras();
      if (cams.isEmpty) {
        setState(() => _cameraError = "No camera found");
        return;
      }

      final front = cams.firstWhere(
            (x) => x.lensDirection == CameraLensDirection.front,
        orElse: () => cams.first,
      );

      final c = CameraController(
        front,
        ResolutionPreset.high,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.yuv420,
      );

      setState(() {
        _controller = c;
        _initFuture = c.initialize();
        _cameraError = null;
      });

      await _initFuture;
      if (!mounted) return;

      setState(() {});
      _startStream();
    } catch (e) {
      if (mounted) setState(() => _cameraError = e.toString());
    }
  }

  void _startStream() {
    final c = _controller;
    if (c == null || _streamStarted) return;

    try {
      c.startImageStream((img) async => _processFrame(img));
      _streamStarted = true;
    } catch (e) {
      setState(() => _cameraError = "Stream error: $e");
    }
  }

  void _stopStream() {
    final c = _controller;
    if (c == null || !_streamStarted) return;
    try {
      c.stopImageStream();
    } catch (_) {}
    _streamStarted = false;
  }

  int _deviceOrientationToDegrees(DeviceOrientation o) {
    switch (o) {
      case DeviceOrientation.portraitUp:
        return 0;
      case DeviceOrientation.landscapeLeft:
        return 90;
      case DeviceOrientation.portraitDown:
        return 180;
      case DeviceOrientation.landscapeRight:
        return 270;
    }
  }

  InputImageRotation _rotationFromController() {
    final c = _controller!;
    final sensor = c.description.sensorOrientation;
    final deviceDeg = _deviceOrientationToDegrees(c.value.deviceOrientation);

    int rotation;
    if (c.description.lensDirection == CameraLensDirection.front) {
      rotation = (sensor + deviceDeg) % 360;
    } else {
      rotation = (sensor - deviceDeg + 360) % 360;
    }

    return InputImageRotationValue.fromRawValue(rotation) ??
        InputImageRotation.rotation0deg;
  }

  InputImage? _toInputImage(CameraImage image) {
    final c = _controller;
    if (c == null) return null;

    final bytes = _concatenatePlanes(image.planes);

    final size = Size(image.width.toDouble(), image.height.toDouble());
    final rotation = _rotationFromController();

    final format =
        InputImageFormatValue.fromRawValue(image.format.raw) ?? InputImageFormat.yuv420;

    final meta = InputImageMetadata(
      size: size,
      rotation: rotation,
      format: format,
      bytesPerRow: image.planes.first.bytesPerRow,
    );

    _lastImageSize = size;
    _lastRotation = rotation;

    return InputImage.fromBytes(bytes: bytes, metadata: meta);
  }

  Uint8List _concatenatePlanes(List<Plane> planes) {
    final WriteBuffer allBytes = WriteBuffer();
    for (final p in planes) {
      allBytes.putUint8List(p.bytes);
    }
    return allBytes.done().buffer.asUint8List();
  }

  Future<void> _processFrame(CameraImage image) async {
    if (_detecting) return;

    final now = DateTime.now();
    if (now.difference(_lastDetect).inMilliseconds < 120) return;
    _lastDetect = now;

    _detecting = true;
    try {
      final input = _toInputImage(image);
      if (input == null) return;

      final faces = await _detector.processImage(input);
      if (!mounted) return;

      if (faces.length != 1) {
        if (_polylines.isNotEmpty) setState(() => _polylines = const []);
        return;
      }

      final f = faces.first;

      // ✅ mesh polylines
      final list = <_ContourPolyline>[];
      void add(FaceContourType t, {bool close = false}) {
        final pts = f.contours[t]?.points;
        if (pts == null || pts.isEmpty) return;
        list.add(
          _ContourPolyline(
            points: pts.map((p) => Offset(p.x.toDouble(), p.y.toDouble())).toList(),
            close: close,
          ),
        );
      }

      add(FaceContourType.face, close: true);
      add(FaceContourType.leftEye, close: true);
      add(FaceContourType.rightEye, close: true);
      add(FaceContourType.leftEyebrowTop);
      add(FaceContourType.rightEyebrowTop);
      add(FaceContourType.noseBridge);
      add(FaceContourType.noseBottom, close: true);
      add(FaceContourType.upperLipTop);
      add(FaceContourType.upperLipBottom);
      add(FaceContourType.lowerLipTop);
      add(FaceContourType.lowerLipBottom);

      // ✅ liveness actions
      _updateBlink(f);
      _updateMouthOpen(f);
      _updateHeadTurn(f);

      setState(() => _polylines = list);
    } catch (_) {
      // keep UI smooth
    } finally {
      _detecting = false;
    }
  }

  void _updateBlink(Face face) {
    if (_blinkDone) return;

    final l = face.leftEyeOpenProbability;
    final r = face.rightEyeOpenProbability;
    if (l == null || r == null) return;

    final bothOpen = l > 0.60 && r > 0.60;
    final bothClosed = l < 0.30 && r < 0.30;

    if (_blinkStage == 0) {
      if (bothClosed) _blinkStage = 1;
    } else {
      if (bothOpen) _blinkDone = true;
    }
  }

  void _updateMouthOpen(Face face) {
    if (_mouthDone) return;

    final upper = face.contours[FaceContourType.upperLipBottom]?.points;
    final lower = face.contours[FaceContourType.lowerLipTop]?.points;
    if (upper == null || lower == null || upper.isEmpty || lower.isEmpty) return;

    final up = upper[upper.length ~/ 2];
    final lo = lower[lower.length ~/ 2];

    final gap = (lo.y - up.y).abs();
    final faceH = face.boundingBox.height;
    if (faceH <= 0) return;

    // ✅ tuned threshold
    final open = (gap / faceH) > 0.055;
    if (open) _mouthDone = true;
  }
  void _updateHeadTurn(Face face) {
    final y = face.headEulerAngleY;
    if (y == null) return;

    if (y > 15) _turnLeftDone = true;
    if (y < -15) _turnRightDone = true;
  }

  bool get _allDone => _blinkDone && _mouthDone && _turnLeftDone && _turnRightDone;

  void _onReady() {
    if (_allDone) {
      context.push(VideoSelfieReadyScreen1.routeName);
      return;
    }
    final missing = <String>[];
    if (!_blinkDone) missing.add("Blink eyes");
    if (!_mouthDone) missing.add("Open mouth");
    if (!_turnLeftDone) missing.add("Turn left");
    if (!_turnRightDone) missing.add("Turn right");

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(missing.join(" • ")),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const neon = Color(0xFFC6F151);

    // ✅ same sizes (like screenshot)
    final double circleSize = 320.w;
    final double bracketSize = circleSize + 56.w;

    final bool showCamera = _controller != null && _controller!.value.isInitialized;

    // iOS front camera preview usually mirrored -> overlay mirror needed
    final bool mirrorOverlay =
        defaultTargetPlatform == TargetPlatform.iOS &&
            (_controller?.description.lensDirection == CameraLensDirection.front);

    final fallbackFace = DocumentScanStore.faceImagePath;
    final hasFallbackFace = fallbackFace != null &&
        fallbackFace.isNotEmpty &&
        File(fallbackFace).existsSync();

    return Scaffold(
      backgroundColor: AllColor.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 16.h),
          child: Column(
            children: [
              SizedBox(height: 10.h),

              // close
              Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: () => context.pop(),
                  borderRadius: BorderRadius.circular(14.r),
                  child: Container(
                    height: 40.w,
                    width: 40.w,
                    decoration: BoxDecoration(
                      color: AllColor.grey70,
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    child: Center(
                      child: Icon(Icons.close, size: 24.sp, color: AllColor.black),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 22.h),

              // title highlight
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    fontFamily: 'sf_pro',
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w500,
                    color: AllColor.black,
                    height: 1.15,
                  ),
                  children: [
                    const TextSpan(text: "Get ready for your\n"),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: neon,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Text(
                          "video selfie",
                          style: TextStyle(
                            fontFamily: 'sf_pro',
                            fontSize: 32.sp,
                            fontWeight: FontWeight.w500,
                            color: AllColor.black,
                            height: 1.1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 28.h),

              // bracket + circle
              Expanded(
                child: Center(
                  child: SizedBox(
                    width: bracketSize,
                    height: bracketSize,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned.fill(
                          child: CustomPaint(
                            painter: _BracketCornerPainter(
                              color: Colors.black,
                              strokeWidth: 3.2,
                              cornerLen: 30,
                              inset: 10,
                              cornerRadius: 2, // ✅ তুমি বলছো radius 4
                            ),
                          ),
                        ),

                        // circle
                        Container(
                          width: circleSize,
                          height: circleSize,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: neon, width: 16.w),
                          ),
                          child: ClipOval(
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                // background
                                if (showCamera)
                                  _CoverCameraPreview(controller: _controller!)
                                else if (hasFallbackFace)
                                  Image.file(File(fallbackFace!), fit: BoxFit.cover)
                                else
                                  Image.asset("assets/images/face_photo.png", fit: BoxFit.cover),

                                // ✅ circular shade/vignette (top+bottom same)
                                Positioned.fill(
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      gradient: RadialGradient(
                                        center: Alignment.center,
                                        radius: 0.95,
                                        colors: [
                                          Colors.transparent,
                                          Colors.black.withOpacity(0.10),
                                          Colors.black.withOpacity(0.50),
                                        ],
                                        stops: const [0.62, 0.84, 1.0], // ✅ FIX
                                      ),
                                    ),
                                  ),
                                ),

                                // mesh
                                CustomPaint(
                                  painter: _ContourMeshPainter(
                                    imageSize: _lastImageSize,
                                    rotation: _lastRotation,
                                    polylines: _polylines,
                                    mirrorX: mirrorOverlay,
                                    lineColor: Colors.white.withOpacity(0.85),
                                    lineWidth: 1.1,
                                    dotColor: const Color(0xFFE6FF6A),
                                    dotRadius: 3.0,
                                    makeTriangleMesh: true,
                                  ),
                                ),

                                if (!showCamera && _cameraError != null)
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      margin: EdgeInsets.only(bottom: 10.h),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10.w,
                                        vertical: 6.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.45),
                                        borderRadius: BorderRadius.circular(10.r),
                                      ),
                                      child: Text(
                                        _cameraError!,
                                        style: TextStyle(color: Colors.white, fontSize: 11.sp),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 18.h),
              Text(
                "Please frame your face in the small\noval, then hit go via below",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'sf_pro',
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400,
                  color: AllColor.black.withOpacity(0.60),
                  height: 1.5,
                ),
              ),

              SizedBox(height: 18.h),

              SizedBox(
                width: double.infinity,
                height: 56.h,
                child: CustomButton(
                  text: "I'm ready",
                  icon: Icons.arrow_forward,
                  onTap: (){
                    context.push(VideoSelfieReadyScreen1.routeName);
                  },
                ),
              ),

              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
    );
  }
}

/// ✅ Camera preview cover (NO black bars + NO rotate issue)
class _CoverCameraPreview extends StatelessWidget {
  const _CoverCameraPreview({required this.controller});
  final CameraController controller;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        final size = constraints.biggest;
        final previewAR = controller.value.aspectRatio; // w/h
        final widgetAR = size.width / size.height;

        // cover scale
        double scale = previewAR / widgetAR;
        if (scale < 1) scale = 1 / scale;

        return ClipRect(
          child: Transform.scale(
            scale: scale,
            child: Center(
              child: CameraPreview(controller),
            ),
          ),
        );
      },
    );
  }
}

/// ✅ Rounded bracket corners (top/bottom same look)
class _BracketCornerPainter extends CustomPainter {
  _BracketCornerPainter({
    required this.color,
    required this.strokeWidth,
    required this.cornerLen,
    required this.inset,
    required this.cornerRadius,
  });

  final Color color;
  final double strokeWidth;
  final double cornerLen;
  final double inset;
  final double cornerRadius;

  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final l = inset;
    final t = inset;
    final r = size.width - inset;
    final b = size.height - inset;

    final cr = cornerRadius;

    Path tl() => Path()
      ..moveTo(l, t + cornerLen)
      ..lineTo(l, t + cr)
      ..arcToPoint(Offset(l + cr, t), radius: Radius.circular(cr))
      ..lineTo(l + cornerLen, t);

    Path tr() => Path()
      ..moveTo(r - cornerLen, t)
      ..lineTo(r - cr, t)
      ..arcToPoint(Offset(r, t + cr), radius: Radius.circular(cr))
      ..lineTo(r, t + cornerLen);

    Path bl() => Path()
      ..moveTo(l, b - cornerLen)
      ..lineTo(l, b - cr)
      ..arcToPoint(Offset(l + cr, b), radius: Radius.circular(cr))
      ..lineTo(l + cornerLen, b);

    Path br() => Path()
      ..moveTo(r - cornerLen, b)
      ..lineTo(r - cr, b)
      ..arcToPoint(Offset(r, b - cr), radius: Radius.circular(cr))
      ..lineTo(r, b - cornerLen);

    canvas.drawPath(tl(), p);
    canvas.drawPath(tr(), p);
    canvas.drawPath(bl(), p);
    canvas.drawPath(br(), p);
  }

  @override
  bool shouldRepaint(covariant _BracketCornerPainter oldDelegate) => false;
}

class _ContourPolyline {
  const _ContourPolyline({required this.points, required this.close});
  final List<Offset> points;
  final bool close;
}

class _Neighbor {
  _Neighbor(this.d, this.j);
  final double d;
  final int j;
}

/// ✅ Mesh painter (BoxFit.cover mapping + mirror + triangle mesh)
class _ContourMeshPainter extends CustomPainter {
  _ContourMeshPainter({
    required this.imageSize,
    required this.rotation,
    required this.polylines,
    required this.mirrorX,
    required this.lineColor,
    required this.lineWidth,
    required this.dotColor,
    required this.dotRadius,
    required this.makeTriangleMesh,
  });

  final Size? imageSize;
  final InputImageRotation? rotation;
  final List<_ContourPolyline> polylines;
  final bool mirrorX;

  final Color lineColor;
  final double lineWidth;
  final Color dotColor;
  final double dotRadius;
  final bool makeTriangleMesh;

  @override
  void paint(Canvas canvas, Size size) {
    if (imageSize == null || polylines.isEmpty) return;

    final lp = Paint()
      ..color = lineColor
      ..strokeWidth = lineWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final dp = Paint()..color = dotColor;

    // rotation 90/270 => swap
    final swap = rotation == InputImageRotation.rotation90deg ||
        rotation == InputImageRotation.rotation270deg;

    final inputW = swap ? imageSize!.height : imageSize!.width;
    final inputH = swap ? imageSize!.width : imageSize!.height;
    final inputSize = Size(inputW, inputH);

    // BoxFit.cover source crop
    final srcAspect = inputSize.width / inputSize.height;
    final dstAspect = size.width / size.height;

    late double srcW, srcH, srcX, srcY;

    if (srcAspect > dstAspect) {
      srcH = inputSize.height;
      srcW = srcH * dstAspect;
      srcX = (inputSize.width - srcW) / 2;
      srcY = 0;
    } else {
      srcW = inputSize.width;
      srcH = srcW / dstAspect;
      srcX = 0;
      srcY = (inputSize.height - srcH) / 2;
    }

    Offset mapPoint(Offset p) {
      double x = (p.dx - srcX) / srcW * size.width;
      final y = (p.dy - srcY) / srcH * size.height;
      if (mirrorX) x = size.width - x;
      return Offset(x, y);
    }

    // gather unique points (performance + clean)
    final points = <Offset>[];
    final seen = <int>{};

    for (final poly in polylines) {
      if (poly.points.length < 2) continue;

      final path = Path();
      final first = mapPoint(poly.points.first);
      path.moveTo(first.dx, first.dy);

      for (int i = 1; i < poly.points.length; i++) {
        final pt = mapPoint(poly.points[i]);
        path.lineTo(pt.dx, pt.dy);
      }
      if (poly.close) path.close();

      canvas.drawPath(path, lp);

      for (final p in poly.points) {
        final pt = mapPoint(p);
        if (pt.dx < -6 || pt.dy < -6 || pt.dx > size.width + 6 || pt.dy > size.height + 6) {
          continue;
        }
        final key = (pt.dx.round() << 16) ^ pt.dy.round();
        if (seen.add(key)) points.add(pt);
      }
    }

    // triangle-ish connections
    if (makeTriangleMesh && points.length >= 8) {
      final used = <int, Set<int>>{};

      for (int i = 0; i < points.length; i++) {
        final a = points[i];

        final dists = <_Neighbor>[];
        for (int j = 0; j < points.length; j++) {
          if (i == j) continue;
          final b = points[j];
          final dx = a.dx - b.dx;
          final dy = a.dy - b.dy;
          final d = sqrt(dx * dx + dy * dy);
          if (d < 58) dists.add(_Neighbor(d, j));
        }

        dists.sort((x, y) => x.d.compareTo(y.d));
        final takeCount = min(3, dists.length);

        for (int k = 0; k < takeCount; k++) {
          final j = dists[k].j;
          final minIJ = min(i, j);
          final maxIJ = max(i, j);

          used.putIfAbsent(minIJ, () => <int>{});
          if (used[minIJ]!.contains(maxIJ)) continue;
          used[minIJ]!.add(maxIJ);

          canvas.drawLine(points[i], points[j], lp);
        }
      }
    }

    // dots
    for (final pt in points) {
      canvas.drawCircle(pt, dotRadius, dp);
    }
  }

  @override
  bool shouldRepaint(covariant _ContourMeshPainter oldDelegate) {
    return oldDelegate.polylines != polylines ||
        oldDelegate.imageSize != imageSize ||
        oldDelegate.rotation != rotation ||
        oldDelegate.mirrorX != mirrorX;
  }
}
