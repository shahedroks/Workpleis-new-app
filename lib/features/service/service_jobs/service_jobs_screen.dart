import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/features/service/service_jobs/service_job_full_details_screen.dart';

/// Jobs screen converted from React component
class JobsScreen extends StatefulWidget {
  const JobsScreen({super.key});

  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  int _selectedTabIndex = 0;

  final List<String> _tabs = ['All Jobs', 'My Jobs', 'Saved', 'Active jobs'];

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: Stack(
        children: [
          // Background decoration
          Positioned(
            left: MediaQuery.of(context).size.width * 0.25 + 20.5.w,
            top: statusBarHeight + 11.h,
            child: Container(
              width: 430.w,
              height: 137.h,
              child: CustomPaint(
                painter: _EllipsePainter(),
              ),
            ),
          ),
          // Main content
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title - positioned at top: 86px from original (32px after status bar)
                Padding(
                  padding: EdgeInsets.only(left: 16.w, top: 32.h),
                  child: Text(
                    'Jobs',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w500,
                      color: AllColor.black,
                      fontFamily: 'SF Pro Display',
                    ),
                  ),
                ),
              SizedBox(height: 16.h),
              // Tab navigation
              _TabNavigation(
                tabs: _tabs,
                selectedIndex: _selectedTabIndex,
                onTabSelected: (index) {
                  setState(() {
                    _selectedTabIndex = index;
                  });
                },
              ),
                SizedBox(height: 8.h),
                // Job cards list
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(
                      left: 16.w,
                      top: 8.h,
                      right: 16.w,
                      bottom: 16.h,
                    ),
                    child: Column(
                      children: [
                        _JobCard(
                          title: 'I have two tickets for the Al-Nassr  Paris match for sale design',
                          quote: '8 Sec',
                          price: '\$600',
                          location: 'Jaddah',
                          services: ['Design', 'Banner Design'],
                        ),
                        SizedBox(height: 8.h),
                        _JobCard(
                          title: 'Part of my fridge is damaged, and I urgently need it fixed',
                          quote: '30 min ago',
                          price: '\$160',
                          location: 'Jaddah',
                          services: ['Mechanic', 'Fridge'],
                        ),
                        SizedBox(height: 8.h),
                        _JobCard(
                          title: 'Could you create a stylish sticker design for my car',
                          quote: '20 min ago',
                          price: '\$500',
                          location: 'Modina',
                          services: ['Design', 'Sticker Design', 'Car'],
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
    );
  }
}

/// Tab navigation widget
class _TabNavigation extends StatelessWidget {
  final List<String> tabs;
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;

  const _TabNavigation({
    required this.tabs,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16.w),
      child: Row(
        children: List.generate(tabs.length, (index) {
          final isSelected = index == selectedIndex;
          return GestureDetector(
            onTap: () => onTabSelected(index),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 21.w, vertical: 10.h),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: isSelected ? AllColor.black : const Color(0xFFDADADA),
                    width: isSelected ? 1.5 : 1,
                  ),
                ),
              ),
              child: Text(
                tabs[index],
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected ? AllColor.black : const Color(0xFF494949),
                  fontFamily: 'Plus Jakarta Sans',
                  letterSpacing: -0.32,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

/// Job card widget
class _JobCard extends StatelessWidget {
  final String title;
  final String quote;
  final String price;
  final String location;
  final List<String> services;

  const _JobCard({
    required this.title,
    required this.quote,
    required this.price,
    required this.location,
    required this.services,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle job card tap
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ServiceJobFullDetailsScreen()),
        );
      },
      child: Container(
        width: double.infinity,
        height: 208.h,
        decoration: BoxDecoration(
          color: AllColor.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: const Color(0xFFE6E7EB),
            width: 1,
          ),
        ),
        child: Stack(
          children: [
            // Content
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and more icon
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: AllColor.black,
                            fontFamily: 'Inter',
                            height: 1.2,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      GestureDetector(
                        onTap: () {
                          // Handle more options
                        },
                        child: Icon(
                          Icons.more_vert,
                          size: 24.sp,
                          color: const Color(0xFF4F4F4F),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  // Info cards row
                  Row(
                    children: [
                      Expanded(
                        child: _InfoCard(
                          label: 'Quote',
                          value: quote,
                        ),
                      ),
                      SizedBox(width: 9.w),
                      Expanded(
                        child: _InfoCard(
                          label: 'Price',
                          value: price,
                        ),
                      ),
                      SizedBox(width: 9.w),
                      Expanded(
                        child: _InfoCard(
                          label: 'Location',
                          value: location,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 9.h),
                  // Services section
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SERVICES',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF7D7D7D),
                          fontFamily: 'SF Pro Display',
                          letterSpacing: 0.5,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Wrap(
                        spacing: 4.w,
                        runSpacing: 4.h,
                        children: services.map((service) {
                          return _ServiceTag(label: service);
                        }).toList(),
                      ),
                    ],
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

/// Info card widget (Quote, Price, Location)
class _InfoCard extends StatelessWidget {
  final String label;
  final String value;

  const _InfoCard({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65.h,
      decoration: BoxDecoration(
        color: const Color(0xFFF8FBF1),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: const Color(0xFFE1E8D2),
          width: 1,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0x6B000000), // rgba(0,0,0,0.42)
              fontFamily: 'Inter',
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AllColor.black,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }
}

/// Service tag widget
class _ServiceTag extends StatelessWidget {
  final String label;

  const _ServiceTag({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AllColor.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: const Color(0xFFDDDDDD),
          width: 1,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11.sp,
          fontWeight: FontWeight.w500,
          color: AllColor.black,
          fontFamily: 'Inter',
          height: 1.0,
        ),
      ),
    );
  }
}

/// Custom painter for the background ellipse decoration
class _EllipsePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFD8EBCB).withOpacity(0.5)
      ..style = PaintingStyle.fill;

    final blurPaint = Paint()
      ..color = const Color(0xFFD8EBCB).withOpacity(0.5)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 89.5);

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final path = Path()
      ..addOval(
        Rect.fromCenter(
          center: Offset(size.width / 2, size.height / 2),
          width: size.width * 0.55,
          height: size.height * 0.5,
        ),
      );

    canvas.drawPath(path, blurPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
