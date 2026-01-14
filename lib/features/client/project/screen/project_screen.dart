import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';

class ProjectScreen extends StatelessWidget {
  const ProjectScreen({super.key});

  static const String routeName = '/project';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AllColor.white,
      body: Center(
        child: Text(
          'Project',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: AllColor.black,
          ),
        ),
      ),
    );
  }
}

