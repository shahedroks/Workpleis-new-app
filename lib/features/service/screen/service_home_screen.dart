import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/color_control/all_color.dart';
import 'get_paid_now_screen.dart';

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
            padding: EdgeInsets.zero,
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
                SizedBox(height: 30.h),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24.r),
                      topRight: Radius.circular(24.r),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(24.w, 22.h, 24.w, 24.h),
                    child: const _EarningsSection(),
                  ),
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
            width: 20.w,
            iconAsset: 'assets/images/clipboard.png',
            iconTintColor: AllColor.black,
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
                iconAsset: 'assets/images/document-validation.png',
                iconTintColor: AllColor.black,
                title: '20',
                subtitle: 'Accepted Proposal',
                titleSize: 20.sp,
              ),
              SizedBox(height: 10.h),
              _StatCard(
                height: 60.h,
                iconAsset: 'assets/images/document-validation (1).png',
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
  final String iconAsset;
  final Color? iconTintColor;
  final String title;
  final String subtitle;
  final double? titleSize;
  final double? width;

  const _StatCard({
    required this.height,
    required this.iconAsset,
    this.iconTintColor,
    required this.title,
    required this.subtitle,
    this.titleSize,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final bool isCompact = height < 90;
    final double cardPadding = isCompact ? 10.w : 16.w;
    final double iconBoxSize = isCompact ? 32.w : 40.w;
    final double iconSize = isCompact ? 18.sp : 22.sp;
    final double resolvedTitleSize =
        titleSize ?? (isCompact ? 18.sp : 22.sp);
    final double subtitleFontSize = isCompact ? 10.sp : 12.sp;
    final double titleSubtitleSpacing = isCompact ? 2.h : 4.h;
    final int subtitleMaxLines = isCompact ? 1 : 2;
    final double iconTextSpacing = width ?? 10.w;

    final Widget iconBox = Container(
      width: iconBoxSize,
      height: iconBoxSize,
      decoration: BoxDecoration(
        color: const Color(0xFFD2FF56),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0x1A555555)),
      ),
      child: Center(
        child: Image.asset(
          iconAsset,
          width: iconSize,
          height: iconSize,
          fit: BoxFit.contain,
          color: iconTintColor,
          colorBlendMode: BlendMode.srcIn,
        ),
      ),
    );

    final Widget titleText = Text(
      title,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontFamily: 'sf_pro',
        fontWeight: FontWeight.w700,
        fontSize: resolvedTitleSize,
        color: AllColor.white,
        height: 1.0,
      ),
    );

    final Widget subtitleText = Text(
      subtitle,
      maxLines: subtitleMaxLines,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontFamily: 'sf_pro',
        fontWeight: FontWeight.w400,
        fontSize: subtitleFontSize,
        color: AllColor.white,
      ),
    );

    if (isCompact) {
      return Container(
        height: height,
        padding: EdgeInsets.all(cardPadding),
        decoration: BoxDecoration(
          color: const Color(0xFF698455),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            iconBox,
            SizedBox(width: iconTextSpacing),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  titleText,
                  SizedBox(height: titleSubtitleSpacing),
                  subtitleText,
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      height: height,
      padding: EdgeInsets.all(cardPadding),
      decoration: BoxDecoration(
        color: const Color(0xFF698455),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: iconBox,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(top: 4.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 26.h + 10.h),
                  titleText,
                  SizedBox(height: titleSubtitleSpacing),
                  subtitleText,
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
                    Material(
                      color: const Color(0xFF02021D),
                      borderRadius: BorderRadius.circular(99.r),
                      child: InkWell(
                        onTap: () => context.push(GetPaidNowScreen.routeName),
                        borderRadius: BorderRadius.circular(99.r),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 24.w,
                            vertical: 10.h,
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
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
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
