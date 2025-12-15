import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workpleis/core/constants/color_control/home_color.dart';
import 'package:workpleis/core/constants/color_control/primary_color.dart';

class ClientHomeScreen extends StatelessWidget {
  const ClientHomeScreen({super.key});

  static const String routeName = "/client_home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HomeColor.backgroundWhite,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              height: 232.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    HomeColor.headerBackground.withOpacity(0.95),
                    HomeColor.headerBackground,
                  ],
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                children: [
                  SizedBox(height: 30.h),
                  // Header row with avatar, bell, and post butSton
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Avatar and name
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: PrimaryColor.backgroundWhite,
                                width: 3.w,
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 26.r,
                              backgroundColor: Colors.transparent,
                              backgroundImage: NetworkImage(
                                'https://i.pravatar.cc/150?img=12',
                              ),
                              onBackgroundImageError: (_, __) {},
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: HomeColor.avatarBackground,
                                ),
                                child: Center(
                                  child: Text(
                                    'M',
                                    style: TextStyle(
                                      color: HomeColor.avatarText,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Hello,',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400, // Regular (400)
                                  height: 1.0, // 100% line height
                                  letterSpacing: -0.32,
                                  color: HomeColor.headerSubtext,
                                ),
                              ),
                              Text(
                                'Muhammad',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 19.sp,
                                  fontWeight: FontWeight.w700,
                                  height: 1.0, // 100% line height
                                  letterSpacing: -0.32,
                                  color: HomeColor.headerText, // #000000
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      // Notification bell and Post a job button
                      Row(
                        children: [
                          // Notification bell button
                          Container(
                            width: 44.w,
                            height: 44.w,
                            decoration: BoxDecoration(
                              color: HomeColor.backgroundWhite,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: IconButton(
                              onPressed: () {},
                              padding: EdgeInsets.zero,
                              icon: Icon(
                                Icons.notifications_none,
                                size: 20.sp,
                                color: HomeColor.headerText,
                              ),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          // Post a job button
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: HomeColor.headerButtonBg,
                              foregroundColor: HomeColor.headerButtonText,
                              padding: EdgeInsets.only(
                                top: 10.h,
                                bottom: 10.h,
                                left: 16.w,
                                right: 16.w,
                              ),
                              minimumSize: Size(0, 44.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                              elevation: 1,
                              shadowColor: Colors.black.withOpacity(0.2),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.add,
                                  size: 18.sp,
                                  color: HomeColor.headerButtonText,
                                ),
                                SizedBox(width: 5.w),
                                Text(
                                  'Post a job',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    height: 1.0,
                                    letterSpacing: 0,
                                    color: HomeColor.headerButtonText,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  // Search bar
                  _buildSearchBar(),
                ],
              ),
            ),
          ),
          // Categories section
          SliverToBoxAdapter(
            child: _buildSection(
              title: 'Categories',
              child: SizedBox(
                height: 140.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return _CategoryCard(item: categories[index]);
                  },
                ),
              ),
            ),
          ),
          // Your Active Jobs section
          SliverToBoxAdapter(
            child: _buildSection(
              title: 'Your Active Jobs',
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: activeJobs
                      .map((job) => _ActiveJobCard(job: job))
                      .toList(),
                ),
              ),
            ),
          ),
          // Inspired by UI/UX trends section
          SliverToBoxAdapter(
            child: _buildSection(
              title: 'Inspired by UI/UX trends',
              child: SizedBox(
                height: 200.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  itemCount: trendingJobs.length,
                  itemBuilder: (context, index) {
                    return _TrendingJobCard(job: trendingJobs[index]);
                  },
                ),
              ),
            ),
          ),
          // Top Service Providers section
          SliverToBoxAdapter(
            child: _buildSection(
              title: 'Top Service Providers',
              child: SizedBox(
                height: 220.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  itemCount: serviceProviders.length,
                  itemBuilder: (context, index) {
                    return _ProviderCard(provider: serviceProviders[index]);
                  },
                ),
              ),
            ),
          ),
          // Recently Viewed section
          SliverToBoxAdapter(
            child: _buildSection(
              title: 'Recently Viewed',
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: recentlyViewed
                      .map((job) => _RecentlyViewedCard(job: job))
                      .toList(),
                ),
              ),
            ),
          ),
          // How it works section
          SliverToBoxAdapter(
            child: _buildSection(
              title: 'How it works',
              showSeeAll: false,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: howItWorksSteps.map((step) {
                        return Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.w),
                            child: _StepCard(step: step),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 16.h),
                    // How it works banner
                    Container(
                      width: double.infinity,
                      height: 150.h,
                      decoration: BoxDecoration(
                        color: HomeColor.howItWorksBannerBg,
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 60.w,
                            height: 60.w,
                            decoration: BoxDecoration(
                              color: HomeColor.howItWorksBannerPlayButton,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.play_arrow,
                              color: HomeColor.howItWorksBannerText,
                              size: 32.sp,
                            ),
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            'How it works',
                            style: TextStyle(
                              color: HomeColor.howItWorksBannerText,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 24.h)),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 60.h,
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF), // #FFFFFF
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 0, right: 60.w),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'What are you looking for?',
                hintStyle: GoogleFonts.plusJakartaSans(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  height: 1.0,
                  letterSpacing: 0.0,
                  color: HomeColor.searchBarText,
                ),
                filled: true,
                fillColor: const Color(0xFFFFFFFF), // #FFFFFF
                contentPadding: EdgeInsets.symmetric(
                  vertical: 20.h,
                  horizontal: 16.w,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: HomeColor.searchBarIcon,
                  size: 20.sp,
                ),
                prefixIconConstraints: BoxConstraints(
                  minWidth: 40.w,
                  minHeight: 20.h,
                ),
                // Using theme-based border styling with custom radius (24px for search bar)
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24.r),
                  borderSide: BorderSide(
                    color: Colors.grey.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24.r),
                  borderSide: BorderSide(
                    color: PrimaryColor.textPrimary, // Black from theme
                    width: 1,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24.r),
                  borderSide: BorderSide(
                    color: Colors.grey.withOpacity(0.2),
                    width: 1,
                  ),
                ),
              ),
              style: GoogleFonts.plusJakartaSans(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                height: 1.0,
                letterSpacing: 0.0,
                color: HomeColor.searchBarText,
              ),
            ),
          ),
          Positioned(
            right: 8.w,
            top: 14.h,
            child: Container(
              width: 32.w,
              height: 32.w,
              decoration: BoxDecoration(
                color: HomeColor.filterButtonBg, // Very light gray background
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: () {},
                padding: EdgeInsets.zero,
                icon: Icon(
                  Icons.filter_list, // Three horizontal lines icon
                  size: 18.sp,
                  color: HomeColor.filterButtonIcon,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required Widget child,
    bool showSeeAll = true,
  }) {
    return Padding(
      padding: EdgeInsets.only(top: 24.h, bottom: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: HomeColor.sectionTitle,
                  ),
                ),
                if (showSeeAll)
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      'See all',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: HomeColor.sectionSeeAll,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          child,
        ],
      ),
    );
  }
}

// Category Card Widget
class _CategoryCard extends StatelessWidget {
  final CategoryItem item;

  const _CategoryCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140.w,
      margin: EdgeInsets.only(right: 12.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: item.bgColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              color: item.color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(item.icon, color: item.color, size: 24.sp),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.title,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: HomeColor.categoryText,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                item.subtitle,
                style: TextStyle(
                  fontSize: 11.sp,
                  color: HomeColor.categorySubtext,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Active Job Card Widget
class _ActiveJobCard extends StatelessWidget {
  final JobItem job;

  const _ActiveJobCard({required this.job});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: HomeColor.jobCardBackground,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: HomeColor.jobCardShadow.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image placeholder
          Container(
            width: 100.w,
            height: 100.w,
            decoration: BoxDecoration(
              color: HomeColor.activeJobImageBg,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Center(
              child: Text(
                'UI/UX',
                style: TextStyle(
                  fontSize: 10.sp,
                  color: HomeColor.activeJobImageText,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
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
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: HomeColor.textPrimary,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            job.category,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: HomeColor.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      job.price,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: HomeColor.textPrimary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Wrap(
                  spacing: 6.w,
                  runSpacing: 6.h,
                  children: [
                    _buildChip('🇳🇱 ${job.location}', HomeColor.jobCardChipBg),
                    _buildChip(job.type, HomeColor.jobCardChipBg),
                    _buildChip('Open', HomeColor.activeJobOpenChipBg),
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 14.sp,
                      color: HomeColor.jobCardMetaIcon,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      job.timeAgo,
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: HomeColor.jobCardMetaText,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Icon(
                      Icons.business,
                      size: 14.sp,
                      color: HomeColor.jobCardMetaIcon,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      job.company ?? '',
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: HomeColor.jobCardMetaText,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: HomeColor.activeJobPendingChipBg,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        job.status ?? '',
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: HomeColor.jobCardStatusText,
                          fontWeight: FontWeight.w600,
                        ),
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

  Widget _buildChip(String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 10.sp, color: HomeColor.jobCardChipText),
      ),
    );
  }
}

// Trending Job Card Widget
class _TrendingJobCard extends StatelessWidget {
  final JobItem job;

  const _TrendingJobCard({required this.job});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280.w,
      margin: EdgeInsets.only(right: 12.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: HomeColor.jobCardBackground,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: HomeColor.jobCardShadow.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image placeholder
          Container(
            width: double.infinity,
            height: 80.h,
            decoration: BoxDecoration(
              color: HomeColor.trendingJobImageBg,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Center(
              child: Text(
                'Icon',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: HomeColor.trendingJobImageText,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      job.title,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: HomeColor.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      job.category,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: HomeColor.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                job.price,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: HomeColor.textPrimary,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Icon(Icons.star, size: 14.sp, color: HomeColor.trendingJobRating),
              SizedBox(width: 4.w),
              Text(
                '${job.rating} (${job.reviewCount})',
                style: TextStyle(
                  fontSize: 11.sp,
                  color: HomeColor.jobCardCategory,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: 8.w),
              Icon(Icons.flag, size: 14.sp, color: HomeColor.jobCardMetaIcon),
              SizedBox(width: 4.w),
              Text(
                job.location,
                style: TextStyle(
                  fontSize: 11.sp,
                  color: HomeColor.textSecondary,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              _buildChip(job.type, HomeColor.jobCardChipBg),
              const Spacer(),
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 12.sp,
                    color: HomeColor.jobCardMetaIcon,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    job.timeAgo,
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: HomeColor.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChip(String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 10.sp, color: HomeColor.jobCardChipText),
      ),
    );
  }
}

// Provider Card Widget
class _ProviderCard extends StatelessWidget {
  final ProviderItem provider;

  const _ProviderCard({required this.provider});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.w,
      margin: EdgeInsets.only(right: 12.w),
      decoration: BoxDecoration(
        color: HomeColor.jobCardBackground,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: HomeColor.jobCardShadow.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image banner
          Container(
            width: double.infinity,
            height: 120.h,
            decoration: BoxDecoration(
              color: HomeColor.providerCardImageBg,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.r),
                topRight: Radius.circular(24.r),
              ),
            ),
            child: Center(
              child: Icon(
                Icons.person,
                size: 60.sp,
                color: HomeColor.providerCardImageIcon,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  provider.name,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: HomeColor.textPrimary,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  provider.category,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: HomeColor.textSecondary,
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      size: 14.sp,
                      color: HomeColor.trendingJobRating,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      '${provider.rating} (${provider.reviewCount})',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: HomeColor.jobCardCategory,
                        fontWeight: FontWeight.w500,
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

// Recently Viewed Card Widget
class _RecentlyViewedCard extends StatelessWidget {
  final JobItem job;

  const _RecentlyViewedCard({required this.job});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: HomeColor.jobCardBackground,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: HomeColor.jobCardShadow.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image placeholder
          Container(
            width: 100.w,
            height: 100.w,
            decoration: BoxDecoration(
              color: HomeColor.recentlyViewedImageBg,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Center(
              child: Icon(
                Icons.laptop,
                size: 40.sp,
                color: HomeColor.recentlyViewedImageIcon,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
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
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: HomeColor.textPrimary,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            job.category,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: HomeColor.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      job.price,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: HomeColor.textPrimary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      size: 14.sp,
                      color: HomeColor.trendingJobRating,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      '${job.rating} (${job.reviewCount})',
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: HomeColor.jobCardCategory,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Icon(
                      Icons.flag,
                      size: 14.sp,
                      color: HomeColor.jobCardMetaIcon,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      job.location,
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: HomeColor.textSecondary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    _buildChip(job.type, HomeColor.jobCardChipBg),
                    const Spacer(),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 12.sp,
                          color: HomeColor.jobCardMetaIcon,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          job.timeAgo,
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: HomeColor.textSecondary,
                          ),
                        ),
                      ],
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

  Widget _buildChip(String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 10.sp, color: HomeColor.jobCardChipText),
      ),
    );
  }
}

// Step Card Widget
class _StepCard extends StatelessWidget {
  final StepItem step;

  const _StepCard({required this.step});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: HomeColor.backgroundWhite,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: HomeColor.stepCardBorder),
        boxShadow: [
          BoxShadow(
            color: HomeColor.stepCardShadow.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: HomeColor.stepCardIconBg,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  step.icon,
                  size: 24.sp,
                  color: HomeColor.stepCardIcon,
                ),
              ),
              Container(
                width: 20.w,
                height: 20.w,
                decoration: BoxDecoration(
                  color: HomeColor.stepCardBadgeBg,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    step.number,
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: HomeColor.stepCardBadgeText,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            step.title,
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
              color: HomeColor.stepCardTitle,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// Dummy data
final List<CategoryItem> categories = [
  CategoryItem(
    title: 'Everyday Task',
    subtitle: '80 jobs posted',
    icon: Icons.apps,
    color: HomeColor.categoryCard1Icon,
    bgColor: HomeColor.categoryCard1Bg,
  ),
  CategoryItem(
    title: 'Professional Help',
    subtitle: '12 jobs posted',
    icon: Icons.refresh,
    color: HomeColor.categoryCard2Icon,
    bgColor: HomeColor.categoryCard2Bg,
  ),
  CategoryItem(
    title: 'Tech Support',
    subtitle: '45 jobs posted',
    icon: Icons.computer,
    color: HomeColor.categoryCard3Icon,
    bgColor: HomeColor.categoryCard3Bg,
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
    imageUrl: '',
  ),
];

final List<JobItem> trendingJobs = [
  JobItem(
    title: '3d icon for mobile app',
    category: 'IconDesign',
    price: '\$3,500',
    location: 'Netherlands',
    type: 'Part-time',
    rating: 5.0,
    reviewCount: 300,
    timeAgo: '59 min ago',
    imageUrl: '',
  ),
  JobItem(
    title: 'Logo design for startup',
    category: 'Branding',
    price: '\$2,800',
    location: 'Germany',
    type: 'Part-time',
    rating: 4.9,
    reviewCount: 150,
    timeAgo: '2 hours ago',
    imageUrl: '',
  ),
];

final List<ProviderItem> serviceProviders = [
  ProviderItem(
    name: 'Nina Panel',
    category: 'Brand Designer',
    rating: 4.8,
    reviewCount: 350,
    imageUrl: '',
  ),
  ProviderItem(
    name: 'Sofia',
    category: 'UI/UX Designer',
    rating: 4.9,
    reviewCount: 280,
    imageUrl: '',
  ),
];

final List<JobItem> recentlyViewed = [
  JobItem(
    title: 'Website redesign',
    category: 'UI/UX Design',
    price: '\$14,000',
    location: 'Canada',
    type: 'Full-time',
    rating: 4.8,
    reviewCount: 290,
    timeAgo: '59 min ago',
    imageUrl: '',
  ),
  JobItem(
    title: 'Mobile app UI',
    category: 'UI/UX Design',
    price: '\$8,500',
    location: 'USA',
    type: 'Part-time',
    rating: 4.7,
    reviewCount: 120,
    timeAgo: '1 hour ago',
    imageUrl: '',
  ),
];

final List<StepItem> howItWorksSteps = [
  StepItem(number: '1', title: 'Post a job', icon: Icons.work_outline),
  StepItem(number: '2', title: 'Get Offers', icon: Icons.handshake_outlined),
  StepItem(number: '3', title: 'Choose a worker', icon: Icons.people_outline),
];

// Data models
class CategoryItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final Color bgColor;

  CategoryItem({
    required this.title,
    required this.subtitle,
    required this.icon,
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
  });
}

class ProviderItem {
  final String name;
  final String category;
  final double rating;
  final int reviewCount;
  final String imageUrl;

  ProviderItem({
    required this.name,
    required this.category,
    required this.rating,
    required this.reviewCount,
    required this.imageUrl,
  });
}

class StepItem {
  final String number;
  final String title;
  final IconData icon;

  StepItem({required this.number, required this.title, required this.icon});
}
