import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';

enum _NotificationLeadingType { avatarAsset, icon }

class _NotificationItem {
  const _NotificationItem({
    required this.title,
    required this.date,
    required this.leadingType,
    this.avatarAsset,
    this.leadingImageAsset,
    this.icon,
  });

  final String title;
  final String date;
  final _NotificationLeadingType leadingType;
  final String? avatarAsset;
  final String? leadingImageAsset;
  final IconData? icon;
}

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  static const String routeName = '/notifications';

  static const List<_NotificationItem> _demoItems = [
    _NotificationItem(
      title: 'Congratulation New Chat!',
      date: 'Aug 01,2024',
      leadingType: _NotificationLeadingType.avatarAsset,
      avatarAsset: 'assets/images/home/image.png',
    ),
    _NotificationItem(
      title: 'A friend you referred, sadia2042, just signed up',
      date: 'Jun 20,2024',
      leadingType: _NotificationLeadingType.icon,
      icon: Icons.bolt,
    ),
    _NotificationItem(
      title: 'Tasker identity verification Request',
      date: 'Jun 30,2024',
      leadingType: _NotificationLeadingType.icon,
      icon: Icons.bolt,
    ),
    _NotificationItem(
      title: 'You posted the "Mobile App" Ramjan Khan',
      date: 'Jun 20,2024',
      leadingType: _NotificationLeadingType.icon,
      icon: Icons.bolt,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 6.h),
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
                          border: Border.all(color: AllColor.grey200, width: 1),
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
                    'Notification',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontFamily: 'sf_pro',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 14.h),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: AllColor.grey200, width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 22,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: ListView.separated(
                      padding: EdgeInsets.zero,
                      itemCount: _demoItems.length,
                      separatorBuilder: (context, index) => Divider(
                        height: 1,
                        thickness: 1,
                        color: AllColor.grey200,
                      ),
                      itemBuilder: (context, index) {
                        final item = _demoItems[index];
                        return _NotificationTile(item: item);
                      },
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 18.h),
          ],
        ),
      ),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  const _NotificationTile({required this.item});

  final _NotificationItem item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // TODO: hook to details screen if needed.
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Leading(item: item),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: AllColor.black,
                      fontFamily: 'sf_pro',
                      height: 1.25,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    item.date,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: AllColor.grey,
                      fontFamily: 'sf_pro',
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

class _Leading extends StatelessWidget {
  const _Leading({required this.item});

  final _NotificationItem item;

  @override
  Widget build(BuildContext context) {
    final isLogo = item.leadingType == _NotificationLeadingType.icon;

    return Container(
      height: 46.w,
      width: 46.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(color: AllColor.grey200, width: 1),
      ),
      child: isLogo ? _buildLogo() : _buildAvatar(),
    );
  }

  Widget _buildAvatar() {
    return ClipOval(
      child: Image.asset(
        item.avatarAsset!,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }

  Widget _buildLogo() {
    return Center(
      child: SizedBox(
        width: 22.w, // 🔹 container-এর চেয়ে ছোট
        height: 22.w, // 🔹 container-এর চেয়ে ছোট
        child: Image.asset(
          item.leadingImageAsset ?? 'assets/images/splashlogo.png',
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
