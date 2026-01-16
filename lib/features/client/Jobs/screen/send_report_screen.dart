import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';

class SendReportScreen extends StatefulWidget {
  const SendReportScreen({super.key});

  static const String routeName = '/send_report';

  @override
  State<SendReportScreen> createState() => _SendReportScreenState();
}

class _SendReportScreenState extends State<SendReportScreen> {
  String? _selectedOption;

  final List<String> _reportOptions = [
    "We failed to reach a consensus on the price",
    "The purchaser asked for work.",
    "I can't finish the work due to some personal/technical challenges.",
    "I want a refund requesting",
    "Other",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AllColor.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 8.h),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () => context.pop(),
                      borderRadius: BorderRadius.circular(12.r),
                      child: Container(
                        height: 40.w,
                        width: 40.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                          border:
                          Border.all(color: AllColor.grey200, width: 1),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              blurRadius: 14,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Icon(
                            Icons.arrow_back,
                            size: 22.sp,
                            color: const Color(0xFF111111),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    'Send a Report',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontFamily: 'plus_Jakarta_Sans',
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 24.h),
                    // Question
                    Text(
                      "Can you tell us what issue you're facing with this order?",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'plus_Jakarta_Sans',
                        color: AllColor.black,
                        height: 1.3,
                      ),
                    ),
                    SizedBox(height: 32.h),

                    // Radio button options
                    ...List.generate(
                      _reportOptions.length,
                      (index) => _RadioOption(
                        text: _reportOptions[index],
                        isSelected: _selectedOption == _reportOptions[index],
                        onTap: () {
                          setState(() {
                            _selectedOption = _reportOptions[index];
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ),

            // Bottom section
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
              decoration: BoxDecoration(
                color: AllColor.white,
                border: Border(
                  top: BorderSide(
                    color: AllColor.grey200,
                    width: 1,
                  ),
                ),
              ),
              child: Column(
                children: [
                  // Customer Support text
                  RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'plus_Jakarta_Sans',
                        color: const Color(0xFF6B7280),
                        height: 1.5,
                      ),
                      children: [
                        const TextSpan(
                          text: "Didn't find what you were searching for? Get in touch with our ",
                        ),
                        WidgetSpan(
                          child: GestureDetector(
                            onTap: () {
                              // TODO: Navigate to customer support
                            },
                            child: Text(
                              'Customer Support.',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'plus_Jakarta_Sans',
                                color: const Color(0xFF4CAF50),
                                decoration: TextDecoration.underline,
                                decorationColor: const Color(0xFF4CAF50),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // Continue button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _selectedOption != null
                          ? () {
                              context.push('/request_refund');
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AllColor.black,
                        disabledBackgroundColor: AllColor.grey300,
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Continue',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'plus_Jakarta_Sans',
                              color: AllColor.white,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Icon(
                            Icons.arrow_forward,
                            size: 20.sp,
                            color: AllColor.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RadioOption extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const _RadioOption({
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.only(bottom: 16.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Radio button
            Container(
              width: 22.w,
              height: 22.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF4CAF50)
                      : AllColor.grey300,
                  width: isSelected ? 2 : 1,
                ),
                color: isSelected
                    ? const Color(0xFF4CAF50)
                    : AllColor.white,
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 8.w,
                        height: 8.w,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AllColor.white,
                        ),
                      ),
                    )
                  : null,
            ),
            SizedBox(width: 12.w),
            // Text
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 2.h),
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'plus_Jakarta_Sans',
                    color: AllColor.black,
                    height: 1.4,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

