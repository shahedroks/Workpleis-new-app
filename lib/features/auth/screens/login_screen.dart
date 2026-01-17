import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/core/widget/global_get_started_button.dart';
import 'package:workpleis/core/widget/global_snack_bar.dart';
import 'package:workpleis/features/auth/logic/email_valitedor.dart';
import 'package:workpleis/features/auth/logic/password_valitedor.dart';
import 'package:workpleis/features/auth/screens/business_login_screen.dart';
import 'package:workpleis/features/auth/screens/forget_password_screen.dart';
import 'package:workpleis/features/auth/screens/register_screen.dart';
import 'package:workpleis/features/nav_bar/screen/bottom_nav_bar.dart';

import '../../client/screen/client_home_screen.dart';
import '../logic/login_reverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key, this.isBusinessFlow = false});

  static const routeName = '/loginScreen';
  final bool isBusinessFlow;

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  bool _obscure = true;
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(loginLoadingProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 16.h),
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Logo
                SizedBox(height: 8.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Image.asset(
                    "assets/images/goloballogo.png",
                    height: 31.h,
                  ),
                ),
                SizedBox(height: 32.h),

                // ── Title
                Text(
                  'Log In',
                  style: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w500,
                    color: AllColor.black,
                    fontFamily: 'sf_pro',
                  ),
                ),
                SizedBox(height: 8.h),

                // ── Don't have account? Sign Up
                Row(
                  children: [
                    Text(
                      "Don’t have an account? ",
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AllColor.black,
                        fontFamily: "sf_pro",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (widget.isBusinessFlow) {
                          context.push(
                            BusinessLoginScreen.routeName,
                            extra: {'isBusiness': true},
                          );
                        } else {
                          context.push(
                            RegisterScreen.routeName,
                            extra: {'isBusiness': false},
                          );
                        }
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: AllColor.black,
                          fontFamily: "sf_pro",
                          fontWeight: FontWeight.w700,
                          decoration: TextDecoration.underline,
                          decorationColor: AllColor.black,
                          decorationThickness: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 28.h),

                // ── Email / Phone
                Text(
                  "Email / Phone",
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: const Color(0xff171717),
                    fontFamily: "sf_pro",
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8.h),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: emailValidator,
                  style: TextStyle(
                    color: AllColor.black,
                    fontFamily: "sf_pro",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Enter your email or phone',
                    hintStyle: TextStyle(
                      color: Colors.black.withOpacity(0.3),
                      fontSize: 16.sp,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: AllColor.grey50,
                        width: 1.2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: AllColor.black.withOpacity(0.8),
                        width: 1.4,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 1.4,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 1.4,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                // ── Password
                Text(
                  "Password",
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: const Color(0xff171717),
                    fontFamily: "sf_pro",
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8.h),
                TextFormField(
                  controller: _passController,
                  obscureText: _obscure,
                  validator: passwordValidator,
                  style: TextStyle(
                    color: AllColor.black,
                    fontFamily: "sf_pro",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscure = !_obscure;
                        });
                      },
                      icon: Icon(
                        _obscure ? Icons.visibility_off : Icons.visibility,
                      ),
                    ),
                    hintStyle: TextStyle(
                      color: Colors.black.withOpacity(0.3),
                      fontSize: 16.sp,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: AllColor.grey50,
                        width: 1.2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: AllColor.black.withOpacity(0.8),
                        width: 1.4,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 1.4,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 1.4,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                // ── Remember + Forgot
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: SizedBox(
                        height: 18.h,
                        width: 18.w,
                        child: Checkbox(
                          value: _rememberMe,
                          onChanged: (val) {
                            setState(() => _rememberMe = val ?? false);
                          },
                          activeColor: Colors.black.withOpacity(0.6),
                          checkColor: AllColor.white,
                          side: BorderSide(
                            color: Colors.black.withOpacity(0.6),
                            width: 1.5,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      "Remember Password",
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.black.withOpacity(0.87),
                        fontFamily: "sf_pro",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => context.push(ForgetPasswordScreen.routeName),
                      child: Text(
                        "Forgot Password",
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.black.withOpacity(0.87),
                          fontFamily: "sf_pro",
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.underline,
                          decorationColor: AllColor.black,
                          decorationThickness: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 32.h),
                // ── Login button  ✅ FIXED
                CustomButton(
                  text: isLoading ? "Please wait..." : "Login",
                  onTap: () {
                    context.push(BottomNavBar.routeName); // if (!isLoading) {
                    //   _submit();
                    // }
                  },
                  icon: Icons.arrow_forward,
                ),

                SizedBox(height: 20.h),
                // ── Or divider
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Text(
                      "Or",
                      style: TextStyle(
                        fontSize: 20.sp,
                        color: AllColor.black,
                        fontFamily: "sf_pro",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20.h),

                // ── Google button
                SocialLoginButton(
                  title: "Continue with Google",
                  iconPath: "assets/images/google.png",
                  onPressed: () {
                    // context.push(VeryfiyYourBusiness.routeName);
                  },
                ),

                SizedBox(height: 12.h),
                // ── Apple button
                SocialLoginButton(
                  title: "Continue with Apple",
                  iconPath: "assets/images/apple.png",
                  onPressed: () {},
                ),

                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    ref.read(loginLoadingProvider.notifier).state = true;

    final loginService = ref.read(loginProvider);
    final result = await loginService.login(
      _emailController.text.trim(),
      _passController.text.trim(),
    );
    ref.read(loginLoadingProvider.notifier).state = false;
    if (result["success"] == true) {
      GlobalSnackBar.show(
        context,
        title: "Success",
        message: result["message"] ?? "Login successful",
        type: CustomSnackType.success,
      );
      print("login done");
      context.go(ClientHomeScreen.routeName);
    } else {
      GlobalSnackBar.show(
        context,
        title: "Error",
        message: result["message"] ?? "Login failed",
        type: CustomSnackType.error,
      );
    }
  }
}

// Social login button
class SocialLoginButton extends StatelessWidget {
  final String title;
  final String iconPath;
  final VoidCallback onPressed;

  const SocialLoginButton({
    required this.title,
    required this.iconPath,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: const Color(0xffD6DFD5), width: 1),
        color: Colors.white,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20.r),
          onTap: onPressed,
          child: Row(
            children: [
              SizedBox(width: 14.w),
              SizedBox(height: 24.r, width: 24.r, child: Image.asset(iconPath)),
              const Spacer(),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: const Color(0xff02021D),
                  fontFamily: "sf_pro",
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
