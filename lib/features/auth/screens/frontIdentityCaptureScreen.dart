// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:go_router/go_router.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:workpleis/core/constants/color_control/all_color.dart';
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
//   Future<void> _pickFromCamera() async {
//     final file = await _picker.pickImage(
//       source: ImageSource.camera,
//       imageQuality: 85,
//       preferredCameraDevice: CameraDevice.rear,
//     );
//     if (file == null) return;
//     setState(() => _selected = file);
//   }
//
//   Future<void> _pickFromGallery() async {
//     final file = await _picker.pickImage(
//       source: ImageSource.gallery,
//       imageQuality: 85,
//     );
//     if (file == null) return;
//     setState(() => _selected = file);
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
//               // Back button (top-left) - screenshot like
//
//
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
//               /// Title
//               Text(
//                 'Front of In deity',
//                 style: TextStyle(
//                   fontSize: 32.sp,
//                   fontWeight: FontWeight.w500,
//                   color: AllColor.black,
//                   fontFamily: 'sf_pro',
//                 ),
//               ),
//               SizedBox(height: 18.h),
//
//
//               SizedBox(height: 10.h),
//
//               // Subtitle
//               Text(
//                 'Place your document into the frame and take a\nclear photo',
//                 style: TextStyle(
//                   fontFamily: 'FSPro',
//                   fontSize: 18.sp,
//                   fontWeight: FontWeight.w400,
//                   color: AllColor.black,
//                   height: 1.4,
//                 ),
//               ),
//
//               SizedBox(height: 18.h),
//
//               // Scan frame (center)
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
//               // Bottom buttons
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
//
//                     // Center Camera button
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
//           // Card / image
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
//           // Corner brackets
//           Positioned.fill(
//             child: CustomPaint(
//               painter: _CornerBracketPainter(
//                 color: AllColor.black,
//                 strokeWidth: 3,
//                 cornerLen: 18,
//                 radius: 16,
//                 inset: 4, // makes it look closer to screenshot
//               ),
//             ),
//           ),
//
//           // Green highlight overlay
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
//           // Dashed line (FIXED)
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
//       canvas.drawLine(Offset(startX, y), Offset(startX, y), paint); // ✅ fixed
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
//     // Top-left
//     canvas.drawLine(Offset(left + radius, top), Offset(left + radius + cornerLen, top), p);
//     canvas.drawLine(Offset(left, top + radius), Offset(left, top + radius + cornerLen), p);
//
//     // Top-right
//     canvas.drawLine(Offset(right - radius, top), Offset(right - radius - cornerLen, top), p);
//     canvas.drawLine(Offset(right, top + radius), Offset(right, top + radius + cornerLen), p);
//
//     // Bottom-left
//     canvas.drawLine(Offset(left, bottom - radius), Offset(left, bottom - radius - cornerLen), p);
//     canvas.drawLine(Offset(left + radius, bottom), Offset(left + radius + cornerLen, bottom), p);
//
//     // Bottom-right
//     canvas.drawLine(Offset(right, bottom - radius), Offset(right, bottom - radius - cornerLen), p);
//     canvas.drawLine(Offset(right - radius, bottom), Offset(right - radius - cornerLen, bottom), p);
//   }
//
//   @override
//   bool shouldRepaint(covariant _CornerBracketPainter oldDelegate) => false;
// }

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/features/auth/screens/confirm_document_type_scanner.dart';

// ✅ তোমার confirm screen route এখানে বসাও
// Example: ConfirmDocumentScannerScreen.routeName = '/confirm-document-type';
class ConfirmDocumentScannerScreen {
  static const routeName = '/confirm-document-type';
}

class Frontidentitycapturescreen extends StatefulWidget {
  const Frontidentitycapturescreen({super.key});
  static const routeName = '/front-identity-capture';

  @override
  State<Frontidentitycapturescreen> createState() => _FrontidentitycapturescreenState();
}

class _FrontidentitycapturescreenState extends State<Frontidentitycapturescreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _selected;

  Timer? _navTimer;
  bool _isNavigating = false;

  @override
  void dispose() {
    _navTimer?.cancel();
    super.dispose();
  }

  Future<void> _pickFromCamera() async {
    final file = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 85,
      preferredCameraDevice: CameraDevice.rear,
    );
    if (file == null) return;

    setState(() => _selected = file);

    _startAutoNavigateAfterScan(file.path);
  }

  Future<void> _pickFromGallery() async {
    final file = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    if (file == null) return;

    setState(() => _selected = file);

    _startAutoNavigateAfterScan(file.path);
  }

  void _startAutoNavigateAfterScan(String path) {
    // ✅ prevent multiple triggers
    if (_isNavigating) return;

    _navTimer?.cancel();
    _isNavigating = true;

    // ✅ 5 seconds পরে confirm screen এ যাবে
    _navTimer = Timer(const Duration(seconds: 5), () {
      if (!mounted) return;
      context.push(
        ConfirmDocumentTypeScanner.routeName,
        extra: {
          "imagePath": path,
          "documentName": "Identity Card",
        },
      );
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
                    child: Icon(
                      Icons.arrow_back,
                      size: 24.sp,
                      color: AllColor.black,
                    ),
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
                  child: _ScanFrame(
                    imagePath: _selected?.path,
                    overlayTopFraction: 0.47,
                    overlayHeightFraction: 0.42,
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
                      onTap: _pickFromCamera,
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

class _ScanFrame extends StatelessWidget {
  const _ScanFrame({
    required this.imagePath,
    required this.overlayTopFraction,
    required this.overlayHeightFraction,
  });

  final String? imagePath;
  final double overlayTopFraction;
  final double overlayHeightFraction;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.88;
    final height = width * 0.58;

    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: Container(
              color: const Color(0xFFEDEDED),
              child: imagePath == null
                  ? Center(
                child: Image.asset(
                  "assets/images/nid.png",
                  width: width,
                  fit: BoxFit.contain,
                ),
              )
                  : Image.file(
                File(imagePath!),
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
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

          Positioned(
            left: 0,
            right: 0,
            top: height * overlayTopFraction,
            height: height * overlayHeightFraction,
            child: Container(
              color: AllColor.primary.withOpacity(0.55),
            ),
          ),

          Positioned(
            left: 15.w,
            right: 15.w,
            top: height * overlayTopFraction,
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
      canvas.drawLine(Offset(startX, y), Offset(y, y), paint); // ✅ correct dashed
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
