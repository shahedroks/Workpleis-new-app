import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../auth/screens/login_screen.dart';

import '../../auth/screens/business_login_screen.dart';
import '../screen/seclect_type_screen.dart';

import '../widget/custom_next_button.dart';

class Gennotifications extends ConsumerWidget {
  const Gennotifications({super.key});

  static const String routeName = '/notification';

  void _navigateToLogin(BuildContext context, WidgetRef ref) {
    final selectedType = ref.read(selectedTypeProvider);

    // If user selected "For Business" (either Client or Service Provider), go to BusinessLoginScreen
    // Service Provider + "For Business" should work the same as Client + "For Business" (create account flow)
    if (selectedType == UserType.business) {
      context.push(BusinessLoginScreen.routeName, extra: {'isBusiness': true});
    } else {
      // Otherwise go to regular LoginScreen
      context.push(LoginScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // main colors (approx same as UI)
    const Color kTitleGreen = Color(0xFF064E3B);
    const Color kHighlight = Color(0xFFE4FF5A);
    const Color kBodyText = Color(0xFF4B5563);
    const Color kPrimaryDark = Color(0xFF03051A);

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
                            width: 240.w,
                          ),
                          // Text on top of image - centered
                          Positioned.fill(
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 2.w,
                                  vertical: 2.h,
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
                    _navigateToLogin(context, ref);
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
                      _navigateToLogin(context, ref);
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
