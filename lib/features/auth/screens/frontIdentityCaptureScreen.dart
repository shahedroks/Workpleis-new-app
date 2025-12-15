import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';

import '../data/front_id_data.dart';
import 'confirm_document_type_scanner.dart';
import 'confrim_document_type_screen.dart';

class Frontidentitycapturescreen extends StatefulWidget {
  const Frontidentitycapturescreen({super.key});
  static const routeName = '/front-identity-capture';

  @override
  State<Frontidentitycapturescreen> createState() => _FrontidentitycapturescreenState();
}

class _FrontidentitycapturescreenState extends State<Frontidentitycapturescreen>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  final ImagePicker _picker = ImagePicker();

  CameraController? _cameraController;
  Future<void>? _cameraInit;
  String? _cameraError;

  XFile? _selected;

  Timer? _navTimer;
  bool _isPushing = false;

  late final AnimationController _scanCtrl;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _scanCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat(reverse: true);

    _initScannerCamera();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _navTimer?.cancel();
    _cameraController?.dispose();
    _scanCtrl.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    final controller = _cameraController;
    if (controller == null || !controller.value.isInitialized) return;

    if (state == AppLifecycleState.inactive || state == AppLifecycleState.paused) {
      try { await controller.pausePreview(); } catch (_) {}
    } else if (state == AppLifecycleState.resumed) {
      try { await controller.resumePreview(); } catch (_) {}
    }
  }

  Future<void> _initScannerCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        setState(() => _cameraError = "No camera found");
        return;
      }

      final back = cameras.firstWhere(
            (c) => c.lensDirection == CameraLensDirection.back,
        orElse: () => cameras.first,
      );

      final controller = CameraController(
        back,
        ResolutionPreset.high,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );

      setState(() {
        _cameraController = controller;
        _cameraInit = controller.initialize();
        _cameraError = null;
      });

      await _cameraInit;
      if (mounted) setState(() {});
    } catch (e) {
      if (mounted) setState(() => _cameraError = e.toString());
    }
  }

  Future<void> _captureFromScannerCamera() async {
    if (_cameraController == null || _cameraInit == null || !(_cameraController!.value.isInitialized)) {
      return _pickFromSystemCameraFallback();
    }

    try {
      await _cameraInit;
      final file = await _cameraController!.takePicture();
      setState(() => _selected = file);

      DocumentScanStore.setCaptured(file.path);
      _startAutoNavigateAfterScan();
    } catch (_) {
      await _pickFromSystemCameraFallback();
    }
  }

  Future<void> _pickFromSystemCameraFallback() async {
    final file = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 85,
      preferredCameraDevice: CameraDevice.rear,
    );
    if (file == null) return;

    setState(() => _selected = file);
    DocumentScanStore.setCaptured(file.path);
    _startAutoNavigateAfterScan();
  }

  Future<void> _pickFromGallery() async {
    final file = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    if (file == null) return;

    setState(() => _selected = file);
    DocumentScanStore.setCaptured(file.path);
    _startAutoNavigateAfterScan();
  }

  void _startAutoNavigateAfterScan() {
    _navTimer?.cancel();

    _navTimer = Timer(const Duration(seconds: 5), () async {
      if (!mounted) return;
      if (_isPushing) return;
      _isPushing = true;

      try { await _cameraController?.pausePreview(); } catch (_) {}

      await context.push(ConfirmDocumentTypeScanner.routeName);

      try { if (mounted) await _cameraController?.resumePreview(); } catch (_) {}
      if (mounted) _isPushing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AllColor.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),

              InkWell(
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

              SizedBox(height: 24.h),

              Text(
                'Front of In deity',
                style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w500,
                  color: AllColor.black,
                  fontFamily: 'sf_pro',
                ),
              ),

              SizedBox(height: 10.h),

              Text(
                'Place your document into the frame and take a\nclear photo',
                style: TextStyle(
                  fontFamily: 'sf_pro',
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400,
                  color: AllColor.black,
                  height: 1.4,
                ),
              ),

              SizedBox(height: 18.h),

              Expanded(
                child: Center(
                  child: _ScannerFrame(
                    imagePath: _selected?.path,
                    cameraController: _cameraController,
                    cameraError: _cameraError,
                    scanAnimation: _scanCtrl,
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(bottom: 18.h, top: 8.h),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: _CircleIconButton(
                        size: 46.r,
                        background: const Color(0xFFF2F2F2),
                        icon: Icons.file_upload_outlined,
                        iconSize: 22.sp,
                        iconColor: Colors.black,
                        onTap: _pickFromGallery,
                      ),
                    ),
                    _CircleIconButton(
                      size: 62.r,
                      background: const Color(0xFF0A1633),
                      icon: Icons.photo_camera_outlined,
                      iconSize: 26.sp,
                      iconColor: Colors.white,
                      onTap: _captureFromScannerCamera,
                      shadow: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ScannerFrame extends StatelessWidget {
  const _ScannerFrame({
    required this.imagePath,
    required this.cameraController,
    required this.cameraError,
    required this.scanAnimation,
  });

  final String? imagePath;
  final CameraController? cameraController;
  final String? cameraError;
  final Animation<double> scanAnimation;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.88;
    final height = width * 0.58;

    final bg = imagePath != null
        ? Image.file(
      File(imagePath!),
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
    )
        : (cameraController != null && cameraController!.value.isInitialized)
        ? ClipRect(
      child: OverflowBox(
        alignment: Alignment.center,
        child: FittedBox(
          fit: BoxFit.cover,
          child: SizedBox(
            width: cameraController!.value.previewSize?.height ?? width,
            height: cameraController!.value.previewSize?.width ?? height,
            child: CameraPreview(cameraController!),
          ),
        ),
      ),
    )
        : Center(
      child: Image.asset(
        DocumentScanStore.placeholderAsset,
        width: width,
        fit: BoxFit.contain,
      ),
    );

    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: Container(
              color: const Color(0xFFEDEDED),
              child: Stack(
                children: [
                  Positioned.fill(child: bg),
                  Positioned.fill(
                    child: _AnimatedScannerShade(
                      animation: scanAnimation,
                      borderRadius: 16.r,
                    ),
                  ),
                  if (cameraError != null && imagePath == null)
                    Positioned(
                      left: 10, right: 10, bottom: 10,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.55),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Camera error: $cameraError",
                          style: const TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),

          Positioned.fill(
            child: CustomPaint(
              painter: _CornerBracketPainter(
                color: AllColor.black,
                strokeWidth: 3,
                cornerLen: 18,
                radius: 16,
                inset: 4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimatedScannerShade extends StatelessWidget {
  const _AnimatedScannerShade({
    required this.animation,
    required this.borderRadius,
  });

  final Animation<double> animation;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: LayoutBuilder(
        builder: (context, c) {
          final h = c.maxHeight;
          final bandH = h * 0.28;

          return AnimatedBuilder(
            animation: animation,
            builder: (_, __) {
              final top = (h - bandH) * animation.value;

              return Stack(
                children: [
                  Positioned.fill(child: Container(color: Colors.black.withOpacity(0.03))),
                  Positioned(
                    left: 0, right: 0, top: top, height: bandH,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            AllColor.primary.withOpacity(0.18),
                            AllColor.primary.withOpacity(0.40),
                            AllColor.primary.withOpacity(0.18),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 15.w,
                    right: 15.w,
                    top: top + (bandH / 2) - 5.h,
                    child: SizedBox(
                      height: 10.h,
                      child: CustomPaint(
                        painter: _DashedLinePainter(
                          color: AllColor.black,
                          dashWidth: 15,
                          dashGap: 10,
                          strokeWidth: 3,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({
    required this.size,
    required this.background,
    required this.icon,
    required this.iconSize,
    required this.iconColor,
    required this.onTap,
    this.shadow = false,
  });

  final double size;
  final Color background;
  final IconData icon;
  final double iconSize;
  final Color iconColor;
  final VoidCallback onTap;
  final bool shadow;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(size / 2),
        onTap: onTap,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: background,
            shape: BoxShape.circle,
            boxShadow: shadow
                ? [
              BoxShadow(
                color: Colors.black.withOpacity(0.12),
                blurRadius: 14,
                offset: const Offset(0, 6),
              )
            ]
                : null,
          ),
          alignment: Alignment.center,
          child: Icon(icon, size: iconSize, color: iconColor),
        ),
      ),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  _DashedLinePainter({
    required this.color,
    required this.dashWidth,
    required this.dashGap,
    required this.strokeWidth,
  });

  final Color color;
  final double dashWidth;
  final double dashGap;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square;

    double startX = 0;
    final y = size.height / 2;

    while (startX < size.width) {
      final endX = (startX + dashWidth).clamp(0, size.width);
      canvas.drawLine(Offset(startX, y), Offset(y, y), paint); // ✅ FIXED
      startX += dashWidth + dashGap;
    }
  }

  @override
  bool shouldRepaint(covariant _DashedLinePainter oldDelegate) => false;
}

class _CornerBracketPainter extends CustomPainter {
  _CornerBracketPainter({
    required this.color,
    required this.strokeWidth,
    required this.cornerLen,
    required this.radius,
    this.inset = 0,
  });

  final Color color;
  final double strokeWidth;
  final double cornerLen;
  final double radius;
  final double inset;

  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final left = inset;
    final top = inset;
    final right = size.width - inset;
    final bottom = size.height - inset;

    canvas.drawLine(Offset(left + radius, top), Offset(left + radius + cornerLen, top), p);
    canvas.drawLine(Offset(left, top + radius), Offset(left, top + radius + cornerLen), p);

    canvas.drawLine(Offset(right - radius, top), Offset(right - radius - cornerLen, top), p);
    canvas.drawLine(Offset(right, top + radius), Offset(right, top + radius + cornerLen), p);

    canvas.drawLine(Offset(left, bottom - radius), Offset(left, bottom - radius - cornerLen), p);
    canvas.drawLine(Offset(left + radius, bottom), Offset(left + radius + cornerLen, bottom), p);

    canvas.drawLine(Offset(right, bottom - radius), Offset(right, bottom - radius - cornerLen), p);
    canvas.drawLine(Offset(right - radius, bottom), Offset(right - radius - cornerLen, bottom), p);
  }

  @override
  bool shouldRepaint(covariant _CornerBracketPainter oldDelegate) => false;
}





//
// import 'dart:async';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:go_router/go_router.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:workpleis/core/constants/color_control/all_color.dart';
// import 'package:workpleis/features/auth/screens/confirm_document_type_scanner.dart';
//
// // ✅ তোমার confirm screen route এখানে বসাও
// // Example: ConfirmDocumentScannerScreen.routeName = '/confirm-document-type';
// class ConfirmDocumentScannerScreen {
//   static const routeName = '/confirm-document-type';
// }
//
// class Frontidentitycapturescreen extends StatefulWidget {
//   const Frontidentitycapturescreen({super.key});
//   static const routeName = '/front-identity-capture';
//
//   @override
//   State<Frontidentitycapturescreen> createState() => _FrontidentitycapturescreenState();
// }
//
// class _FrontidentitycapturescreenState extends State<Frontidentitycapturescreen> {
//   final ImagePicker _picker = ImagePicker();
//   XFile? _selected;
//
//   Timer? _navTimer;
//   bool _isNavigating = false;
//
//   @override
//   void dispose() {
//     _navTimer?.cancel();
//     super.dispose();
//   }
//
//   Future<void> _pickFromCamera() async {
//     final file = await _picker.pickImage(
//       source: ImageSource.camera,
//       imageQuality: 85,
//       preferredCameraDevice: CameraDevice.rear,
//     );
//     if (file == null) return;
//
//     setState(() => _selected = file);
//
//     _startAutoNavigateAfterScan(file.path);
//   }
//
//   Future<void> _pickFromGallery() async {
//     final file = await _picker.pickImage(
//       source: ImageSource.gallery,
//       imageQuality: 85,
//     );
//     if (file == null) return;
//
//     setState(() => _selected = file);
//
//     _startAutoNavigateAfterScan(file.path);
//   }
//
//   void _startAutoNavigateAfterScan(String path) {
//     // ✅ prevent multiple triggers
//     if (_isNavigating) return;
//
//     _navTimer?.cancel();
//     _isNavigating = true;
//
//     // ✅ 5 seconds পরে confirm screen এ যাবে
//     _navTimer = Timer(const Duration(seconds: 5), () {
//       if (!mounted) return;
//       context.push(
//         ConfirmDocumentTypeScanner.routeName,
//         extra: {
//           "imagePath": path,
//           "documentName": "Identity Card",
//         },
//       );
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AllColor.white,
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 18.w),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: 10.h),
//
//               InkWell(
//                 onTap: () => context.pop(),
//                 borderRadius: BorderRadius.circular(14.r),
//                 child: Container(
//                   height: 40.w,
//                   width: 40.w,
//                   decoration: BoxDecoration(
//                     color: AllColor.grey70,
//                     borderRadius: BorderRadius.circular(14.r),
//                   ),
//                   child: Center(
//                     child: Icon(
//                       Icons.arrow_back,
//                       size: 24.sp,
//                       color: AllColor.black,
//                     ),
//                   ),
//                 ),
//               ),
//
//               SizedBox(height: 24.h),
//
//               Text(
//                 'Front of In deity',
//                 style: TextStyle(
//                   fontSize: 32.sp,
//                   fontWeight: FontWeight.w500,
//                   color: AllColor.black,
//                   fontFamily: 'sf_pro',
//                 ),
//               ),
//
//               SizedBox(height: 10.h),
//
//               Text(
//                 'Place your document into the frame and take a\nclear photo',
//                 style: TextStyle(
//                   fontFamily: 'sf_pro',
//                   fontSize: 18.sp,
//                   fontWeight: FontWeight.w400,
//                   color: AllColor.black,
//                   height: 1.4,
//                 ),
//               ),
//
//               SizedBox(height: 18.h),
//
//               Expanded(
//                 child: Center(
//                   child: _ScanFrame(
//                     imagePath: _selected?.path,
//                     overlayTopFraction: 0.47,
//                     overlayHeightFraction: 0.42,
//                   ),
//                 ),
//               ),
//
//               Padding(
//                 padding: EdgeInsets.only(bottom: 18.h, top: 8.h),
//                 child: Stack(
//                   alignment: Alignment.center,
//                   children: [
//                     Align(
//                       alignment: Alignment.centerLeft,
//                       child: _CircleIconButton(
//                         size: 46.r,
//                         background: const Color(0xFFF2F2F2),
//                         icon: Icons.file_upload_outlined,
//                         iconSize: 22.sp,
//                         iconColor: Colors.black,
//                         onTap: _pickFromGallery,
//                       ),
//                     ),
//                     _CircleIconButton(
//                       size: 62.r,
//                       background: const Color(0xFF0A1633),
//                       icon: Icons.photo_camera_outlined,
//                       iconSize: 26.sp,
//                       iconColor: Colors.white,
//                       onTap: _pickFromCamera,
//                       shadow: true,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class _CircleIconButton extends StatelessWidget {
//   const _CircleIconButton({
//     required this.size,
//     required this.background,
//     required this.icon,
//     required this.iconSize,
//     required this.iconColor,
//     required this.onTap,
//     this.shadow = false,
//   });
//
//   final double size;
//   final Color background;
//   final IconData icon;
//   final double iconSize;
//   final Color iconColor;
//   final VoidCallback onTap;
//   final bool shadow;
//
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colors.transparent,
//       child: InkWell(
//         borderRadius: BorderRadius.circular(size / 2),
//         onTap: onTap,
//         child: Container(
//           width: size,
//           height: size,
//           decoration: BoxDecoration(
//             color: background,
//             shape: BoxShape.circle,
//             boxShadow: shadow
//                 ? [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.12),
//                 blurRadius: 14,
//                 offset: const Offset(0, 6),
//               )
//             ]
//                 : null,
//           ),
//           alignment: Alignment.center,
//           child: Icon(icon, size: iconSize, color: iconColor),
//         ),
//       ),
//     );
//   }
// }
//
// class _ScanFrame extends StatelessWidget {
//   const _ScanFrame({
//     required this.imagePath,
//     required this.overlayTopFraction,
//     required this.overlayHeightFraction,
//   });
//
//   final String? imagePath;
//   final double overlayTopFraction;
//   final double overlayHeightFraction;
//
//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width * 0.88;
//     final height = width * 0.58;
//
//     return SizedBox(
//       width: width,
//       height: height,
//       child: Stack(
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(16.r),
//             child: Container(
//               color: const Color(0xFFEDEDED),
//               child: imagePath == null
//                   ? Center(
//                 child: Image.asset(
//                   "assets/images/nid.png",
//                   width: width,
//                   fit: BoxFit.contain,
//                 ),
//               )
//                   : Image.file(
//                 File(imagePath!),
//                 fit: BoxFit.cover,
//                 width: double.infinity,
//                 height: double.infinity,
//               ),
//             ),
//           ),
//
//           Positioned.fill(
//             child: CustomPaint(
//               painter: _CornerBracketPainter(
//                 color: AllColor.black,
//                 strokeWidth: 3,
//                 cornerLen: 18,
//                 radius: 16,
//                 inset: 4,
//               ),
//             ),
//           ),
//
//           Positioned(
//             left: 0,
//             right: 0,
//             top: height * overlayTopFraction,
//             height: height * overlayHeightFraction,
//             child: Container(
//               color: AllColor.primary.withOpacity(0.55),
//             ),
//           ),
//
//           Positioned(
//             left: 15.w,
//             right: 15.w,
//             top: height * overlayTopFraction,
//             child: SizedBox(
//               height: 10.h,
//               child: CustomPaint(
//                 painter: _DashedLinePainter(
//                   color: AllColor.black,
//                   dashWidth: 15,
//                   dashGap: 10,
//                   strokeWidth: 3,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _DashedLinePainter extends CustomPainter {
//   _DashedLinePainter({
//     required this.color,
//     required this.dashWidth,
//     required this.dashGap,
//     required this.strokeWidth,
//   });
//
//   final Color color;
//   final double dashWidth;
//   final double dashGap;
//   final double strokeWidth;
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = color
//       ..strokeWidth = strokeWidth
//       ..style = PaintingStyle.stroke
//       ..strokeCap = StrokeCap.square;
//
//     double startX = 0;
//     final y = size.height / 2;
//
//     while (startX < size.width) {
//       final endX = (startX + dashWidth).clamp(0, size.width);
//       canvas.drawLine(Offset(startX, y), Offset(y, y), paint); // ✅ correct dashed
//       startX += dashWidth + dashGap;
//     }
//   }
//
//   @override
//   bool shouldRepaint(covariant _DashedLinePainter oldDelegate) => false;
// }
//
// class _CornerBracketPainter extends CustomPainter {
//   _CornerBracketPainter({
//     required this.color,
//     required this.strokeWidth,
//     required this.cornerLen,
//     required this.radius,
//     this.inset = 0,
//   });
//
//   final Color color;
//   final double strokeWidth;
//   final double cornerLen;
//   final double radius;
//   final double inset;
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final p = Paint()
//       ..color = color
//       ..strokeWidth = strokeWidth
//       ..style = PaintingStyle.stroke
//       ..strokeCap = StrokeCap.round;
//
//     final left = inset;
//     final top = inset;
//     final right = size.width - inset;
//     final bottom = size.height - inset;
//
//     canvas.drawLine(Offset(left + radius, top), Offset(left + radius + cornerLen, top), p);
//     canvas.drawLine(Offset(left, top + radius), Offset(left, top + radius + cornerLen), p);
//
//     canvas.drawLine(Offset(right - radius, top), Offset(right - radius - cornerLen, top), p);
//     canvas.drawLine(Offset(right, top + radius), Offset(right, top + radius + cornerLen), p);
//
//     canvas.drawLine(Offset(left, bottom - radius), Offset(left, bottom - radius - cornerLen), p);
//     canvas.drawLine(Offset(left + radius, bottom), Offset(left + radius + cornerLen, bottom), p);
//
//     canvas.drawLine(Offset(right, bottom - radius), Offset(right, bottom - radius - cornerLen), p);
//     canvas.drawLine(Offset(right - radius, bottom), Offset(right - radius - cornerLen, bottom), p);
//   }
//
//   @override
//   bool shouldRepaint(covariant _CornerBracketPainter oldDelegate) => false;
// }
