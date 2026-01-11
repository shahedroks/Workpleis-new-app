import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// ROLE CARD
class RoleCard extends StatelessWidget {
  const RoleCard({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final borderColor = selected
        ? Colors.black
        : Colors.black.withOpacity(0.18);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60.h,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: borderColor, width: 1.2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 16.sp,
                fontFamily: 'sf_Pro',
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),

            // circle check
            Container(
              height: 22.r,
              width: 22.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected
                      ? Colors.black
                      : Colors.black.withOpacity(0.25),
                  width: 1.4,
                ),
                color: selected ? Colors.black : Colors.transparent,
              ),
              child: selected
                  ? Icon(Icons.check, size: 16.sp, color: Colors.white)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
