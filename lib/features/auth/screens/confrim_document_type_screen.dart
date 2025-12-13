import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/features/auth/screens/frontIdentityCaptureScreen.dart';

import '../../../core/widget/global_get_started_button.dart';

class ConfirmDocumentTypeScreen extends StatelessWidget {
  const ConfirmDocumentTypeScreen({
    super.key,});

  static const String routeName = '/confirmDocumentType';
  

  @override
  Widget build(BuildContext context) {

    const secondaryText = Color(0xFF6B6B6B);
    const pillColor = Color(0xFF02021D);

    return Scaffold(
      backgroundColor: AllColor.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Back button
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
              /// Title
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
              /// Subtitle with highlighted document name
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 18.sp,
                    height: 1.4,
                    color: secondaryText,
                    fontFamily: 'sf_pro',
                    fontWeight: FontWeight.w400
                  ),
                  children: [
                     TextSpan(text: 'Please have your ', style: TextStyle(
                         fontSize: 18.sp,
                         height: 1.4,
                         color: secondaryText,
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

              SizedBox(height: 40.h),

              /// Big document icon
              Center(
                child: SvgPicture.asset(
                  'assets/images/passportv.svg',
                  height: 100.h,
                  width: 100.h,
                  fit: BoxFit.cover,
                ),
              ),

              SizedBox(height: 40.h),

              Text(
                'Identification will take 3 steps:',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w500,
                  color: AllColor.black,
                  fontFamily: 'sf_pro',
                ),
              ),
              SizedBox(height: 16.h),

              const _StepRow(
                index: 1,
                text: 'Document front photo',
              ),
              SizedBox(height: 10.h),
              const _StepRow(
                index: 2,
                text: 'Face photo',
              ),
              SizedBox(height: 10.h),
              const _StepRow(
                index: 3,
                text: 'Liveness check',
              ),

              const Spacer(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(22.w, 0, 22.w, 24.h),
        child: SizedBox(
          width: double.infinity,
          height: 56.h,
          child: CustomButton(
            text: "Start Verification",
            icon: Icons.arrow_forward,
            onTap: () {
             context.push(Frontidentitycapturescreen.routeName);
            },
          ),
        ),
      ),

    );
  }
}

class _StepRow extends StatelessWidget {
  final int index;
  final String text;

  const _StepRow({
    required this.index,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    const primaryText = Color(0xFF111111);
    const pillColor = Color(0xFF02021D);

    return Row(
      children: [
        Container(
          height: 26.r,
          width: 26.r,
          decoration: const BoxDecoration(
            color: pillColor,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            '$index',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: AllColor.primary,
              fontFamily: 'sf_pro',
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w400,
              color: AllColor.black,
              fontFamily: 'sf_pro',
            ),
          ),
        ),
      ],
    );
  }
}
