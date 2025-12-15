// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:go_router/go_router.dart';
// import 'package:image_picker/image_picker.dart';
//
// import '../../../core/constants/color_control/all_color.dart';
//
// class TakeYourFacePhoto extends StatefulWidget {
//   const TakeYourFacePhoto({super.key});
//   static const routeName = '/take-face-photo';
//
//   @override
//   State<TakeYourFacePhoto> createState() => _TakeYourFacePhotoState();
// }
//
// class _TakeYourFacePhotoState extends State<TakeYourFacePhoto> {
//   final ImagePicker _picker = ImagePicker();
//   XFile? _selected;
//
//   Future<void> _takePhoto() async {
//     final file = await _picker.pickImage(
//       source: ImageSource.camera,
//       imageQuality: 100,
//       preferredCameraDevice: CameraDevice.front,
//     );
//     if (file == null) return;
//     setState(() => _selected = file);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // screenshot-like colors
//     const Color topOverlay = Color(0xFF1E2412); // dark olive overlay
//     const Color bottomOverlay = Color(0xFF000000); // black overlay
//     const Color neon = Color(0xFFC6F151); // neon camera button bg
//
//     return Scaffold(
//       backgroundColor: Color(0xFF0F0606),
//       body: Stack(
//         fit: StackFit.expand,
//         children: [
//           // Background image (placeholder/selected)
//           _selected == null
//               ? Image.asset(
//             "assets/images/face_photo.png",
//             fit: BoxFit.cover,
//           )
//               : Image.file(
//             File(_selected!.path),
//             fit: BoxFit.cover,
//           ),
//
//           // Top dark overlay
//           Positioned(
//             left: 0,
//             right: 0,
//             top: 0,
//             height: 260.h,
//             child: Container(
//               color: topOverlay.withOpacity(0.70),
//             ),
//           ),
//
//           // Bottom dark overlay
//           Positioned(
//             left: 0,
//             right: 0,
//             bottom: 0,
//             height: 290.h,
//             child: Container(
//               color: bottomOverlay.withOpacity(0.35),
//             ),
//           ),
//
//           SafeArea(
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 18.w),
//               child: Column(
//
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   SizedBox(height: 10.h),
//
//                   // Back button
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     child: InkWell(
//                       onTap: () => context.pop(),
//                       borderRadius: BorderRadius.circular(14.r),
//                       child: Container(
//                         height: 40.w,
//                         width: 40.w,
//                         decoration: BoxDecoration(
//                           color: AllColor.grey70,
//                           borderRadius: BorderRadius.circular(14.r),
//                         ),
//                         child: Center(
//                           child: Icon(
//                             Icons.arrow_back,
//                             size: 24.sp,
//                             color: AllColor.black,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//
//                   SizedBox(height: 18.h),
//
//                   // Title
//                   Text(
//                     "Take your face photo",
//                     style: TextStyle(
//                       fontFamily: 'sf_pro',
//                       fontSize: 32.sp,
//                       fontWeight: FontWeight.w500,
//                       color: AllColor.white,
//                       height: 1.1,
//                     ),
//                   ),
//
//                   SizedBox(height: 10.h),
//
//                   // Subtitle
//                   Text(
//                     "Place your face into the marked area and\ntake a clear photo",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontFamily: 'sf_pro',
//                       fontSize: 18.sp,
//                       fontWeight: FontWeight.w400,
//                       color: AllColor.white.withOpacity(0.85),
//                       height: 1.5,
//                     ),
//                   ),
//                   // Space to circle frame area
//                   SizedBox(height: 45.h),
//
//                   // Circle frame (white ring)
//                   Center(
//                     child: Container(
//                       width: 350.w,
//                       height: 350.h,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         border: Border.all(
//                           color: AllColor.white,
//                           width: 6.w,
//                         ),
//                       ),
//                     ),
//                   ),
//
//                   const Spacer(),
//
//                   // Camera button bottom center
//                   Center(
//                     child: InkWell(
//                       onTap: _takePhoto,
//                       borderRadius: BorderRadius.circular(999.r),
//                       child: Container(
//                         width: 54.w,
//                         height: 54.w,
//                         decoration: BoxDecoration(
//                           color: neon,
//                           shape: BoxShape.circle,
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.25),
//                               blurRadius: 14,
//                               offset: const Offset(0, 8),
//                             ),
//                           ],
//                         ),
//                         child: Center(
//                           child: Icon(
//                             Icons.photo_camera_outlined,
//                             color: Colors.black,
//                             size: 22.sp,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//
//                   SizedBox(height: 24.h),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/constants/color_control/all_color.dart';
import '../data/front_id_data.dart';
import 'confirm_face_photo_screen.dart';

class TakeYourFacePhoto extends StatefulWidget {
  const TakeYourFacePhoto({super.key});
  static const routeName = '/take-face-photo';

  @override
  State<TakeYourFacePhoto> createState() => _TakeYourFacePhotoState();
}

class _TakeYourFacePhotoState extends State<TakeYourFacePhoto>
    with WidgetsBindingObserver {
  final ImagePicker _picker = ImagePicker();

  CameraController? _cameraController;
  Future<void>? _cameraInit;
  String? _cameraError;

  late final FaceDetector _faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      performanceMode: FaceDetectorMode.fast,
      enableContours: false,
      enableLandmarks: false,
      enableClassification: false,
      minFaceSize: 0.15,
    ),
  );

  bool _isDetecting = false;
  DateTime _lastDetect = DateTime.fromMillisecondsSinceEpoch(0);
  bool _faceAligned = false;
  int _stableFrames = 0;

  XFile? _selected;
  bool _isCapturing = false;
  bool _streamStarted = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initFrontCamera();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _stopStreamSafely();
    _cameraController?.dispose();
    _faceDetector.close();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    final controller = _cameraController;
    if (controller == null || !controller.value.isInitialized) return;

    if (state == AppLifecycleState.inactive || state == AppLifecycleState.paused) {
      try {
        await controller.pausePreview();
      } catch (_) {}
    } else if (state == AppLifecycleState.resumed) {
      try {
        await controller.resumePreview();
      } catch (_) {}
      // ✅ resume stream if needed
      if (mounted && !_streamStarted && _selected == null) {
        await _startFaceStream();
      }
    }
  }

  Future<void> _initFrontCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        setState(() => _cameraError = "No camera found");
        return;
      }

      final front = cameras.firstWhere(
            (c) => c.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );

      final controller = CameraController(
        front,
        ResolutionPreset.high,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.yuv420,
      );

      setState(() {
        _cameraController = controller;
        _cameraInit = controller.initialize();
        _cameraError = null;
      });

      await _cameraInit;
      if (!mounted) return;

      setState(() {});
      await _startFaceStream();
    } catch (e) {
      if (mounted) setState(() => _cameraError = e.toString());
    }
  }

  Future<void> _startFaceStream() async {
    if (_cameraController == null) return;
    if (_streamStarted) return;

    try {
      await _cameraController!.startImageStream((CameraImage image) async {
        await _processFrame(image);
      });
      _streamStarted = true;
    } catch (e) {
      if (mounted) setState(() => _cameraError = "Stream error: $e");
    }
  }

  Future<void> _stopStreamSafely() async {
    if (_cameraController == null) return;
    if (!_streamStarted) return;

    try {
      await _cameraController!.stopImageStream();
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
    final c = _cameraController!;
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

  Future<void> _processFrame(CameraImage image) async {
    if (_isDetecting) return;

    final now = DateTime.now();
    if (now.difference(_lastDetect).inMilliseconds < 120) return;
    _lastDetect = now;

    _isDetecting = true;

    try {
      final inputImage = _cameraImageToInputImage(image);
      if (inputImage == null) return;

      final faces = await _faceDetector.processImage(inputImage);

      final aligned = _isFaceAligned(
        faces,
        inputImage.metadata?.size,
        inputImage.metadata?.rotation,
      );

      if (!mounted) return;

      _stableFrames = aligned ? (_stableFrames + 1) : 0;

      if (aligned != _faceAligned) {
        setState(() => _faceAligned = aligned);
      }

      // ✅ Auto capture only when aligned + stable
      if (_faceAligned && _stableFrames >= 7 && !_isCapturing && _selected == null) {
        await _captureAndGo(auto: true);
      }
    } catch (_) {
      // silent
    } finally {
      _isDetecting = false;
    }
  }

  InputImage? _cameraImageToInputImage(CameraImage image) {
    final controller = _cameraController;
    if (controller == null) return null;

    final WriteBuffer allBytes = WriteBuffer();
    for (final plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();

    final imageSize = Size(image.width.toDouble(), image.height.toDouble());
    final rotation = _rotationFromController();

    final format =
        InputImageFormatValue.fromRawValue(image.format.raw) ??
            InputImageFormat.yuv420;

    final metadata = InputImageMetadata(
      size: imageSize,
      rotation: rotation,
      format: format,
      bytesPerRow: image.planes.first.bytesPerRow,
    );

    return InputImage.fromBytes(bytes: bytes, metadata: metadata);
  }

  bool _isFaceAligned(List<Face> faces, Size? imageSize, InputImageRotation? rot) {
    if (faces.length != 1) return false;
    if (imageSize == null) return false;

    final face = faces.first;
    final box = face.boundingBox;

    // ✅ rotation 90/270 হলে width/height swap consider
    final isSwap = rot == InputImageRotation.rotation90deg ||
        rot == InputImageRotation.rotation270deg;

    final w = isSwap ? imageSize.height : imageSize.width;
    final h = isSwap ? imageSize.width : imageSize.height;

    final cx = box.center.dx / w;
    final cy = box.center.dy / h;
    final fw = box.width / w;
    final fh = box.height / h;

    // ✅ একটু loose range (real device safe)
    final centered = cx > 0.25 && cx < 0.75 && cy > 0.22 && cy < 0.78;
    final goodSize = fw > 0.18 && fw < 0.70 && fh > 0.18 && fh < 0.75;

    return centered && goodSize;
  }

  Future<void> _captureAndGo({bool auto = false}) async {
    if (_isCapturing) return;
    _isCapturing = true;

    try {
      // ✅ stream stop before takePicture
      await _stopStreamSafely();

      final controller = _cameraController;
      if (controller != null && controller.value.isInitialized) {
        final file = await controller.takePicture();
        if (!mounted) return;

        setState(() => _selected = file);
        DocumentScanStore.setFaceCaptured(file.path);

        // ✅ await push, then if retake → resume stream
        await context.push(ConfirmFacePhotoScreen.routeName);

        if (!mounted) return;

        // if user retake (store cleared) → reset state & restart stream
        if (DocumentScanStore.faceImagePath == null) {
          setState(() {
            _selected = null;
            _stableFrames = 0;
            _faceAligned = false;
          });
          await _startFaceStream();
        }

        return;
      }

      // fallback
      final picked = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 100,
        preferredCameraDevice: CameraDevice.front,
      );
      if (picked == null || !mounted) return;

      setState(() => _selected = picked);
      DocumentScanStore.setFaceCaptured(picked.path);

      await context.push(ConfirmFacePhotoScreen.routeName);

      if (!mounted) return;
      if (DocumentScanStore.faceImagePath == null) {
        setState(() {
          _selected = null;
          _stableFrames = 0;
          _faceAligned = false;
        });
        await _startFaceStream();
      }
    } finally {
      _isCapturing = false; // ✅ ALWAYS reset
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color topOverlay = Color(0xFF1E2412);
    const Color bottomOverlay = Color(0xFF000000);
    const Color neon = Color(0xFFC6F151);

    final ringColor = _faceAligned ? neon : AllColor.white;

    return Scaffold(
      backgroundColor: const Color(0xFF0F0606),
      body: Stack(
        fit: StackFit.expand,
        children: [
          if (_selected != null)
            Image.file(File(_selected!.path), fit: BoxFit.cover)
          else if (_cameraController != null && _cameraController!.value.isInitialized)
            _CoverCameraPreview(controller: _cameraController!)
          else
            Image.asset("assets/images/face_photo.png", fit: BoxFit.cover),

          Positioned(
            left: 0,
            right: 0,
            top: 0,
            height: 260.h,
            child: Container(color: topOverlay.withOpacity(0.70)),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 290.h,
            child: Container(color: bottomOverlay.withOpacity(0.35)),
          ),

          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 10.h),

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
                          child: Icon(Icons.arrow_back, size: 24.sp, color: AllColor.black),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 18.h),

                  Text(
                    "Take your face photo",
                    style: TextStyle(
                      fontFamily: 'sf_pro',
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w500,
                      color: AllColor.white,
                      height: 1.1,
                    ),
                  ),

                  SizedBox(height: 10.h),

                  Text(
                    "Place your face into the marked area and\ntake a clear photo",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'sf_pro',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400,
                      color: AllColor.white.withOpacity(0.85),
                      height: 1.5,
                    ),
                  ),

                  SizedBox(height: 45.h),

                  Center(
                    child: Container(
                      width: 350.w,
                      height: 350.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: ringColor, width: 6.w),
                      ),
                    ),
                  ),

                  const Spacer(),

                  // ✅ ALWAYS clickable (manual capture)
                  Center(
                    child: InkWell(
                      onTap: () => _captureAndGo(auto: false),
                      borderRadius: BorderRadius.circular(999.r),
                      child: Container(
                        width: 54.w,
                        height: 54.w,
                        decoration: BoxDecoration(
                          color: neon,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              blurRadius: 14,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Icon(
                            Icons.photo_camera_outlined,
                            color: Colors.black,
                            size: 22.sp,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 24.h),

                  if (_cameraError != null && _selected == null)
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: Text(
                        "Camera issue: $_cameraError",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.75),
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CoverCameraPreview extends StatelessWidget {
  const _CoverCameraPreview({required this.controller});
  final CameraController controller;

  @override
  Widget build(BuildContext context) {
    final previewSize = controller.value.previewSize;
    if (previewSize == null) return const SizedBox.shrink();

    return ClipRect(
      child: OverflowBox(
        alignment: Alignment.center,
        child: FittedBox(
          fit: BoxFit.cover,
          child: SizedBox(
            width: previewSize.height,
            height: previewSize.width,
            child: CameraPreview(controller),
          ),
        ),
      ),
    );
  }
}
