import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/color_control/all_color.dart';

class ServiceHomeScreen extends StatelessWidget {
  const ServiceHomeScreen({super.key});
  static const String routeName = '/service_home';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AllColor.white,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFD8EBCB), Color(0xFFF3F5F7)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 16.h,
                  ),
                  child: const _Header(),
                ),
                SizedBox(height: 10.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: const _StatsCardsRow(),
                ),
                SizedBox(height: 26.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: const _EarningsSection(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(14.r),
          child: Image.asset(
            'assets/images/profile.png',
            width: 52.w,
            height: 52.w,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello, Welcome back',
                style: TextStyle(
                  fontFamily: 'plus_Jakarta_Sans',
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                  color: const Color(0xFF525252),
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'Muhammad Israf',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: 'plus_Jakarta_Sans',
                  fontWeight: FontWeight.w700,
                  fontSize: 24.sp,
                  color: AllColor.black,
                  letterSpacing: -0.32,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 12.w),
        _CircleActionButton(
          icon: Icons.notifications_none_rounded,
          onTap: () {},
        ),
        SizedBox(width: 12.w),
        _CircleActionButton(icon: Icons.favorite_border_rounded, onTap: () {}),
      ],
    );
  }
}

class _CircleActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CircleActionButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AllColor.white,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 44.w,
          height: 44.w,
          child: Icon(icon, size: 22.sp, color: const Color(0xFF141B34)),
        ),
      ),
    );
  }
}

class _StatsCardsRow extends StatelessWidget {
  const _StatsCardsRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _StatCard(
            height: 130.h,
            icon: Icons.assignment_outlined,
            iconColor: AllColor.black,
            title: '282',
            subtitle: 'Total Application',
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Column(
            children: [
              _StatCard(
                height: 60.h,
                icon: Icons.task_alt_rounded,
                iconColor: AllColor.black,
                title: '20',
                subtitle: 'Accepted Proposal',
                titleSize: 20.sp,
              ),
              SizedBox(height: 10.h),
              _StatCard(
                height: 60.h,
                icon: Icons.cancel_rounded,
                iconColor: const Color(0xFFFF0000),
                title: '20',
                subtitle: 'Rejected Proposal',
                titleSize: 20.sp,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final double height;
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final double? titleSize;

  const _StatCard({
    required this.height,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    this.titleSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF698455),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: const Color(0xFFD2FF56),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: const Color(0x1A555555)),
              ),
              child: Icon(icon, size: 22.sp, color: iconColor),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(top: 4.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height >= 90 ? 26.h : 0),
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'sf_pro',
                      fontWeight: FontWeight.w700,
                      fontSize: titleSize ?? 22.sp,
                      color: AllColor.white,
                      height: 1.0,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'sf_pro',
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                      color: AllColor.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EarningsSection extends StatelessWidget {
  const _EarningsSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Earnings',
          style: TextStyle(
            fontFamily: 'sf_pro',
            fontWeight: FontWeight.w600,
            fontSize: 22.sp,
            color: AllColor.black,
          ),
        ),
        SizedBox(height: 18.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(15.w),
          decoration: BoxDecoration(
            color: AllColor.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: const Color(0xFFEBEBEB)),
          ),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFF6F6F6),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: const Color(0xFFF2F2F2)),
                ),
                child: Column(
                  children: [
                    Text(
                      'Available balance',
                      style: TextStyle(
                        fontFamily: 'sf_pro',
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                        color: const Color(0xB2000000),
                      ),
                    ),
                    SizedBox(height: 9.h),
                    Text(
                      'SAR 2,543.00',
                      style: TextStyle(
                        fontFamily: 'sf_pro',
                        fontWeight: FontWeight.w700,
                        fontSize: 24.sp,
                        color: AllColor.black,
                      ),
                    ),
                    SizedBox(height: 30.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 10.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF02021D),
                        borderRadius: BorderRadius.circular(99.r),
                      ),
                      child: Text(
                        'Withdraw earning',
                        style: TextStyle(
                          fontFamily: 'sf_pro',
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                          color: AllColor.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 18.h),
              Divider(height: 1.h, color: const Color(0xFFF3F3F3)),
              SizedBox(height: 18.h),
              Row(
                children: [
                  Expanded(
                    child: _Metric(
                      label: 'Total earnings',
                      value: 'SAR 2,543.00',
                      valueColor: AllColor.black,
                    ),
                  ),
                  SizedBox(width: 24.w),
                  Expanded(
                    child: _Metric(
                      label: 'Earning in April',
                      value: 'SAR 1,342.00',
                      valueColor: AllColor.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 22.h),
              Row(
                children: [
                  Expanded(
                    child: _Metric(
                      label: 'Upcoming earning',
                      value: 'SAR 700.00',
                      valueColor: const Color(0xFFFF6600),
                    ),
                  ),
                  SizedBox(width: 24.w),
                  Expanded(
                    child: _Metric(
                      label: 'Active orders',
                      value: '3',
                      valueColor: AllColor.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 10.h),
        _ProposalRow(onTap: () {}),
      ],
    );
  }
}

class _Metric extends StatelessWidget {
  final String label;
  final String value;
  final Color valueColor;

  const _Metric({
    required this.label,
    required this.value,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'sf_pro',
            fontWeight: FontWeight.w400,
            fontSize: 14.sp,
            color: const Color(0xB2000000),
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'sf_pro',
            fontWeight: FontWeight.w700,
            fontSize: 16.sp,
            color: valueColor,
          ),
        ),
      ],
    );
  }
}

class _ProposalRow extends StatelessWidget {
  final VoidCallback onTap;

  const _ProposalRow({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AllColor.white,
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 14.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: const Color(0xFFEBEBEB)),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Proposal',
                  style: TextStyle(
                    fontFamily: 'sf_pro',
                    fontWeight: FontWeight.w700,
                    fontSize: 14.sp,
                    color: const Color(0xFF101010),
                  ),
                ),
              ),
              Icon(
                Icons.arrow_outward_rounded,
                size: 22.sp,
                color: AllColor.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
