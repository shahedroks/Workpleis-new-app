import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/widget/global_get_started_button.dart';
import 'package:workpleis/features/auth/screens/video_selfie_ready_screen.dart';

import '../../../core/constants/color_control/all_color.dart';
import '../data/front_id_data.dart';

class ConfirmFacePhotoScreen extends StatelessWidget {
  const ConfirmFacePhotoScreen({super.key});

  static const routeName = '/confirm-face-photo';

  // ✅ change this to your next screen route
  static const String nextRoute = '/liveness-check';

  @override
  Widget build(BuildContext context) {
    final img = DocumentScanStore.faceImagePath;
    const neon = Color(0xFFC6F151);

    return Scaffold(
      backgroundColor: AllColor.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10.h),
              Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: () {
                    DocumentScanStore.clearFaceCaptured();
                    context.pop();
                  },
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

              // ✅ Title with highlight
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

              SizedBox(height: 34.h),
              Spacer(),

              // ✅ Circle photo with neon ring
              Center(
                child: Container(
                  width: 320.w,
                  height: 320.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: neon, width: 8.w),
                  ),
                  child: ClipOval(
                    child: img == null
                        ? Image.asset(
                      "assets/images/face_photo.png",
                      fit: BoxFit.cover,
                    )
                        : Image.file(
                      File(img),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 120.h),
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
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 56.h,
                child: InkWell(
                  borderRadius: BorderRadius.circular(999.r),
                  onTap: () {
                    context.push(nextRoute);
                  },
                  child:CustomButton(
                      text: "I'm ready",
                      icon: Icons.arrow_forward,
                      onTap: (){
                        context.push(VideoSelfieReadyScreen.routeName);
                      }
                      ),

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
