// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:go_router/go_router.dart';
// import 'package:workpleis/features/role_screen/screen/genNotifications.dart';
//
// enum UserRole { client, provider }
//
// class SeclectTypeScreen extends StatefulWidget {
//   const SeclectTypeScreen({super.key});
//
//   static const String routeName = '/select_type';
//
//   @override
//   State<SeclectTypeScreen> createState() => _SeclectTypeScreenState();
// }
//
//
// class _SeclectTypeScreenState extends State<SeclectTypeScreen> {
//   UserRole? _selected;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           physics: const BouncingScrollPhysics(),
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 24.w),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 /// top logo
//                 Padding(
//                   padding: EdgeInsets.only(top: 8.h),
//                   child: Image.asset(
//                     'assets/images/splashlogo.png',
//                     height: 47.h,
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//
//                 SizedBox(height: 32.h),
//
//                 /// center icon
//                 Center(
//                   child: Image.asset(
//                     'assets/images/typeicon.png',
//                     height: 115.h,
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//
//                 SizedBox(height: 28.h),
//
//                 /// title
//                 Center(
//                   child: Text(
//                     'Select your Type',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 40.sp,
//                       fontWeight: FontWeight.w600,
//                       fontFamily: 'sf_Pro',
//                       color: Colors.black,
//                     ),
//                   ),
//                 ),
//
//                 SizedBox(height: 8.h),
//
//                 /// subtitle
//                 Center(
//                   child: Text(
//                     'A  Sustainable Marketplace For\nBusinesses',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 18.sp,
//                       fontWeight: FontWeight.w400,
//                       fontFamily: 'sf_Pro',
//                       color: Colors.black.withOpacity(0.6),
//                       height: 1.3,
//                     ),
//                   ),
//                 ),
//
//                 SizedBox(height: 32.h),
//
//                 /// type cards
//                 _RoleCard(
//                   label: "For Individual",
//                   selected: _selected == UserRole.client,
//                   onTap: () {
//                     setState(() => _selected = UserRole.client);
//                   },
//                 ),
//                 SizedBox(height: 16.h),
//                 _RoleCard(
//                   label: "For Business",
//                   selected: _selected == UserRole.provider,
//                   onTap: () {
//                     setState(() => _selected = UserRole.provider);
//                   },
//                 ),
//
//                 SizedBox(height: 32.h),
//
//                 /// Next button
//                 SizedBox(
//                   width: double.infinity,
//                   height: 56.h,
//                   child: ElevatedButton(
//                     onPressed: _selected == null
//                         ? null
//                         : () {
//                       context.push(Gennotifications.routeName);
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF03051A),
//                       disabledBackgroundColor:
//                       const Color(0xFF03051A).withOpacity(0.25),
//                       shape: const StadiumBorder(),
//                       elevation: 0,
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           'Next',
//                           style: TextStyle(
//                             fontSize: 16.sp,
//                             fontWeight: FontWeight.w500,
//                             fontFamily: 'sf_Pro',
//                             color: Colors.white,
//                           ),
//                         ),
//                         SizedBox(width: 8.w),
//                         Icon(
//                           Icons.arrow_forward_ios_rounded,
//                           size: 16.sp,
//                           color: Colors.white,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//
//                 SizedBox(height: 16.h),
//
//                 /// Skip
//                 Center(
//                   child: TextButton(
//                     onPressed: () {
//                       context.push(Gennotifications.routeName);
//                     },
//                     style: TextButton.styleFrom(
//                       foregroundColor: Colors.black,
//                       padding: EdgeInsets.zero,
//                     ),
//                     child: Text(
//                       'Skip',
//                       style: TextStyle(
//                         fontSize: 16.sp,
//                         fontFamily: 'sf_Pro',
//                         fontWeight: FontWeight.w400,
//                         decoration: TextDecoration.underline,
//                         decorationColor: Colors.black,
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 SizedBox(height: 8.h),
//               ],
//             ),
//           ),
//         ),
//       ),
//
//     );
//   }
// }
//
// /// ---------------------------------------------------------------------------
// ///  ROLE CARD
// /// ---------------------------------------------------------------------------
// class _RoleCard extends StatelessWidget {
//   const _RoleCard({
//     required this.label,
//     required this.selected,
//     required this.onTap,
//   });
//
//   final String label;
//   final bool selected;
//   final VoidCallback onTap;
//
//   @override
//   Widget build(BuildContext context) {
//     final borderColor =
//     selected ? Colors.black : Colors.black.withOpacity(0.18);
//
//     return GestureDetector(
//       onTap: onTap,
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 180),
//         height: 60.h,
//         width: double.infinity,
//         padding: EdgeInsets.symmetric(horizontal: 18.w),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(14.r),
//           border: Border.all(color: borderColor, width: 1.1),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.03),
//               blurRadius: 10,
//               offset: Offset(0, 4.h),
//             ),
//           ],
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             /// label
//             Text(
//               label,
//               style: TextStyle(
//                 fontSize: 15.sp,
//                 fontFamily: 'sf_Pro',
//                 fontWeight: FontWeight.w500,
//                 color: Colors.black,
//               ),
//             ),
//
//             /// circular check
//             Container(
//               height: 22.r,
//               width: 22.r,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 border: Border.all(
//                   color: selected
//                       ? Colors.black
//                       : Colors.black.withOpacity(0.25),
//                   width: 1.4,
//                 ),
//                 color: selected ? Colors.black : Colors.white,
//               ),
//               child: selected
//                   ? Icon(
//                 Icons.check,
//                 size: 14.sp,
//                 color: Colors.white,
//               )
//                   : null,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/features/role_screen/screen/genNotifications.dart';

import 'package:workpleis/features/role_screen/screen/seclect_role_screen.dart'
    hide UserRole;
import 'package:workpleis/features/role_screen/widget/custom_next_button.dart';
import 'package:workpleis/features/auth/data/select_your_type_provider.dart';
import 'package:workpleis/features/auth/data/auth_flow_provider.dart';

enum UserType { individual, business }

// Provider to store selected type
final selectedTypeProvider = StateProvider<UserType?>((ref) => null);

class SeclectTypeScreen extends ConsumerStatefulWidget {
  const SeclectTypeScreen({super.key});

  static const String routeName = '/select_type';

  @override
  ConsumerState<SeclectTypeScreen> createState() => _SeclectTypeScreenState();
}

class _SeclectTypeScreenState extends ConsumerState<SeclectTypeScreen> {
  UserType? _selected;

  void _goNext() {
    if (_selected == null) return;

    // ✅ OTP flow set (so OTP screen knows it's not forgot password)
    ref.read(otpEntryFlowProvider.notifier).state =
        OtpEntryFlow.phoneVerification;

    context.push(Gennotifications.routeName);
  }

  void _skip() {
    // Navigate without selecting a type
    ref.read(otpEntryFlowProvider.notifier).state =
        OtpEntryFlow.phoneVerification;

    context.push(Gennotifications.routeName);
  }

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
                Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: Image.asset(
                    'assets/images/splashlogo.png',
                    height: 47.h,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 32.h),

                Center(
                  child: Image.asset(
                    'assets/images/typeicon.png',
                    height: 115.h,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 28.h),

                Center(
                  child: Text(
                    'Select your Type',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 40.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'sf_Pro',
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),

                Center(
                  child: Text(
                    'A Sustainable Marketplace For\nBusinesses',
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

                _RoleCard(
                  label: "For Individual",

                  selected: _selected == UserType.individual,
                  onTap: () {
                    setState(() {
                      _selected = UserType.individual;
                      ref.read(selectedTypeProvider.notifier).state =
                          UserType.individual;
                    });
                  },
                ),
                SizedBox(height: 16.h),

                _RoleCard(
                  label: "For Business",

                  selected: _selected == UserType.business,
                  onTap: () {
                    setState(() {
                      _selected = UserType.business;
                      ref.read(selectedTypeProvider.notifier).state =
                          UserType.business;
                    });
                  },
                ),

                SizedBox(height: 32.h),

                /// Next button

                // button
                SizedBox(height: 180.h),

                CustomNextButton(
                  enabled: _selected != null,
                  onPressed: () {
                    context.push(Gennotifications.routeName);
                  },
                ),
                SizedBox(height: 16.h),

                Center(
                  child: TextButton(
                    onPressed: _skip,
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

/// ROLE CARD
class _RoleCard extends StatelessWidget {
  const _RoleCard({
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
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        height: 60.h,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 18.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: borderColor, width: 1.1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: Offset(0, 4.h),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 15.sp,
                fontFamily: 'sf_Pro',
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
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
                color: selected ? Colors.black : Colors.white,
              ),
              child: selected
                  ? Icon(Icons.check, size: 14.sp, color: Colors.white)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
