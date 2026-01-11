import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../auth/screens/login_screen.dart';
import '../widget/custom_next_button.dart';

class Gennotifications extends StatelessWidget {
  const Gennotifications({super.key});

  static const String routeName = '/notification';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// top logo
                Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: Image.asset(
                    'assets/images/splashlogo.png',
                    height: 47.h,
                    fit: BoxFit.contain,
                  ),
                ),

                SizedBox(height: 40.h),

                /// bell icon
                Center(
                  child: Image.asset(
                    'assets/images/getNotification.png',
                    height: 150.h,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 32.h),

                /// title with highlight
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Get notified when',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 40.sp,
                          fontFamily: 'sf_Pro',
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF064E3B),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Stack(
                        alignment: Alignment.center,
                        clipBehavior: Clip.none,
                        children: [
                          // Background image - organic shape
                          Image.asset(
                            'assets/images/Unerline.png',
                            fit: BoxFit.contain,
                            width: double.infinity,
                          ),
                          // Text on top of image - centered
                          Positioned.fill(
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20.w,
                                  vertical: 12.h,
                                ),
                                child: Text(
                                  "it's payday.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 40.sp,
                                    fontFamily: 'sf_Pro',
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF064E3B),
                                    letterSpacing: -0.5,
                                    height: 1.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16.h),

                /// subtitle
                Center(
                  child: Text(
                    "Enable notifications and we’ll let\n"
                    "you know the moment your\n"
                    "payout is ready.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontFamily: 'sf_Pro',
                      fontWeight: FontWeight.w500,
                      height: 1.35,
                      color: const Color(0xFF4B5563),
                    ),
                  ),
                ),

                SizedBox(height: 32.h),

                /// Enable notifications button
                SizedBox(height: 180.h),

                CustomNextButton(
                  enabled: true,
                  onPressed: () {
                    context.push(LoginScreen.routeName);
                  },
                  text: 'Enable notifications',
                  showArrow: false,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: 16.h),

                /// Skip
                Center(
                  child: TextButton(
                    onPressed: () {
                      context.push(LoginScreen.routeName);
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.black,
                      padding: EdgeInsets.zero,
                    ),
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontFamily: 'sf_Pro',
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
