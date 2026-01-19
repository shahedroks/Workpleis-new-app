import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';

/// Flutter conversion of `lib/features/service/screen/react.tsx`.
///
/// Screen: "Quote" with tabs (All / Accepted / Rejected) and job cards.
class ServiceQuoteScreen extends StatefulWidget {
  const ServiceQuoteScreen({super.key});

  static const String routeName = '/service_quote';

  @override
  State<ServiceQuoteScreen> createState() => _ServiceQuoteScreenState();
}

enum _QuoteTab { all, accepted, rejected }

enum _QuoteJobStatus { accepted, rejected }

class _QuoteJob {
  final int id;
  final String userName;
  final _QuoteJobStatus status;
  final String timestamp;
  final String title;
  final String quote;
  final String price;
  final String location;
  final List<String> services;

  const _QuoteJob({
    required this.id,
    required this.userName,
    required this.status,
    required this.timestamp,
    required this.title,
    required this.quote,
    required this.price,
    required this.location,
    required this.services,
  });

  bool get isAccepted => status == _QuoteJobStatus.accepted;
  String get statusLabel => isAccepted ? 'Accepted' : 'Rejected';
}

class _ServiceQuoteScreenState extends State<ServiceQuoteScreen> {
  _QuoteTab _activeTab = _QuoteTab.all;

  final List<_QuoteJob> _mockJobs = const [
    _QuoteJob(
      id: 1,
      userName: 'Dianne Russell',
      status: _QuoteJobStatus.accepted,
      timestamp: '20 min ago',
      title:
          'I have two tickets for the Al-Nassr  Paris match for sale design ',
      quote: '8 Sec',
      price: r'$600',
      location: 'Jaddah',
      services: ['Design', 'Banner Design'],
    ),
    _QuoteJob(
      id: 2,
      userName: 'Cameron Williamson',
      status: _QuoteJobStatus.rejected,
      timestamp: '20 min ago',
      title:
          'I have two tickets for the Al-Nassr  Paris match for sale design ',
      quote: '8 Sec',
      price: r'$600',
      location: 'Jaddah',
      services: ['Design', 'Banner Design'],
    ),
    _QuoteJob(
      id: 3,
      userName: 'Dianne Russell',
      status: _QuoteJobStatus.accepted,
      timestamp: '20 min ago',
      title:
          'I have two tickets for the Al-Nassr  Paris match for sale design ',
      quote: '8 Sec',
      price: r'$600',
      location: 'Jaddah',
      services: ['Design', 'Banner Design'],
    ),
    _QuoteJob(
      id: 4,
      userName: 'Cameron Williamson',
      status: _QuoteJobStatus.rejected,
      timestamp: '20 min ago',
      title:
          'I have two tickets for the Al-Nassr  Paris match for sale design ',
      quote: '8 Sec',
      price: r'$600',
      location: 'Jaddah',
      services: ['Design', 'Banner Design'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;

    final filteredJobs = _mockJobs
        .where((job) {
          switch (_activeTab) {
            case _QuoteTab.all:
              return true;
            case _QuoteTab.accepted:
              return job.status == _QuoteJobStatus.accepted;
            case _QuoteTab.rejected:
              return job.status == _QuoteJobStatus.rejected;
          }
        })
        .toList(growable: false);

    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: Stack(
        children: [
          // Background blur ellipse (same as TSX)
          Positioned(
            left: MediaQuery.of(context).size.width * 0.25 + 20.5.w,
            top: statusBarHeight + 11.h,
            child: SizedBox(
              width: 430.w,
              height: 137.h,
              child: CustomPaint(painter: _EllipsePainter()),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                // Header
                Container(
                  color: AllColor.white,
                  padding: EdgeInsets.fromLTRB(24.w, 10.h, 24.w, 14.h),
                  child: SizedBox(
                    height: 44.h,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: _HeaderIconButton(
                            icon: Icons.arrow_back,
                            onTap: () => Navigator.of(context).maybePop(),
                          ),
                        ),
                        Text(
                          'Quote',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            color: AllColor.black,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Tabs
                Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 18.h, 16.w, 8.h),
                  child: _QuoteTabs(
                    activeTab: _activeTab,
                    onChanged: (tab) => setState(() => _activeTab = tab),
                  ),
                ),

                // Job cards list
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
                    itemCount: filteredJobs.length,
                    separatorBuilder: (_, __) => SizedBox(height: 8.h),
                    itemBuilder: (context, index) =>
                        _QuoteJobCard(job: filteredJobs[index]),
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

class _QuoteTabs extends StatelessWidget {
  final _QuoteTab activeTab;
  final ValueChanged<_QuoteTab> onChanged;

  const _QuoteTabs({required this.activeTab, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 126,
          child: _TabItem(
            label: 'All jobs',
            isSelected: activeTab == _QuoteTab.all,
            alignment: Alignment.centerLeft,
            onTap: () => onChanged(_QuoteTab.all),
          ),
        ),
        Expanded(
          flex: 108,
          child: _TabItem(
            label: 'Accepted',
            isSelected: activeTab == _QuoteTab.accepted,
            alignment: Alignment.center,
            onTap: () => onChanged(_QuoteTab.accepted),
          ),
        ),
        Expanded(
          flex: 164,
          child: _TabItem(
            label: 'Rejected',
            isSelected: activeTab == _QuoteTab.rejected,
            alignment: Alignment.center,
            onTap: () => onChanged(_QuoteTab.rejected),
          ),
        ),
      ],
    );
  }
}

class _TabItem extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Alignment alignment;
  final VoidCallback onTap;

  const _TabItem({
    required this.label,
    required this.isSelected,
    required this.alignment,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: alignment,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? AllColor.black : const Color(0xFFDADADA),
              width: 1,
            ),
          ),
        ),
        child: Text(
          label,
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
  }
}

class _QuoteJobCard extends StatelessWidget {
  final _QuoteJob job;

  const _QuoteJobCard({required this.job});

  @override
  Widget build(BuildContext context) {
    final badgeBg = job.isAccepted
        ? const Color(0x0F2C58FF)
        : const Color(0x1AFF3B30);
    final badgeText = job.isAccepted
        ? const Color(0xFF2C58FF)
        : const Color(0xFFFF3B30);

    return Container(
      width: double.infinity,
      height: job.isAccepted ? 334.h : 278.h,
      decoration: BoxDecoration(
        color: AllColor.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFE6E7EB), width: 1),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row: avatar + user info + status badge
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 20.r,
                  backgroundColor: const Color(0xFFE6E7EB),
                  child: Icon(
                    Icons.person,
                    size: 20.sp,
                    color: const Color(0xFF7D7D7D),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        job.userName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: AllColor.black,
                          fontFamily: 'SF Pro Display',
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        '${job.statusLabel} - ${job.timestamp}',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xB2000000), // rgba(0,0,0,0.7)
                          fontFamily: 'SF Pro Display',
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: badgeBg,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    job.statusLabel,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: badgeText,
                      fontFamily: 'SF Pro Display',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),

            // Title
            Text(
              job.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: AllColor.black,
                fontFamily: 'Inter',
                height: 1.2,
              ),
            ),
            SizedBox(height: 12.h),

            // Info boxes
            Row(
              children: [
                Expanded(
                  child: _InfoBox(label: 'Quote', value: job.quote),
                ),
                SizedBox(width: 9.w),
                Expanded(
                  child: _InfoBox(label: 'Price', value: job.price),
                ),
                SizedBox(width: 9.w),
                Expanded(
                  child: _InfoBox(label: 'Location', value: job.location),
                ),
              ],
            ),
            SizedBox(height: 16.h),

            // Services
            Text(
              'Services'.toUpperCase(),
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF7D7D7D),
                fontFamily: 'SF Pro Display',
                letterSpacing: 0.5,
              ),
            ),
            SizedBox(height: 9.h),
            Wrap(
              spacing: 4.w,
              runSpacing: 4.h,
              children: job.services.map((s) => _ServiceTag(label: s)).toList(),
            ),

            if (job.isAccepted) ...[
              const Spacer(),
              _MessageButton(
                onTap: () {
                  // TODO: open chat / message screen
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _InfoBox extends StatelessWidget {
  final String label;
  final String value;

  const _InfoBox({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65.h,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FBF1),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xFFE1E8D2), width: 1),
      ),
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
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
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
        border: Border.all(color: const Color(0xFFDDDDDD), width: 1),
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

class _MessageButton extends StatelessWidget {
  final VoidCallback onTap;

  const _MessageButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(99.r),
      child: Container(
        height: 40.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AllColor.black,
          borderRadius: BorderRadius.circular(99.r),
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.mail_outline,
                size: 16.sp,
                color: const Color(0xFFF5F5F5),
              ),
              SizedBox(width: 8.w),
              Text(
                'Message',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFFF5F5F5),
                  fontFamily: 'Inter',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _HeaderIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        height: 40.w,
        width: 40.w,
        decoration: BoxDecoration(
          color: AllColor.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
        ),
        alignment: Alignment.center,
        child: Icon(icon, size: 24.sp, color: const Color(0xFF111111)),
      ),
    );
  }
}

/// Custom painter for the background ellipse decoration.
class _EllipsePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final blurPaint = Paint()
      ..color = const Color(0xFFD8EBCB).withOpacity(0.5)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 89.5);

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
