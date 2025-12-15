import 'dart:io';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:workpleis/core/widget/global_get_started_button.dart';

import '../../../core/constants/color_control/all_color.dart';
import '../../../core/widget/global_logo.dart';
import '../data/front_id_data.dart';

class VideoSelfieReadyScreen1 extends StatefulWidget {
  const VideoSelfieReadyScreen1({super.key});
  static const routeName = '/video-selfie-preview';

  @override
  State<VideoSelfieReadyScreen1> createState() => _VideoSelfieReadyScreen1State();
}

class _VideoSelfieReadyScreen1State extends State<VideoSelfieReadyScreen1> {
  static const neon = Color(0xFFC6F151);

  final FaceDetector _detector = FaceDetector(
    options:  FaceDetectorOptions(
      performanceMode: FaceDetectorMode.fast,
      enableContours: true,
      enableLandmarks: false,
      enableClassification: false,
      minFaceSize: 0.15,
    ),
  );

  bool _loading = false;
  String? _error;

  Size? _imgSize;
  List<_ContourPolyline> _polylines = const [];

  @override
  void initState() {
    super.initState();
    _buildMeshFromCaptured();
  }

  @override
  void dispose() {
    _detector.close();
    super.dispose();
  }

  Future<void> _buildMeshFromCaptured() async {
    final path = DocumentScanStore.videoSelfieImagePath;
    if (path == null || path.isEmpty) return;

    final file = File(path);
    if (!await file.exists()) return;

    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      // ✅ decode image size
      final bytes = await file.readAsBytes();
      final codec = await ui.instantiateImageCodec(bytes);
      final frame = await codec.getNextFrame();
      final decoded = frame.image;
      final imgSize = Size(decoded.width.toDouble(), decoded.height.toDouble());

      // ✅ MLKit contours
      final input = InputImage.fromFilePath(path);
      final faces = await _detector.processImage(input);

      if (!mounted) return;

      if (faces.isEmpty) {
        setState(() {
          _imgSize = imgSize;
          _polylines = const [];
          _loading = false;
        });
        return;
      }

      final f = faces.first;
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

      setState(() {
        _imgSize = imgSize;
        _polylines = list;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _error = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final path = DocumentScanStore.videoSelfieImagePath;
    final has = path != null && path.isNotEmpty && File(path).existsSync();

    final circleSize = 320.w;

    return Scaffold(
      backgroundColor: AllColor.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 16.h),
          child: Column(
            children: [
              SizedBox(height: 10.h),

              /// ✅ close
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

              /// ✅ main preview block (pill + circle)
              Expanded(
                child: Center(
                  child: SizedBox(
                    width: circleSize + 40.w,
                    height: circleSize + 60.h,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        // circle
                        Positioned(
                          top: 28.h,
                          child: Container(
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
                                  if (has)
                                    Image.file(File(path!), fit: BoxFit.cover)
                                  else
                                    Image.asset("assets/images/face_photo.png", fit: BoxFit.cover),

                                  /// ✅ circular shade/vignette (top+bottom same)
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
                                          stops: const [0.62, 0.84, 1.0],
                                        ),
                                      ),
                                    ),
                                  ),

                                  /// ✅ mesh overlay
                                  CustomPaint(
                                    painter: _ContourMeshPainter(
                                      imageSize: _imgSize,
                                      polylines: _polylines,
                                      lineColor: Colors.white.withOpacity(0.85),
                                      lineWidth: 1.1,
                                      dotColor: const Color(0xFFE6FF6A),
                                      dotRadius: 3.0,
                                      makeTriangleMesh: true,
                                    ),
                                  ),

                                  if (_loading)
                                    Center(
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.35),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: const SizedBox(
                                          width: 22,
                                          height: 22,
                                          child: CircularProgressIndicator(strokeWidth: 2),
                                        ),
                                      ),
                                    ),

                                  if (_error != null && _error!.isNotEmpty)
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        margin: EdgeInsets.only(bottom: 12.h),
                                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.45),
                                          borderRadius: BorderRadius.circular(10.r),
                                        ),
                                        child: Text(
                                          _error!,
                                          style: TextStyle(color: Colors.white, fontSize: 11.sp),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        /// ✅ pill (same look)
                        Positioned(
                          top: 0,
                          child: SizedBox(
                            width: double.infinity,
                            height: 56.h,
                            child:
                                CustomButton(
                                    text: "Move Closer",
                                    textColor: AllColor.white,
                                    bgColor: AllColor.black,
                                    onTap: (){

                                })

                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              /// ✅ bottom logo (same style)
            Image.asset("assets/images/updatelogo.png", fit: BoxFit.cover,),

              SizedBox(height: 18.h),
            ],
          ),
        ),
      ),
    );
  }
}

/// contour model
/// ---------------------
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

/// ---------------------
/// mesh painter (BoxFit.cover mapping + triangle mesh)
/// ---------------------
class _ContourMeshPainter extends CustomPainter {
  _ContourMeshPainter({
    required this.imageSize,
    required this.polylines,
    required this.lineColor,
    required this.lineWidth,
    required this.dotColor,
    required this.dotRadius,
    required this.makeTriangleMesh,
  });

  final Size? imageSize;
  final List<_ContourPolyline> polylines;

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

    // BoxFit.cover mapping
    final input = imageSize!;
    final srcAspect = input.width / input.height;
    final dstAspect = size.width / size.height;

    late double srcW, srcH, srcX, srcY;

    if (srcAspect > dstAspect) {
      srcH = input.height;
      srcW = srcH * dstAspect;
      srcX = (input.width - srcW) / 2;
      srcY = 0;
    } else {
      srcW = input.width;
      srcH = srcW / dstAspect;
      srcX = 0;
      srcY = (input.height - srcH) / 2;
    }

    Offset mapPoint(Offset p) {
      final x = (p.dx - srcX) / srcW * size.width;
      final y = (p.dy - srcY) / srcH * size.height;
      return Offset(x, y);
    }

    final points = <Offset>[];

    // contour lines + points
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
        points.add(pt);
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
    return oldDelegate.polylines != polylines || oldDelegate.imageSize != imageSize;
  }
}
