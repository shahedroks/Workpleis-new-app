import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/features/client/screen/client_home_screen.dart';
import 'package:workpleis/features/client/Jobs/screen/jobs.dart';
import 'package:workpleis/features/client/message/screen/messages_screen.dart';
import 'package:workpleis/features/client/profile/screen/profile_screen.dart';
final selectedIndexProvider = StateProvider<int>((ref) => 0);

class BottomNavBar extends ConsumerStatefulWidget {
  const BottomNavBar({super.key});
  static const String routeName = '/BottomNavBar';

  @override
  ConsumerState<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends ConsumerState<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    final selectedIndex = ref.watch(selectedIndexProvider);

    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: const [
          ClientHomeScreen(),
          ClientJobsScreen(),
          MessageScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AllColor.white,
          border: Border(
            top: BorderSide(
              color: AllColor.grey200,
              width: 0.5,
            ),
          ),
        ),
        child: SafeArea(
          child: Container(
            height: 60.h,
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _NavItem(
                  icon: Icons.home_outlined,
                  filledIcon: Icons.home,
                  label: 'Home',
                  isSelected: selectedIndex == 0,
                  onTap: () {
                    ref.read(selectedIndexProvider.notifier).state = 0;
                  },
                ),
                _NavItem(
                  icon: Icons.work_outline,
                  filledIcon: Icons.work,
                  label: 'Jobs',
                  isSelected: selectedIndex == 1,
                  onTap: () {
                    ref.read(selectedIndexProvider.notifier).state = 1;
                  },
                ),
                _NavItem(
                  icon: Icons.mail_outline,
                  filledIcon: Icons.mail,
                  label: 'Message',
                  isSelected: selectedIndex == 2,
                  onTap: () {
                    ref.read(selectedIndexProvider.notifier).state = 2;
                  },
                ),
                _NavItem(
                  icon: Icons.person_outline,
                  filledIcon: Icons.person,
                  label: 'Profile',
                  isSelected: selectedIndex == 3,
                  onTap: () {
                    ref.read(selectedIndexProvider.notifier).state = 3;
                  },
                ),
              ],
            ),
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
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h),
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
