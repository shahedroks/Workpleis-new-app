import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/features/client/message/screen/messages_screen.dart';
import 'package:workpleis/features/client/profile/screen/profile_screen.dart';
import 'package:workpleis/features/service/screen/service_home_screen.dart';
import 'package:workpleis/features/service/service_jobs/service_jobs_screen.dart';

final _serviceSelectedIndexProvider = StateProvider<int>((ref) => 0);

/// Service Provider bottom navigation (same UI as client, different tabs).
class ServiceBottomNavBar extends ConsumerStatefulWidget {
  const ServiceBottomNavBar({super.key});

  static const String routeName = '/ServiceBottomNavBar';

  @override
  ConsumerState<ServiceBottomNavBar> createState() => _ServiceBottomNavBarState();
}

class _ServiceBottomNavBarState extends ConsumerState<ServiceBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    final selectedIndex = ref.watch(_serviceSelectedIndexProvider);
    final navBarHeight = math.max(kBottomNavigationBarHeight, 72.h);

    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: [
          const ServiceHomeScreen(),
          const JobsScreen(),
          const _ServicePlaceholderScreen(title: 'Projects'),
          const MessageScreen(),
          const ProfileScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AllColor.white,
          border: Border(top: BorderSide(color: AllColor.grey200, width: 0.5)),
        ),
        child: SafeArea(
          child: Container(
            height: navBarHeight,
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _NavItem(
                  icon: Icons.home_outlined,
                  filledIcon: Icons.home,
                  label: 'Home',
                  isSelected: selectedIndex == 0,
                  onTap: () =>
                      ref.read(_serviceSelectedIndexProvider.notifier).state = 0,
                ),
                _NavItem(
                  icon: Icons.work_outline,
                  filledIcon: Icons.work,
                  label: 'Jobs',
                  isSelected: selectedIndex == 1,
                  onTap: () =>
                      ref.read(_serviceSelectedIndexProvider.notifier).state = 1,
                ),
                _NavItem(
                  icon: Icons.account_balance_wallet_outlined,
                  filledIcon: Icons.list_alt_outlined,
                  label: 'Projects',
                  isSelected: selectedIndex == 2,
                  onTap: () =>
                      ref.read(_serviceSelectedIndexProvider.notifier).state = 2,
                ),
                _NavItem(
                  icon: Icons.mail_outline,
                  filledIcon: Icons.mail,
                  label: 'Message',
                  isSelected: selectedIndex == 3,
                  onTap: () =>
                      ref.read(_serviceSelectedIndexProvider.notifier).state = 3,
                ),
                _NavItem(
                  icon: Icons.person_outline,
                  filledIcon: Icons.person,
                  label: 'Profile',
                  isSelected: selectedIndex == 4,
                  onTap: () =>
                      ref.read(_serviceSelectedIndexProvider.notifier).state = 4,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ServicePlaceholderScreen extends StatelessWidget {
  final String title;

  const _ServicePlaceholderScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AllColor.white,
      body: Center(
        child: Text(
          title,
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: AllColor.black,
            fontFamily: 'sf_pro',
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final IconData filledIcon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.filledIcon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8.r),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 6.h),
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isSelected ? filledIcon : icon,
                  size: 24.sp,
                  color: isSelected ? AllColor.black : AllColor.grey,
                ),
                SizedBox(height: 4.h),
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                    fontFamily: 'sf_pro',
                    color: isSelected ? AllColor.black : AllColor.grey,
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

