
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';

class ProjectCompletedSuccessScreen extends StatelessWidget {
  const ProjectCompletedSuccessScreen({super.key});

  static const String routeName = '/project_completed_success';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AllColor.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              const Spacer(flex: 2),
              
              // Success illustration - Large lime green circle with hand holding phone
              _SuccessIllustration(),
              
              SizedBox(height: 24.h),
              
              // "Project Completed" text
              Text(
                'Project Completed',
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'plus_Jakarta_Sans',
                  color: AllColor.black,
                ),
                textAlign: TextAlign.center,
              ),
              
              const Spacer(flex: 1),
              SizedBox(height: 20.h),
              
              // Ok button - Black with purple outline
              Container(
                height: 54.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AllColor.black,
                  borderRadius: BorderRadius.circular(999.r),
                  border: Border.all(
                    color: const Color(0xFF8B5CF6), // Purple
                    width: 1,
                  ),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      // Navigate back to projects screen
                      context.pop();
                    },
                    borderRadius: BorderRadius.circular(999.r),
                    child: Center(
                      child: Text(
                        'Ok',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'plus_Jakarta_Sans',
                          color: AllColor.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              
              SizedBox(height: 18.h),
            ],
          ),
        ),
      ),
    );
  }
}

class _SuccessIllustration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350.w,
      height: 350.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Large lime green circle background
          Container(
            width: 350.w,
            height: 350.h,
            decoration: BoxDecoration(
              color: const Color(0xFFCAFF45), // Lime green
              shape: BoxShape.circle,
            ),
          ),
          
          // Try to load completed.png asset, fallback to custom illustration
          _buildIllustration(),
          
          // Sparkles around the circle
          ..._buildSparkles(),
        ],
      ),
    );
  }

  Widget _buildIllustration() {
    // Try to use completed.png asset first
    return Image.asset(
      'assets/images/completed.png',
      width: 350.w,
      height: 350.h,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        // Fallback: Custom illustration with hand holding phone
        return _buildCustomIllustration();
      },
    );
  }

  Widget _buildCustomIllustration() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Phone representation
        Container(
          width: 125.w,
          height: 220.h,
          decoration: BoxDecoration(
            color: const Color(0xFF1E3A5F), // Dark teal/blue
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Phone screen (white)
              Container(
                width: 110.w,
                height: 175.h,
                margin: EdgeInsets.only(top: 12.h),
                decoration: BoxDecoration(
                  color: AllColor.white,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Center(
                  child: Container(
                    width: 62.w,
                    height: 62.w,
                    decoration: BoxDecoration(
                      color: const Color(0xFF4CAF50), // Green
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check,
                      color: AllColor.white,
                      size: 36.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> _buildSparkles() {
    return [
      // Top left sparkle (light blue)
      Positioned(
        top: 30.h,
        left: 45.w,
        child: _Sparkle(color: const Color(0xFF87CEEB), size: 12.w),
      ),
      // Top right sparkle (pink)
      Positioned(
        top: 40.h,
        right: 40.w,
        child: _Sparkle(color: const Color(0xFFFFB6C1), size: 10.w),
      ),
      // Bottom left sparkle (yellow)
      Positioned(
        bottom: 35.h,
        left: 50.w,
        child: _Sparkle(color: const Color(0xFFFFD700), size: 11.w),
      ),
      // Bottom right sparkle (light blue)
      Positioned(
        bottom: 30.h,
        right: 45.w,
        child: _Sparkle(color: const Color(0xFF87CEEB), size: 10.w),
      ),
      // Left sparkle (pink)
      Positioned(
        left: 25.w,
        top: 150.h,
        child: _Sparkle(color: const Color(0xFFFFB6C1), size: 9.w),
      ),
      // Right sparkle (yellow)
      Positioned(
        right: 30.w,
        top: 140.h,
        child: _Sparkle(color: const Color(0xFFFFD700), size: 10.w),
      ),
    ];
  }
}

class _Sparkle extends StatelessWidget {
  final Color color;
  final double size;

  const _Sparkle({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}

