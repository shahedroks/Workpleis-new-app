import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/features/role_screen/screen/seclect_type_screen.dart';
import 'package:workpleis/features/role_screen/widget/custom_next_button.dart';
import 'package:workpleis/features/role_screen/widget/role_card.dart';

enum UserRole { client, provider }

class SeclectRoleScreen extends StatefulWidget {
  const SeclectRoleScreen({super.key});

  static const String routeName = '/role_selection';

  @override
  State<SeclectRoleScreen> createState() => _SeclectRoleScreenState();
}

class _SeclectRoleScreenState extends State<SeclectRoleScreen> {
  UserRole? _selected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // top logo
                      Padding(
                        padding: EdgeInsets.only(top: 8.h),
                        child: Image.asset(
                          'assets/images/splashlogo.png',
                          height: 47.h,
                        ),
                      ),

                      SizedBox(height: 36.h),

                      // center icon
                      Center(
                        child: Image.asset(
                          'assets/images/roleicon.png',
                          height: 115.h,
                        ),
                      ),

                      SizedBox(height: 32.h),

                      Center(
                        child: Text(
                          'Select your role',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 40.sp,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'sf_Pro',
                            color: Colors.black,
                          ),
                        ),
                      ),

                      SizedBox(height: 8.h),

                      Center(
                        child: Text(
                          'A  Sustainable Marketplace For\nBusinesses',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'sf_Pro',
                            color: Colors.black.withOpacity(0.6),
                            height: 1.3,
                          ),
                        ),
                      ),

                      SizedBox(height: 32.h),

                      RoleCard(
                        label: "I'm a Client",
                        selected: _selected == UserRole.client,
                        onTap: () {
                          setState(() => _selected = UserRole.client);
                        },
                      ),

                      SizedBox(height: 16.h),

                      RoleCard(
                        label: "I'm Service Provider",
                        selected: _selected == UserRole.provider,
                        onTap: () {
                          setState(() => _selected = UserRole.provider);
                        },
                      ),

                      SizedBox(height: 32.h),

                      // button
                      SizedBox(height: 180.h),
                      CustomNextButton(
                        enabled: _selected != null,
                        onPressed: () =>
                            context.push(SeclectTypeScreen.routeName),
                      ),

                      SizedBox(height: 16.h),

                      Center(
                        child: TextButton(
                          onPressed: () =>
                              context.push(SeclectTypeScreen.routeName),
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.black,
                          ),
                          child: Text(
                            'Skip',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontFamily: 'sf_Pro',
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 16.h),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
