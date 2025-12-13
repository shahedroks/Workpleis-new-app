import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/features/auth/screens/take_your_face_photo.dart';

import '../../../core/widget/global_get_started_button.dart';

class ConfirmDocumentTypeScanner extends StatelessWidget {
  const ConfirmDocumentTypeScanner({
    super.key,
    this.imagePath,
    this.documentName = 'Identity Card',
    this.onContinue,
    this.onTakeNewPhoto,
  });

  static const routeName = '/confirm-document-type';

  final String? imagePath;
  final String documentName;

  final VoidCallback? onContinue;
  final VoidCallback? onTakeNewPhoto;

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
              // Back button
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
                'Confirm document type',
                style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w500,
                  color: AllColor.black,
                  fontFamily: 'sf_pro',
                ),
              ),


              SizedBox(height: 10.h),

              // Subtitle with highlight
              RichText(
                text: TextSpan(
                  style: TextStyle(
                      fontSize: 18.sp,
                      height: 1.4,
                      color: AllColor.primary,
                      fontFamily: 'sf_pro',
                      fontWeight: FontWeight.w400
                  ),
                  children: [
                    TextSpan(text: 'Please have your ', style: TextStyle(
                        fontSize: 18.sp,
                        height: 1.4,
                        color: AllColor.black,
                        fontFamily: 'sf_pro',
                        fontWeight: FontWeight.w400
                    ), ),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 4.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: AllColor.primary,
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                        child: Text(
                          "Identity Card",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400,
                            color: AllColor.black,
                            fontFamily: 'sf_pro',
                            height: 1.4,
                          ),
                        ),
                      ),
                    ),
                    TextSpan(text: ' ready to verify',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w400,
                        color: AllColor.black,
                        fontFamily: 'sf_pro',
                        height: 1.4,
                      ),),
                  ],
                ),
              ),

              SizedBox(height: 18.h),

              // Image card
              Center(
                child: _DocImageCard(imagePath: imagePath),
              ),

              const Spacer(),

            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(22.w, 0, 22.w, 24.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: double.infinity,
              height: 56.h,
              child: CustomButton(
                text: "Start Verification",
                icon: Icons.arrow_forward,
                onTap: () {
                context.push(TakeYourFacePhoto.routeName);
                },
              ),
            ),

            SizedBox(height: 14.h),

            // ✅ নিচের text button (screenshot like)
            InkWell(
              onTap: onTakeNewPhoto ??
                      () {
                    // ✅ back to previous camera screen
                    context.pop();
                    // অথবা চাইলে: context.pushReplacement(Frontidentitycapturescreen.routeName);
                  },
              child: Text(
                "Take a new photo",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'sf_pro',
                  color: AllColor.black50,
                  decoration: TextDecoration.underline,
                  decorationThickness: 1.3,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

class _DocImageCard extends StatelessWidget {
  const _DocImageCard({required this.imagePath});

  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    final cardW = MediaQuery.of(context).size.width * 0.88;

    return Container(
      width: cardW,
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 18,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14.r),
        child: imagePath == null
            ? Image.asset(
          'assets/images/nid.png',
          height: 170.h,
          width: double.infinity,
          fit: BoxFit.cover,
        )
            : Image.file(
          File(imagePath!),
          height: 170.h,
          width: double.infinity,
          fit: BoxFit.cover,
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
  });

  final double size;
  final Color background;
  final IconData icon;
  final double iconSize;
  final Color iconColor;
  final VoidCallback? onTap;

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
          decoration: BoxDecoration(color: background, shape: BoxShape.circle),
          alignment: Alignment.center,
          child: Icon(icon, size: iconSize, color: iconColor),
        ),
      ),
    );
  }
}
