import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';

class AccountAddScreen extends StatelessWidget {
  const AccountAddScreen({super.key});

  static const String routeName = '/account_add';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AllColor.white,
      body: SafeArea(
        child: Column(
          children: [
            _Header(
              title: 'Account Add',
              onBack: () => Navigator.maybePop(context),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  children: [
                    SizedBox(height: 40.h),
                    Image.asset(
                      'assets/images/add_account.png',
                      height: 415.h,

                    ),
                    SizedBox(height: 40.h),
                    Text(
                      'Add Account',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'sf_pro',
                        fontWeight: FontWeight.w700,
                        fontSize: 24.sp,
                        color: AllColor.black,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'Now that you estimated some expenses, let\'s see how much money you have right now',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'sf_pro',
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                        color: const Color(0xFF5F5F5F),
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SafeArea(
              top: false,
              child: Padding(
                padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 24.h),
                child: _AddAccountButton(
                  onTap: () {
                    // TODO: Handle add account action
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final String title;
  final VoidCallback onBack;

  const _Header({
    required this.title,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(24.w, 18.h, 24.w, 12.h),
      child: SizedBox(
        height: 40.h,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onBack,
                  borderRadius: BorderRadius.circular(8.r),
                  child: Ink(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFE0E0E0)),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(
                      Icons.arrow_back,
                      size: 20.sp,
                      color: const Color(0xFF111111),
                    ),
                  ),
                ),
              ),
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'sf_pro',
                fontWeight: FontWeight.w600,
                fontSize: 18.sp,
                color: AllColor.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddAccountButton extends StatelessWidget {
  final VoidCallback onTap;

  const _AddAccountButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Material(
        color: AllColor.black,
        borderRadius: BorderRadius.circular(999.r),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(999.r),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: Center(
              child: Text(
                'Add Account',
                style: TextStyle(
                  fontFamily: 'sf_pro',
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                  color: AllColor.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
