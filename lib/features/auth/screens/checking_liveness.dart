import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/color_control/all_color.dart';

class CheckingLiveness extends StatelessWidget {
  const CheckingLiveness({super.key});

  static const String routeName = '/checking-liveness';

  @override
  Widget build(BuildContext context) {
    const neon = Color(0xFFC6F151);

    return Scaffold(
      backgroundColor: AllColor.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.w),
          child: Column(
            children: [
              SizedBox(height: 150.h),

              /// ✅ Neon check circle (same-to-same)
              const _NeonCheckBadge(neon: neon),

              SizedBox(height: 18.h),

              Text(
                "Checking liveness...",
                style: TextStyle(
                  fontFamily: 'sf_pro',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AllColor.black,
                ),
              ),

              SizedBox(height: 12.h),

              /// ✅ Progress bar (rounded)
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 0.42), // screenshot-ish fill
                duration: const Duration(milliseconds: 900),
                curve: Curves.easeOut,
                builder: (context, v, _) => _ProgressBar(value: v),
              ),

              const Spacer(),

              /// ✅ Workpleis logo (use your asset path)
              Image.asset(
                "assets/images/workpleis_logo.png",
                width: 160.w,
                fit: BoxFit.contain,
              ),

              SizedBox(height: 36.h),
            ],
          ),
        ),
      ),
    );
  }
}

class _NeonCheckBadge extends StatelessWidget {
  const _NeonCheckBadge({required this.neon});

  final Color neon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90.w,
      height: 90.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // outer soft ring
          Container(
            width: 90.w,
            height: 90.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: neon.withOpacity(0.18),
            ),
          ),
          // mid ring
          Container(
            width: 62.w,
            height: 62.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: neon.withOpacity(0.35),
            ),
          ),
          // inner solid
          Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: neon,
            ),
          ),
          Icon(
            Icons.check,
            size: 18.sp,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({required this.value});

  final double value; // 0..1

  @override
  Widget build(BuildContext context) {
    final v = value.clamp(0.0, 1.0);

    return ClipRRect(
      borderRadius: BorderRadius.circular(999.r),
      child: Container(
        height: 8.h,
        width: double.infinity,
        color: const Color(0xFFE6E6E6),
        alignment: Alignment.centerLeft,
        child: FractionallySizedBox(
          widthFactor: v,
          child: Container(color: Colors.black),
        ),
      ),
    );
  }
}
