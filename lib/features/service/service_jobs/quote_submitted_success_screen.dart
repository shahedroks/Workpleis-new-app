import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/features/service/service_jobs/service_quote_screen.dart';

class QuoteSubmittedSuccessScreen extends StatelessWidget {
  const QuoteSubmittedSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    // Your app uses ScreenUtil with designSize (430w). On smaller devices,
    // `180.w` becomes too small. Keep a minimum size so it matches the design.
    final imageSize = (screenWidth * 0.42).clamp(180.0, 220.0);

    return Scaffold(
      backgroundColor: AllColor.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/sucessfull.png',
                  width: imageSize,
                  height: imageSize,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 24.h),
                Text(
                  'Thanks! Your quote is\nunder review',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                    color: AllColor.black,
                    fontFamily: 'Inter',
                    height: 1.25,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 24.h),
          child: SizedBox(
            height: 56.h,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const ServiceQuoteScreen()),
                  (route) => route.isFirst,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AllColor.black50,
                foregroundColor: const Color(0xFFF5F5F5),
                elevation: 0,
                shape: const StadiumBorder(),
              ),
              child: Text(
                'Done',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Inter',
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
