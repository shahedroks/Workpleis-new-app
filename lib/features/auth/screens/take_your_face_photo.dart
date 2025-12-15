import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/constants/color_control/all_color.dart';

class TakeYourFacePhoto extends StatefulWidget {
  const TakeYourFacePhoto({super.key});
  static const routeName = '/take-face-photo';

  @override
  State<TakeYourFacePhoto> createState() => _TakeYourFacePhotoState();
}

class _TakeYourFacePhotoState extends State<TakeYourFacePhoto> {
  final ImagePicker _picker = ImagePicker();
  XFile? _selected;

  Future<void> _takePhoto() async {
    final file = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 100,
      preferredCameraDevice: CameraDevice.front,
    );
    if (file == null) return;
    setState(() => _selected = file);
  }

  @override
  Widget build(BuildContext context) {
    // screenshot-like colors
    const Color topOverlay = Color(0xFF1E2412); // dark olive overlay
    const Color bottomOverlay = Color(0xFF000000); // black overlay
    const Color neon = Color(0xFFC6F151); // neon camera button bg

    return Scaffold(
      backgroundColor: Color(0xFF0F0606),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image (placeholder/selected)
          _selected == null
              ? Image.asset(
            "assets/images/face_photo.png",
            fit: BoxFit.cover,
          )
              : Image.file(
            File(_selected!.path),
            fit: BoxFit.cover,
          ),

          // Top dark overlay
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            height: 260.h,
            child: Container(
              color: topOverlay.withOpacity(0.70),
            ),
          ),

          // Bottom dark overlay
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 290.h,
            child: Container(
              color: bottomOverlay.withOpacity(0.35),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: Column(

                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 10.h),

                  // Back button
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
                          child: Icon(
                            Icons.arrow_back,
                            size: 24.sp,
                            color: AllColor.black,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 18.h),

                  // Title
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

                  // Subtitle
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
                  // Space to circle frame area
                  SizedBox(height: 45.h),

                  // Circle frame (white ring)
                  Center(
                    child: Container(
                      width: 350.w,
                      height: 350.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AllColor.white,
                          width: 6.w,
                        ),
                      ),
                    ),
                  ),

                  const Spacer(),

                  // Camera button bottom center
                  Center(
                    child: InkWell(
                      onTap: _takePhoto,
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
