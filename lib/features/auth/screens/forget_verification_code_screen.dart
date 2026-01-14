// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import 'package:workpleis/core/constants/color_control/all_color.dart';
// import 'package:workpleis/core/widget/global_get_started_button.dart';
// import 'package:workpleis/features/auth/screens/new_password_screen.dart';
// import 'package:workpleis/features/auth/screens/select_document_screen.dart';
//
// import '../data/auth_flow_provider.dart';
//
// class ForgetVerificationCodeScreen extends ConsumerStatefulWidget {
//   const ForgetVerificationCodeScreen({super.key});
//
//   static const String routeName = '/forgetVerificationCodeScreen';
//
//   @override
//   ConsumerState<ForgetVerificationCodeScreen> createState() =>
//       _ForgetVerificationCodeScreenState();
// }
//
// class _ForgetVerificationCodeScreenState
//     extends ConsumerState<ForgetVerificationCodeScreen> {
//   final _formKey = GlobalKey<FormState>();
//
//   final List<TextEditingController> _controllers =
//   List.generate(6, (_) => TextEditingController());
//   final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
//
//   @override
//   void dispose() {
//     for (final c in _controllers) {
//       c.dispose();
//     }
//     for (final f in _focusNodes) {
//       f.dispose();
//     }
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 16.h),
//           physics: const BouncingScrollPhysics(),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: 4.h),
//                 /// Back button
//                 InkWell(
//                   onTap: () => context.pop(),
//                   borderRadius: BorderRadius.circular(14.r),
//                   child: Container(
//                     height: 40.w,
//                     width: 40.w,
//                     decoration: BoxDecoration(
//                       color: AllColor.grey70,
//                       borderRadius: BorderRadius.circular(14.r),
//                     ),
//                     child: Center(
//                       child: Icon(
//                         Icons.arrow_back,
//                         size: 24.sp,
//                         color: const Color(0xff111111),
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 SizedBox(height: 24.h),
//
//                 /// Title
//                 Text(
//                   '6- digit code',
//                   style: TextStyle(
//                     fontSize: 32.sp,
//                     fontWeight: FontWeight.w500,
//                     color: AllColor.black,
//                     fontFamily: 'sf_pro',
//                   ),
//                 ),
//                 SizedBox(height: 8.h),
//
//                 /// Subtitle
//                 Text(
//                   "To confirm your phone number, please enter the\n"
//                       "OTP we sent +016 ********13",
//                   style: TextStyle(
//                     fontSize: 18.sp,
//                     height: 1.5,
//                     color: AllColor.black,
//                     fontFamily: 'sf_pro',
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//
//                 SizedBox(height: 32.h),
//
//                 /// OTP boxes + dash
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     _buildOtpBox(0),
//                     SizedBox(width: 6.w),
//                     _buildOtpBox(1),
//                     SizedBox(width: 6.w),
//                     _buildOtpBox(2),
//                     SizedBox(width: 4.w),
//                     _buildDash(),
//                     SizedBox(width: 4.w),
//                     _buildOtpBox(3),
//                     SizedBox(width: 6.w),
//                     _buildOtpBox(4),
//                     SizedBox(width: 6.w),
//                     _buildOtpBox(5),
//                   ],
//                 ),
//                 SizedBox(height: 80.h),
//               ],
//             ),
//           ),
//         ),
//       ),
//       /// Bottom button
//       bottomNavigationBar: Padding(
//         padding: EdgeInsets.fromLTRB(22.w, 0, 22.w, 24.h),
//         child: SizedBox(
//           width: double.infinity,
//           height: 56.h,
//           child: CustomButton(
//             text: "Continue",
//             icon: Icons.arrow_forward,
//             onTap: _onContinue,
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _onContinue() {
//     final code = _controllers.map((c) => c.text.trim()).join();
//
//     if (code.length != 6) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please enter the 6-digit code')),
//       );
//       return;
//     }
//
//     final flow = ref.read(otpEntryFlowProvider);
//
//     if (flow == OtpEntryFlow.forgotPassword) {
//       context.push(NewPasswordScreen.routeName);
//     } else {
//       // default / phoneVerification
//       context.push(SelectDocumentScreen.routeName);
//     }
//
//     // optional: reset
//     ref.read(otpEntryFlowProvider.notifier).state = null;
//   }
//   /// Single OTP box
//   Widget _buildOtpBox(int index) {
//     return SizedBox(
//       width: 54.w,
//       height: 54.h,
//       child: TextFormField(
//         controller: _controllers[index],
//         focusNode: _focusNodes[index],
//         keyboardType: TextInputType.number,
//         textAlign: TextAlign.center,
//         maxLength: 1,
//         style: TextStyle(
//           fontSize: 18.sp,
//           color: const Color(0xff111111),
//           fontFamily: 'sf_pro',
//           fontWeight: FontWeight.w400,
//         ),
//         decoration: InputDecoration(
//           counterText: '',
//           filled: true,
//           fillColor: const Color(0xffF7F7F7),
//           contentPadding: EdgeInsets.zero,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(16.r),
//             borderSide: const BorderSide(color: Color(0xffE5E5EA)),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(16.r),
//             borderSide: BorderSide(color: AllColor.grey50, width: 1),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(16.r),
//             borderSide: BorderSide(color: AllColor.grey50, width: 1.2),
//           ),
//         ),
//         onChanged: (value) {
//           if (value.length == 1 && index < 5) {
//             _focusNodes[index + 1].requestFocus();
//           }
//           if (value.isEmpty && index > 0) {
//             _focusNodes[index - 1].requestFocus();
//           }
//         },
//       ),
//     );
//   }
//
//   /// Middle dash bar
//   Widget _buildDash() {
//     return Container(
//       width: 24.w,
//       height: 3.h,
//       decoration: BoxDecoration(
//         color: AllColor.black,
//         borderRadius: BorderRadius.circular(999.r),
//       ),
//     );
//   }
// }

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/core/widget/global_get_started_button.dart';
import 'package:workpleis/features/auth/screens/new_password_screen.dart';
import 'package:workpleis/features/auth/screens/select_document_screen.dart';
import 'package:workpleis/features/auth/screens/service_provider_verify_business.dart';

// ✅ Providers
import 'package:workpleis/features/auth/data/auth_flow_provider.dart';
import '../../role_screen/screen/seclect_role_screen.dart' hide UserRole;
import '../../role_screen/screen/seclect_type_screen.dart';
import '../data/select_your_type_provider.dart';

class ForgetVerificationCodeScreen extends ConsumerStatefulWidget {
  const ForgetVerificationCodeScreen({super.key});

  static const String routeName = '/forgetVerificationCodeScreen';

  @override
  ConsumerState<ForgetVerificationCodeScreen> createState() =>
      _ForgetVerificationCodeScreenState();
}

class _ForgetVerificationCodeScreenState
    extends ConsumerState<ForgetVerificationCodeScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  final List<TextEditingController> _controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  bool _showOtpPopup = false;
  Timer? _popupTimer;
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Animation setup
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
        );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    // Show popup will be triggered when OTP is available
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    _popupTimer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  void _showOtpNotification() {
    setState(() {
      _showOtpPopup = true;
    });
    _animationController.forward();

    // Auto-dismiss after 10 seconds
    _popupTimer?.cancel();
    _popupTimer = Timer(const Duration(seconds: 30), () {
      _hideOtpNotification();
    });
  }

  void _hideOtpNotification() {
    _animationController.reverse().then((_) {
      if (mounted) {
        setState(() {
          _showOtpPopup = false;
        });
      }
    });
  }

  void _onContinue() {
    final code = _controllers.map((c) => c.text.trim()).join();

    if (code.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter the 6-digit code')),
      );
      return;
    }

    final flow = ref.read(otpEntryFlowProvider);

    /// ✅ Forgot password flow
    if (flow == OtpEntryFlow.forgotPassword) {
      context.push(NewPasswordScreen.routeName);
      return;
    }

    /// ✅ Phone verification flow
    // Check if Service Provider + Business type → go to service_provider_verify_business
    final selectedRole = ref.read(selectedRoleProvider);
    final selectedType = ref.read(selectedTypeProvider);
    final selectedUserRole = ref.read(selectedUserRoleProvider);

    // Service Provider + "For Business" → service_provider_verify_business.dart
    if ((selectedRole == UserRole.provider ||
            selectedUserRole == UserRole.provider) &&
        selectedType == UserType.business) {
      context.push(ServiceProviderVerifyBusiness.routeName);
    } else {
      // Other flows → document verification flow
      context.push(SelectDocumentScreen.routeName);
    }

    /// optional cleanup
    ref.read(otpEntryFlowProvider.notifier).state = null;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Show popup when screen loads if OTP exists
    final otp = ref.read(sentOtpProvider);
    if (otp != null && otp.isNotEmpty && !_showOtpPopup) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _showOtpNotification();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 16.h),
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 4.h),

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
                            color: const Color(0xff111111),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 24.h),

                    /// Title
                    Text(
                      '6- digit code',
                      style: TextStyle(
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w500,
                        color: AllColor.black,
                        fontFamily: 'sf_pro',
                      ),
                    ),
                    SizedBox(height: 8.h),

                    /// Subtitle
                    Text(
                      "To confirm your phone number, please enter the\n"
                      "OTP we sent",
                      style: TextStyle(
                        fontSize: 18.sp,
                        height: 1.5,
                        color: AllColor.black,
                        fontFamily: 'sf_pro',
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    SizedBox(height: 32.h),

                    /// OTP boxes + dash
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildOtpBox(0),
                        SizedBox(width: 6.w),
                        _buildOtpBox(1),
                        SizedBox(width: 6.w),
                        _buildOtpBox(2),
                        SizedBox(width: 4.w),
                        _buildDash(),
                        SizedBox(width: 4.w),
                        _buildOtpBox(3),
                        SizedBox(width: 6.w),
                        _buildOtpBox(4),
                        SizedBox(width: 6.w),
                        _buildOtpBox(5),
                      ],
                    ),

                    SizedBox(height: 80.h),
                  ],
                ),
              ),
            ),
          ),

          // OTP Popup Overlay
          if (_showOtpPopup)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SlideTransition(
                position: _slideAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Container(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                      child: _buildOtpNotificationCard(),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),

      /// Bottom button
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(22.w, 0, 22.w, 24.h),
        child: SizedBox(
          width: double.infinity,
          height: 56.h,
          child: CustomButton(
            text: "Continue",
            icon: Icons.arrow_forward,
            onTap: _onContinue,
          ),
        ),
      ),
    );
  }

  /// Single OTP box
  Widget _buildOtpBox(int index) {
    return SizedBox(
      width: 54.w,
      height: 54.h,
      child: TextFormField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: TextStyle(
          fontSize: 18.sp,
          color: const Color(0xff111111),
          fontFamily: 'sf_pro',
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: const Color(0xffF7F7F7),
          contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: const BorderSide(color: Color(0xffE5E5EA)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide(color: AllColor.grey50, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide(color: AllColor.grey50, width: 1.2),
          ),
        ),
        onChanged: (value) {
          if (value.length == 1 && index < 5) {
            _focusNodes[index + 1].requestFocus();
          }
          if (value.isEmpty && index > 0) {
            _focusNodes[index - 1].requestFocus();
          }
        },
      ),
    );
  }

  /// Middle dash bar
  Widget _buildDash() {
    return Container(
      width: 24.w,
      height: 3.h,
      decoration: BoxDecoration(
        color: AllColor.black,
        borderRadius: BorderRadius.circular(999.r),
      ),
    );
  }

  /// OTP Notification Card - styled like the notification in the image
  Widget _buildOtpNotificationCard() {
    final otp = ref.watch(sentOtpProvider);

    // If OTP is null, show a placeholder or return empty
    if (otp == null || otp.isEmpty) {
      return const SizedBox.shrink();
    }

    return GestureDetector(
      onTap: _hideOtpNotification, // Tap to dismiss
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: const Color(
            0xFF000000,
          ), // Much darker background like notification
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.r),
            bottomRight: Radius.circular(20.r),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 25,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // "now" timestamp - aligned with WORKPLEIS (same left position)
            Padding(
              padding: EdgeInsets.only(
                left: 44.w + 12.w, // Same as logo width + spacing
                bottom: 4.h,
              ),
              child: Text(
                'now',
                style: TextStyle(
                  fontSize: 11.sp,
                  color: Colors.white.withOpacity(0.6),
                  fontFamily: 'sf_pro',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            // Main content row
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // App logo (splash logo)
                Container(
                  width: 44.w,
                  height: 44.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    // color: const Color(0xFF1C1C1E),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: Image.asset(
                      'assets/images/splashlogo.png',
                      width: 44.w,
                      height: 44.w,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        // Fallback to MainLogo if splashlogo not found
                        return Image.asset(
                          'assets/images/otp_logo.png',
                          width: 40.w,
                          height: 44.h,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                // OTP message
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // App name - aligned with "now"
                      Text(
                        'WORKPLEIS',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.white,
                          fontFamily: 'sf_pro',
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.8,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      // OTP message
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.white.withOpacity(0.95),
                            fontFamily: 'sf_pro',
                            fontWeight: FontWeight.w400,
                            height: 1.3,
                          ),
                          children: [
                            TextSpan(
                              text: '$otp ',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 15.sp,
                                color: Colors.white,
                                letterSpacing: 0.5,
                              ),
                            ),
                            const TextSpan(
                              text:
                                  'in your one time password (OTP) to log in to Workpleis',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Close button
                SizedBox(width: 8.w),
                GestureDetector(
                  onTap: _hideOtpNotification,
                  child: Container(
                    padding: EdgeInsets.all(4.w),
                    child: Icon(
                      Icons.close,
                      color: Colors.white.withOpacity(0.5),
                      size: 18.sp,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
