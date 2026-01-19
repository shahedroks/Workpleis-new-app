import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/features/service/service_jobs/submit_quote_screen.dart';

/// Flutter conversion of `lib/features/service/screen/react.tsx`.
///
/// This is the "Full Details" job screen with:
/// - header (back + more)
/// - attach file section
/// - job details card (quote/price/location + description + category chips)
/// - bottom apply button
class ServiceJobFullDetailsScreen extends StatelessWidget {
  const ServiceJobFullDetailsScreen({
    super.key,
    this.title =
        'I have two tickets for the Al-Nassr  Paris match for sale design',
    this.quote = '8 Sec',
    this.price = r'$600',
    this.location = 'Jaddah',
    this.categories = const ['Design', 'Banner Design'],
  });

  static const String routeName = '/service_job_full_details';

  final String title;
  final String quote;
  final String price;
  final String location;
  final List<String> categories;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
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
                    child: _HeaderIconButton(
                      icon: Icons.arrow_back,
                      onTap: () => context.pop(),
                    ),
                  ),
                  Text(
                    'Full Details',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: AllColor.black,
                      fontFamily: 'Inter',
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: _HeaderIconButton(
                      icon: Icons.more_vert,
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8.h),
                    Text(
                      'Attach File',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: AllColor.black,
                        fontFamily: 'SF Pro Display',
                      ),
                    ),
                    SizedBox(height: 12.h),
                    _AttachFileCard(onTap: () {}),
                    SizedBox(height: 16.h),
                    _JobDetailsCard(
                      title: title,
                      quote: quote,
                      price: price,
                      location: location,
                      categories: categories,
                    ),
                    // Extra space so content isn't hidden by bottom button.
                    SizedBox(height: 90.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(24.w, 10.h, 24.w, 12.h),
          child: SizedBox(
            height: 56.h,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SubmitQuoteScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AllColor.black50,
                foregroundColor: const Color(0xFFF5F5F5),
                elevation: 0,
                shape: const StadiumBorder(),
              ),
              child: Text(
                'Apply for job',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Inter',
                ),
              ),
            ),
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

class _AttachFileCard extends StatelessWidget {
  final VoidCallback onTap;

  const _AttachFileCard({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: const Color(0xFFF8F8F8),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            Container(
              height: 31.w,
              width: 31.w,
              decoration: BoxDecoration(
                color: const Color(0xFF82B600),
                borderRadius: BorderRadius.circular(9.r),
              ),
              alignment: Alignment.center,
              child: Icon(
                Icons.attach_file,
                color: AllColor.white,
                size: 18.sp,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Attach file',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF111111),
                      fontFamily: 'Inter',
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'pdf, png, jpeg and max 10mb',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0x8C808080), // rgba(128,128,128,0.55)
                      fontFamily: 'Inter',
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

class _JobDetailsCard extends StatelessWidget {
  final String title;
  final String quote;
  final String price;
  final String location;
  final List<String> categories;

  const _JobDetailsCard({
    required this.title,
    required this.quote,
    required this.price,
    required this.location,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: AllColor.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFE6E7EB), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  title,
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
              ),
              SizedBox(width: 8.w),
              Icon(
                Icons.more_vert,
                size: 24.sp,
                color: const Color(0xFF4F4F4F),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: _InfoCard(label: 'Quote', value: quote),
              ),
              SizedBox(width: 9.w),
              Expanded(
                child: _InfoCard(label: 'Price', value: price),
              ),
              SizedBox(width: 9.w),
              Expanded(
                child: _InfoCard(label: 'Location', value: location),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          const _JobDescription(),
          SizedBox(height: 16.h),
          Text(
            'Services category'.toUpperCase(),
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
            children: categories.map((c) => _CategoryChip(label: c)).toList(),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String label;
  final String value;

  const _InfoCard({required this.label, required this.value});

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

class _CategoryChip extends StatelessWidget {
  final String label;

  const _CategoryChip({required this.label});

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

class _JobDescription extends StatelessWidget {
  const _JobDescription();

  @override
  Widget build(BuildContext context) {
    final baseTextStyle = TextStyle(
      fontSize: 14.sp,
      height: 22 / 14, // matches the 22px line-height from the TSX
      fontFamily: 'Inter',
      color: const Color(0xCC000000), // rgba(0,0,0,0.8)
    );

    return Text.rich(
      TextSpan(
        style: baseTextStyle,
        children: [
          TextSpan(
            text: 'Job Announcement:',
            style: baseTextStyle.copyWith(fontWeight: FontWeight.w400),
          ),
          const TextSpan(text: ' '),
          TextSpan(
            text: 'Senior Designer\n',
            style: baseTextStyle.copyWith(
              fontWeight: FontWeight.w600,
              color: AllColor.black,
            ),
          ),
          TextSpan(
            text: 'Company: ',
            style: baseTextStyle.copyWith(fontWeight: FontWeight.w400),
          ),
          TextSpan(
            text: 'Al Nassr Football Club (Al-Nasr Football Club)\n',
            style: baseTextStyle.copyWith(
              fontWeight: FontWeight.w500,
              color: AllColor.black,
            ),
          ),
          TextSpan(
            text: 'Location: ',
            style: baseTextStyle.copyWith(fontWeight: FontWeight.w400),
          ),
          TextSpan(
            text: 'Riyadh, Saudi Arabia\n',
            style: baseTextStyle.copyWith(
              fontWeight: FontWeight.w500,
              color: AllColor.black,
            ),
          ),
          TextSpan(
            text: 'Timeline: ',
            style: baseTextStyle.copyWith(fontWeight: FontWeight.w400),
          ),
          TextSpan(
            text: 'ASAP\n\n',
            style: baseTextStyle.copyWith(
              fontWeight: FontWeight.w500,
              color: AllColor.black,
            ),
          ),
          TextSpan(
            text:
                'Al Nassr Football Club, known in Arabic as Al-Nasr Football Club, translates to "Victory Football Club," epitomizing our ambitious spirit. Established on October 24, 1955, in Riyadh, Saudi Arabia, Al Nassr is a revered multi-sports club with its football team competing fiercely in the Saudi Pro League. Since the league\'s inception in 1976, Al Nassr has been a consistent contender, participating in every season alongside two other stalwart teams.\n\n',
            style: baseTextStyle.copyWith(fontWeight: FontWeight.w400),
          ),
          TextSpan(
            text: 'Scop of work: \n\n',
            style: baseTextStyle.copyWith(
              fontWeight: FontWeight.w500,
              color: AllColor.black,
            ),
          ),
          TextSpan(
            text:
                'We are seeking a talented and experienced Senior Designer to join our team immediately. The ideal candidate will have a strong background in graphic design, a keen eye for detail, and the ability to create compelling visuals that align with our brand\'s identity and values.',
            style: baseTextStyle.copyWith(fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
