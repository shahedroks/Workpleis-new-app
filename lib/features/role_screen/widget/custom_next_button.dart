import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// CUSTOM NEXT BUTTON
class CustomNextButton extends StatelessWidget {
  const CustomNextButton({
    super.key,
    required this.enabled,
    required this.onPressed,
    this.text = 'Next',
    this.showArrow = true,
    this.fontWeight = FontWeight.w500,
  });

  final bool enabled;
  final VoidCallback onPressed;
  final String text;
  final bool showArrow;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onPressed : null,
      child: Container(
        width: double.infinity,
        height: 56.h,
        decoration: BoxDecoration(
          color: enabled
              ? const Color(0xFF03051A)
              : const Color(0xFF03051A).withOpacity(0.3),
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: fontWeight,
                fontFamily: 'sf_Pro',
                color: Colors.white,
              ),
            ),
            if (showArrow) ...[
              SizedBox(width: 8.w),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16.sp,
                color: Colors.white,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// update this code  b
