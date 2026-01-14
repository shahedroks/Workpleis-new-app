import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/core/constants/color_control/home_color.dart';

class ClientHomeScreen extends StatefulWidget {
  const ClientHomeScreen({super.key});

  static const String routeName = "/client_home";

  @override
  State<ClientHomeScreen> createState() => _ClientHomeScreenState();
}

class _ClientHomeScreenState extends State<ClientHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HomeColor.backgroundWhite,
      extendBody: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFD8EBCB), Color(0xFFF3F5F7)],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 22.h),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 20.h,
                  ),
                  child: Column(
                    children: [
                      _Header(),
                      SizedBox(height: 18.h),
                      _SearchBar(),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  color: const Color(0xFFF9F9F9),
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Categories',
                              style: TextStyle(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'See all',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.h),
                      SizedBox(
                        height: 147.h,
                        child: ListView.separated(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) =>
                              _CategoryCard(item: categories[index]),
                          separatorBuilder: (_, __) => SizedBox(width: 12.w),
                          itemCount: categories.length,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              _Section(
                title: 'Your Active Jobs',
                child: SizedBox(
                  // Trim height so the cards hug their content and avoid excess
                  // empty space beneath each item.
                  height: 222.h,
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) =>
                        _ActiveJobCard(job: activeJobs[index]),
                    separatorBuilder: (_, __) => SizedBox(width: 12.w),
                    itemCount: activeJobs.length,
                  ),
                ),
              ),

              
              _Section(
                title: 'Inspirated by UI/UX trends',
                child: SizedBox(
                  height: 255.h,
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) =>
                        _TrendingJobCard(job: trendingJobs[index]),
                    separatorBuilder: (_, __) => SizedBox(width: 12.w),
                    itemCount: trendingJobs.length,
                  ),
                ),
              ),
              _Section(
                title: 'Top Service Providers',
                child: SizedBox(
                  height: 357.h,
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) =>
                        _ProviderCard(provider: serviceProviders[index]),
                    separatorBuilder: (_, __) => SizedBox(width: 12.w),
                    itemCount: serviceProviders.length,
                  ),
                ),
              ),
              _Section(
                title: 'Recently Viewed',
                child: SizedBox(
                  height: 326.h,
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) =>
                        _RecentlyViewedCard(job: recentlyViewed[index]),
                    separatorBuilder: (_, __) => SizedBox(width: 12.w),
                    itemCount: recentlyViewed.length,
                  ),
                ),
              ),
              _Section(
                title: 'How it works',
                showSeeAll: false,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 180.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          gradient: const LinearGradient(
                            colors: [Color(0xFFBFD4B2), Color(0xFF010201)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: Stack(
                          children: [
                            Center(
                              child: Text(
                                'How it works',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Center(
                              child: Container(
                                width: 56.w,
                                height: 56.w,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFCAFF45),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.play_arrow,
                                  color: Colors.black,
                                  size: 28.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h),
                      SizedBox(
                        height: 200.h,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) =>
                              _StepChip(step: steps[index]),
                          separatorBuilder: (_, __) => SizedBox(width: 8.w),
                          itemCount: steps.length,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 120.h)),
            ],
          ),
        ),
      ),

      bottomNavigationBar: _BottomNav(),
    );
  }
}

class _Header extends StatefulWidget {
  @override
  State<_Header> createState() => _HeaderState();
}

class _HeaderState extends State<_Header> {
  final GlobalKey _menuButtonKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 30.r,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            radius: 27.r,
            backgroundColor: Color(0xFF8AC464),
            backgroundImage: const AssetImage('assets/images/home/image.png'),
          ),
        ),
        SizedBox(width: 12.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello,',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF525252),
              ),
            ),
            Text(
              'Muhammad',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 19.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ],
        ),
        SizedBox(width: 12.w),
        _CircleIcon(icon: Icons.notifications_outlined, onTap: () {}),
        Spacer(),
        GestureDetector(
          key: _menuButtonKey,
          onTap: () {
            final RenderBox? renderBox =
                _menuButtonKey.currentContext?.findRenderObject() as RenderBox?;
            if (renderBox != null) {
              final Offset offset = renderBox.localToGlobal(Offset.zero);
              final Size size = renderBox.size;
              final double screenWidth = MediaQuery.of(context).size.width;
              final double menuWidth = 180.w;
              final double left = screenWidth - menuWidth - 24.w;

              showMenu(
                context: context,
                position: RelativeRect.fromLTRB(
                  left,
                  offset.dy + size.height + 8.h,
                  screenWidth - left - menuWidth,
                  offset.dy + size.height + 8.h,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                color: Colors.white,
                elevation: 8,
                items: [
                  PopupMenuItem(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    child: _DropdownMenuItem(
                      icon: Icons.work_outline,
                      label: 'Create Job',
                    ),
                    onTap: () {
                      // Handle Create Job
                    },
                  ),
                  PopupMenuItem(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    child: _DropdownMenuItem(
                      icon: Icons.assignment_outlined,
                      label: 'Create Project',
                    ),
                    onTap: () {
                      // Handle Create Project
                    },
                  ),
                ],
              );
            }
          },
          child: CircleAvatar(
            radius: 20.r,
            backgroundColor: Colors.black,
            child: Text(
              "+",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _CircleIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CircleIcon({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44.w,
      height: 44.w,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        onPressed: onTap,
        icon: Icon(icon, color: Colors.black, size: 20.sp),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      decoration: BoxDecoration(
        color: AllColor.white,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: AllColor.grey300),
      ),
      child: Row(
        children: [
          SizedBox(width: 18.w),
          Icon(Icons.search, color: AllColor.grey700, size: 24.sp),
          SizedBox(width: 8.w),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: 20.h),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'What are you looking for?',
                  hintStyle: GoogleFonts.plusJakartaSans(
                    color: AllColor.grey700,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 12.w),
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              color: AllColor.grey200,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.tune, color: AllColor.grey800, size: 24.sp),
          ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final Widget child;
  final bool showSeeAll;

  const _Section({
    required this.title,
    required this.child,
    this.showSeeAll = true,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  if (showSeeAll)
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'See all',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            child,
          ],
        ),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final CategoryItem item;

  const _CategoryCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 176.w,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFE6E7EB)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 56.w,
            height: 56.w,
            decoration: BoxDecoration(
              color: item.bgColor,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.asset(
                item.imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.image_not_supported,
                    color: item.color,
                    size: 28.sp,
                  );
                },
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.title,
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 4.h),
              Text(
                item.subtitle,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: const Color(0xFF747474),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActiveJobCard extends StatelessWidget {
  final JobItem job;

  const _ActiveJobCard({required this.job});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFE6E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Card Container
          Container(
            width: 382.w,
            decoration: BoxDecoration(
              color: Color(0xFFf6f6f6),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: const Color(0xFFE6E7EB)),
            ),
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Square Thumbnail on Left
                    Container(
                      width: 80.w,
                      height: 80.w,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF6F6F6),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: const Color(0xFFE6E7EB)),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child: job.imageUrl.isNotEmpty
                            ? Image.asset(
                                job.imageUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: const Color(0xFFF6F6F6),
                                    child: const Icon(
                                      Icons.image_not_supported,
                                    ),
                                  );
                                },
                              )
                            : Image.asset(
                                'assets/images/MainLogo.png',
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    // Content Area
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Title and Salary Row
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      job.title,
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      job.category,
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xFF747474),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                job.price,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),

                          // Pills Row
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 6.w,
                  runSpacing: 6.h,
                  children: [
                    _LocationChip(text: job.location),
                    _SimpleChip(text: job.type),
                    _SimpleChip(text: 'Open'),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          // Metadata Row (Outside Card)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Time Posted
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.watch_later_outlined,
                      size: 16.sp,
                      color: const Color(0xFF6D6E6F),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      job.timeAgo,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF6D6E6F),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 10.w),
                // Number of Offers
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.person_pin,
                      size: 16.sp,
                      color: const Color(0xFF6D6E6F),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      job.offers ?? '05 Offers',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF6D6E6F),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 130.w),
                // Status badge
                if (job.status != null)
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 3.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF6ECE2),
                      borderRadius: BorderRadius.circular(999.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 8.w,
                          height: 8.w,
                          decoration: const BoxDecoration(
                            color: Color(0xFFBF7A12),
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          job.status!,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFFBF7A12),
                          ),
                        ),
                      ],
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

class _TrendingJobCard extends StatelessWidget {
  final JobItem job;

  const _TrendingJobCard({required this.job});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350.w,
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: Color(0xFFffffff),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFE6E7EB)),
        boxShadow: [
          BoxShadow(
            color: const Color(0x141C1C1C),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: Color(0xFFf6f6f6),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: const Color(0xFFE6E7EB)),
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 100.w,
                      height: 100.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14.r),
                        color: const Color(0xFFf6f6f6),
                        border: Border.all(color: const Color(0xFFe6e7eb)),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(14.r),
                        child: job.imageUrl.isNotEmpty
                            ? Image.asset(
                                job.imageUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: const Color(0xFFF6F6F6),
                                    child: const Icon(
                                      Icons.image_not_supported,
                                    ),
                                  );
                                },
                              )
                            : Image.asset(
                                'assets/images/MainLogo.png',
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      job.title,
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      job.category,
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xFF747474),
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Icon(
                                    Icons.bookmark_border,
                                    color: Colors.black,
                                    size: 20.sp,
                                  ),
                                  SizedBox(height: 12.h),
                                  Text(
                                    job.price,
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 15.w),
                SizedBox(height: 10.h), // Add space above the rating row
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.star, size: 20.sp, color: Colors.black),
                    SizedBox(width: 6.w),
                    Text(
                      '${job.rating?.toStringAsFixed(1) ?? '5.0'}',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Flexible(
                      child: Text(
                        '(${job.reviewCount ?? 0})',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF747474),
                          decoration: TextDecoration.underline,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Wrap(
                      alignment: WrapAlignment.start,
                      spacing: 6.w,
                      runSpacing: 6.h,
                      children: [
                        _LocationChip(text: job.location),
                        _SimpleChip(text: job.type),
                        // _SimpleChip(text: 'Open'),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 5.h),
              ],
            ),
          ),
          SizedBox(height: 5.h),
          Row(
            children: [
              Icon(
                Icons.access_time,
                size: 18.sp,
                color: const Color(0xFF6D6E6F),
              ),
              SizedBox(width: 6.w),
              Flexible(
                child: Text(
                  job.timeAgo,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF6D6E6F),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProviderCard extends StatelessWidget {
  final ProviderItem provider;

  const _ProviderCard({required this.provider});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 224.w,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFD5D5D5)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(maxHeight: 110.h),
            height: 110.h,
            decoration: BoxDecoration(
              color: const Color(0xFFBFAAFF),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: const Center(
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
          ),
          SizedBox(height: 10.h),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircleAvatar(
                radius: 13,
                backgroundColor: Colors.black12,
                child: Icon(Icons.person, size: 16),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  provider.name,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Text(
            provider.category,
            style: TextStyle(fontSize: 12.sp, color: const Color(0xFF747474)),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4.h),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.star, size: 20.sp, color: Colors.black),
              SizedBox(width: 4.w),
              Flexible(
                child: Text(
                  '${provider.rating} (${provider.reviewCount})',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: const Color(0xFF747474),
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RecentlyViewedCard extends StatelessWidget {
  final JobItem job;

  const _RecentlyViewedCard({required this.job});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 316.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFE6E7EB)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Container(
                height: 174.h,
                margin: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFF6F6F6),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: const Color(0xFFE6E7EB)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: job.imageUrl.isNotEmpty
                      ? Image.asset(
                          job.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: const Color(0xFFF6F6F6),
                              child: const Icon(Icons.image_not_supported),
                            );
                          },
                        )
                      : Image.asset(
                          'assets/images/MainLogo.png',
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              Positioned(
                top: 16.h,
                right: 16.w,
                child: Icon(
                  Icons.bookmark_border,
                  color: Colors.black,
                  size: 24.sp,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            job.title,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            job.category,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF747474),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      job.price,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Icon(Icons.star, size: 20.sp, color: Colors.black),
                    SizedBox(width: 4.w),
                    Text(
                      '${job.rating}',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      '(${job.reviewCount})',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF747474),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    _Chip(text: job.location, icon: Icons.flag),
                    SizedBox(width: 8.w),
                    _Chip(text: job.type, icon: Icons.work_outline),
                    const Spacer(),
                    Icon(
                      Icons.access_time,
                      size: 20.sp,
                      color: const Color(0xFF6D6E6F),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      job.timeAgo,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF6D6E6F),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StepChip extends StatelessWidget {
  final StepItem step;

  const _StepChip({required this.step});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120.w,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F6F6),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100.w,
            height: 100.w,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(step.icon, size: 24.sp, color: Colors.black),
          ),
          SizedBox(height: 16.h),
          Text(
            step.title,
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8.h),
          Container(
            width: 24.w,
            height: 24.w,
            decoration: const BoxDecoration(
              color: Color(0xFFCAFF45),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                step.number,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String text;
  final IconData icon;

  const _Chip({required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFFE6E7EB)),
        boxShadow: [
          BoxShadow(
            color: const Color(0x0D000000),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18.sp, color: Colors.black),
          SizedBox(width: 10.w),
          Flexible(
            child: Text(
              text,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _LocationChip extends StatelessWidget {
  final String text;

  const _LocationChip({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFDDDDDD)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _CountryFlag(country: text),
          SizedBox(width: 8.w),
          Flexible(
            child: Text(
              text,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _CountryFlag extends StatelessWidget {
  final String country;

  const _CountryFlag({required this.country});

  @override
  Widget build(BuildContext context) {
    // Netherlands flag: red, white, blue horizontal stripes (circular)
    if (country.toLowerCase().contains('netherlands')) {
      return Container(
        width: 16.w,
        height: 16.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFFE0E0E0), width: 0.5),
        ),
        child: ClipOval(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  color: const Color(0xFFAE1C28), // Red
                ),
              ),
              Expanded(
                child: Container(width: double.infinity, color: Colors.white),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  color: const Color(0xFF21468B), // Blue
                ),
              ),
            ],
          ),
        ),
      );
    }
    // Default flag icon for other countries
    return Container(
      width: 16.w,
      height: 16.w,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFFE0E0E0),
      ),
      child: Icon(Icons.flag, size: 10.sp, color: Colors.black54),
    );
  }
}

class _SimpleChip extends StatelessWidget {
  final String text;

  const _SimpleChip({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFDDDDDD)),
      ),
      child: Text(
        text,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String text;

  const _StatusChip({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: const Color(0xFFD1A06C).withOpacity(0.19),
        borderRadius: BorderRadius.circular(40.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 4.w,
            height: 4.w,
            decoration: const BoxDecoration(
              color: Color(0xFFCB8709),
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 4.w),
          Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFFCB8709),
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 95.h,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFD6D6D6))),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              _NavItem(icon: Icons.home, label: 'Home', active: true),
              _NavItem(icon: Icons.work_outline, label: 'Jobs'),
              SizedBox(width: 60),
              _NavItem(icon: Icons.mail_outline, label: 'Message'),
              _NavItem(icon: Icons.person_outline, label: 'Profile'),
            ],
          ),
          Positioned(
            bottom: 6.h,
            child: Container(
              width: 134.w,
              height: 5.h,
              decoration: BoxDecoration(
                color: const Color(0xFF8B8B8B).withOpacity(0.5),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;

  const _NavItem({
    required this.icon,
    required this.label,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: active ? Colors.black : const Color(0xFF797979),
          size: 24.sp,
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 16.sp,
            color: active ? Colors.black : const Color(0xFF797979),
            fontWeight: active ? FontWeight.w500 : FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

class _DropdownMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _DropdownMenuItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20.sp, color: Colors.black),
        SizedBox(width: 12.w),
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

// Dummy data
final List<CategoryItem> categories = [
  CategoryItem(
    title: 'Everyday Task',
    subtitle: '15 jobs posted',
    imagePath: 'assets/images/home/image 588254844.png',
    color: const Color(0xFF000000),
    bgColor: const Color(0xFF020402),
  ),
  CategoryItem(
    title: 'Professional Help',
    subtitle: '12 jobs posted',
    imagePath: 'assets/images/home/image - 2025-11-08T225106.865 1.png',
    color: const Color(0xFF6942F7),
    bgColor: const Color(0xFFC7C7FF),
  ),
  CategoryItem(
    title: 'Business Support',
    subtitle: '12 jobs posted',
    imagePath: 'assets/images/home/Group 1171277188.png',
    color: const Color(0xFF2BB0BA),
    bgColor: const Color(0xFFDBF8FF),
  ),
  CategoryItem(
    title: 'Logo Design',
    subtitle: '12 jobs posted',
    imagePath: 'assets/images/home/Rectangle 34624714.png',
    color: const Color(0xFF8B7BFF),
    bgColor: const Color(0xFFC7C7FF),
  ),
];

final List<JobItem> activeJobs = [
  JobItem(
    title: 'Senior Conversion Designer-Redesign',
    category: 'UI/UX Design',
    price: '\$3,500',
    location: 'Netherlands',
    type: 'Full-time',
    status: 'Pending',
    timeAgo: '59 min ago',
    company: 'D5 Office',
    offers: '05 Offers',
    imageUrl: 'assets/images/home/Rectangle 34624714.png',
  ),
  JobItem(
    title: 'Junior Product Designer-Launch',
    category: 'UI/UX Design',
    price: '\$500',
    location: 'Germany',
    type: 'Part-time',
    status: 'Open',
    timeAgo: '1 hour ago',
    offers: '12 Offers',
    imageUrl: 'assets/images/home/Rectangle 34624714 (1).png',
  ),
  JobItem(
    title: 'Lead Interaction Designer-Overhaul',
    category: 'UI/UX Design',
    price: '\$2,500',
    location: 'United States',
    type: 'Contract',
    status: 'Open',
    timeAgo: '2 hours ago',
    offers: '08 Offers',
    imageUrl: 'assets/images/home/Rectangle 34624714 (2).png',
  ),
];

final List<JobItem> trendingJobs = [
  JobItem(
    title: '3d Icon for mobile app',
    category: 'Icon Design',
    price: '\$3,200',
    location: 'Netherlands',
    type: 'Part-time',
    rating: 5.0,
    reviewCount: 308,
    timeAgo: '59 min ago',
    imageUrl: 'assets/images/home/Rectangle 34625421.png',
  ),
  JobItem(
    title: 'Landing page redesign',
    category: 'Web Design',
    price: '\$5,000',
    location: 'Canada',
    type: 'Full-time',
    rating: 4.8,
    reviewCount: 215,
    timeAgo: '12 min ago',
    imageUrl: 'assets/images/home/Group 1171277188.png',
  ),
  JobItem(
    title: 'E-commerce site setup',
    category: 'UI/UX Design',
    price: '\$4,200',
    location: 'Canada',
    type: 'Contract',
    rating: 4.9,
    reviewCount: 142,
    timeAgo: '30 min ago',
    imageUrl: 'assets/images/home/Group 1171277176.png',
  ),
  JobItem(
    title: 'Brand identity creation',
    category: 'Graphic Design',
    price: '\$2,800',
    location: 'Australia',
    type: 'Freelance',
    rating: 4.7,
    reviewCount: 88,
    timeAgo: '1 hr ago',
    imageUrl: 'assets/images/home/image 588254844.png',
  ),
];

final List<ProviderItem> serviceProviders = [
  ProviderItem(
    name: 'Liam Chen',
    category: 'Logo Designer',
    rating: 4.7,
    reviewCount: 180,
  ),
  ProviderItem(
    name: 'Fowad Kobir',
    category: 'A- Artist',
    rating: 5.0,
    reviewCount: 200,
  ),
  ProviderItem(
    name: 'Nina Patel',
    category: 'Brand Designer',
    rating: 4.8,
    reviewCount: 150,
  ),
  ProviderItem(
    name: 'Sofia Ramirez',
    category: 'D- Writer',
    rating: 4.9,
    reviewCount: 220,
  ),
  ProviderItem(
    name: 'Rajesh Kumar',
    category: 'E- Researcher',
    rating: 4.6,
    reviewCount: 160,
  ),
];

final List<JobItem> recentlyViewed = [
  JobItem(
    title: 'Social media graphics',
    category: 'UI/UX Design',
    price: '\$3,200',
    location: 'United Kingdom',
    type: 'Part-time',
    rating: 4.6,
    reviewCount: 176,
    timeAgo: '25 min ago',
    imageUrl: 'assets/images/home/image - 2025-11-08T225106.865 1.png',
  ),
  JobItem(
    title: 'Website redesign',
    category: 'UI/UX Design',
    price: '\$4,000',
    location: 'Canada',
    type: 'Full-time',
    rating: 4.8,
    reviewCount: 220,
    timeAgo: '10 min ago',
    imageUrl: 'assets/images/home/image.png',
  ),
  JobItem(
    title: 'Fiqo Dashboard Design',
    category: 'UI/UX Design',
    price: '\$2,800',
    location: 'Australia',
    type: 'Freelance',
    rating: 4.7,
    reviewCount: 88,
    timeAgo: '1 hr ago',
    imageUrl: 'assets/images/home/Rectangle 34624714.png',
  ),
  JobItem(
    title: 'Mobile app user interface',
    category: 'UI/UX Design',
    price: '\$3,750',
    location: 'Germany',
    type: 'Contract',
    rating: 4.9,
    reviewCount: 145,
    timeAgo: '2 hr ago',
    imageUrl: 'assets/images/home/Rectangle 34625421.png',
  ),
];

final List<StepItem> steps = [
  StepItem(number: '1', title: 'Post a job', icon: Icons.work_outline),
  StepItem(number: '2', title: 'Get Offers', icon: Icons.people_outline),
  StepItem(number: '3', title: 'Choose a workpeer', icon: Icons.people_outline),
  StepItem(number: '4', title: 'Make Payment', icon: Icons.account_balance),
  StepItem(number: '5', title: 'Review Job', icon: Icons.star_border),
  StepItem(number: '6', title: 'Accept Job', icon: Icons.check_circle_outline),
];

// Models
class CategoryItem {
  final String title;
  final String subtitle;
  final String imagePath;
  final Color color;
  final Color bgColor;

  CategoryItem({
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.color,
    required this.bgColor,
  });
}

class JobItem {
  final String title;
  final String category;
  final String price;
  final String location;
  final String type;
  final String? status;
  final double? rating;
  final int? reviewCount;
  final String timeAgo;
  final String? company;
  final String imageUrl;
  final String? offers;

  JobItem({
    required this.title,
    required this.category,
    required this.price,
    required this.location,
    required this.type,
    this.status,
    this.rating,
    this.reviewCount,
    required this.timeAgo,
    this.company,
    required this.imageUrl,
    this.offers,
  });
}

class ProviderItem {
  final String name;
  final String category;
  final double rating;
  final int reviewCount;

  ProviderItem({
    required this.name,
    required this.category,
    required this.rating,
    required this.reviewCount,
  });
}

class StepItem {
  final String number;
  final String title;
  final IconData icon;

  StepItem({required this.number, required this.title, required this.icon});
}
