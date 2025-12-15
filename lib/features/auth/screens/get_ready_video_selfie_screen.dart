import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';

class GetReadyVideoSelfieScreen extends StatelessWidget {
  const GetReadyVideoSelfieScreen({
    super.key,
    this.imagePath, // optional: file path
    this.assetImage = 'assets/images/face_photo.png', // fallback
    this.onReady,
  });

  static const routeName = '/get-ready-video-selfie';

  final String? imagePath;
  final String assetImage;
  final VoidCallback? onReady;

  @override
  Widget build(BuildContext context) {
    const Color highlight = Color(0xFFC6F151); // neon highlight
    const Color navy = Color(0xFF0A1633); // button bg
    const Color hint = Color(0xFF6B7280); // light gray text

    return Scaffold(
      backgroundColor: AllColor.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: Column(
            children: [
              SizedBox(height: 10.h),

              // Top left close button
              Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: () => context.pop(),
                  borderRadius: BorderRadius.circular(14.r),
                  child: Container(
                    height: 40.w,
                    width: 40.w,
                    decoration: BoxDecoration(
                      color: AllColor.grey70, // your light grey
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.close,
                        size: 22.sp,
                        color: AllColor.black,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 40.h),

              // Title with highlight word
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    fontFamily: 'sf_pro',
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w700,
                    color: AllColor.black,
                    height: 1.15,
                  ),
                  children: [
                    const TextSpan(text: 'Get ready for your\n'),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: highlight,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Text(
                          'video selfie',
                          style: TextStyle(
                            fontFamily: 'sf_pro',
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w700,
                            color: AllColor.black,
                            height: 1.1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 34.h),

              // Circular photo with neon ring
              Center(
                child: Container(
                  width: 190.w,
                  height: 190.w,
                  padding: EdgeInsets.all(6.w),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: highlight,
                  ),
                  child: ClipOval(
                    child: _buildImage(),
                  ),
                ),
              ),
              const Spacer(),
              // Helper text
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                child: Text(
                  'Please frame your face in the small\noval, then the big oval',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'sf_pro',
                    fontSize: 12.5.sp,
                    fontWeight: FontWeight.w400,
                    color: hint,
                    height: 1.4,
                  ),
                ),
              ),

              SizedBox(height: 14.h),

              // Bottom pill button
              Padding(
                padding: EdgeInsets.only(bottom: 18.h),
                child: InkWell(
                  onTap: onReady ?? () {},
                  borderRadius: BorderRadius.circular(999.r),
                  child: Container(
                    width: double.infinity,
                    height: 56.h,
                    decoration: BoxDecoration(
                      color: navy,
                      borderRadius: BorderRadius.circular(999.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "I'm ready",
                          style: TextStyle(
                            fontFamily: 'sf_pro',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 18.sp),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    if (imagePath != null && imagePath!.isNotEmpty) {
      return Image.file(
        File(imagePath!),
        fit: BoxFit.cover,
      );
    }
    return Image.asset(
      assetImage,
      fit: BoxFit.cover,
    );
  }
}
