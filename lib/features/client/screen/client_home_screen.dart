import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workpleis/core/constants/color_control/home_color.dart';

class ClientHomeScreen extends StatelessWidget {
  const ClientHomeScreen({super.key});

  static const String routeName = "/client_home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HomeColor.backgroundWhite,
      extendBody: true,
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFD8EBCB), Color(0xFFF3F5F7)],
            ),
          ),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 16.h,
                  ),
                  child: Column(
                    children: [
                      _Header(),
                      SizedBox(height: 20.h),
                      _SearchBar(),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
              _Section(
                title: 'Categories',
                child: SizedBox(
                  height: 160.h,
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) =>
                        _CategoryCard(item: categories[index]),
                    separatorBuilder: (_, __) => SizedBox(width: 12.w),
                    itemCount: categories.length,
                  ),
                ),
              ),
              _Section(
                title: 'Your Active Jobs',
                child: SizedBox(
                  height: 310.h,
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
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
                  height: 340.h,
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
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
                  height: 250.h,
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
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
                  height: 290.h,
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
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
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 190.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          gradient: const LinearGradient(
                            colors: [Color(0xFFBFD4B2), Color(0xFF010201)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
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
                          ],
                        ),
                      ),
                      SizedBox(height: 16.h),
                      SizedBox(
                        height: 110.h,
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: 60.w,
        height: 60.w,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF1E39F9), Color(0xFF69BBFF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.add, color: Colors.white),
        ),
      ),
      bottomNavigationBar: _BottomNav(),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 26.r,
              backgroundImage: const AssetImage('assets/images/MainLogo.png'),
            ),
            SizedBox(width: 12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello,',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14.sp,
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
          ],
        ),
        Row(
          children: [
            _CircleIcon(icon: Icons.notifications_outlined, onTap: () {}),
            SizedBox(width: 10.w),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: const Color(0xFF1E39F9),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              ),
              child: Row(
                children: [
                  const Icon(Icons.add, color: Colors.white, size: 18),
                  SizedBox(width: 6.w),
                  Text(
                    'Post a job',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(width: 12.w),
          Icon(Icons.search, color: const Color(0xFF96979C), size: 20.sp),
          SizedBox(width: 8.w),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'What are you looking for?',
                hintStyle: GoogleFonts.plusJakartaSans(
                  color: const Color(0xFF96979C),
                  fontSize: 16.sp,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 12.w),
            width: 44.w,
            height: 44.w,
            decoration: const BoxDecoration(
              color: Color(0xFFF3F3F6),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.filter_list, color: Colors.black, size: 20.sp),
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
      child: Padding(
        padding: EdgeInsets.only(top: 12.h, bottom: 8.h),
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
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  if (showSeeAll)
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'See all',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.black87,
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
            child: Icon(item.icon, color: item.color, size: 28.sp),
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
      width: 382.w,
      padding: EdgeInsets.only(bottom: 6.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFE6E7EB)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            height: 96.h,
            margin: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: const Color(0xFFF6F6F6),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.asset(
                'assets/images/MainLogo.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
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
                              fontWeight: FontWeight.w700,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 1.h),
                          Text(
                            job.category,
                            style: TextStyle(
                              fontSize: 10.sp,
                              color: const Color(0xFF747474),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      job.price,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    _Chip(text: job.location, icon: Icons.flag),
                    SizedBox(width: 4.w),
                    _Chip(text: job.type, icon: Icons.watch_later_outlined),
                    SizedBox(width: 4.w),
                    _Chip(text: 'Open', icon: Icons.lock_open),
                    const Spacer(),
                    _StatusChip(text: job.status ?? 'Pending'),
                  ],
                ),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 12.sp,
                      color: const Color(0xFF6D6E6F),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      job.timeAgo,
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: const Color(0xFF6D6E6F),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Icon(
                      Icons.people_alt_outlined,
                      size: 12.sp,
                      color: const Color(0xFF6D6E6F),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      job.offers ?? '05 Offers',
                      style: TextStyle(
                        fontSize: 10.sp,
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

class _TrendingJobCard extends StatelessWidget {
  final JobItem job;

  const _TrendingJobCard({required this.job});

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
          Container(
            height: 112.h,
            margin: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: const Color(0xFFF6F6F6),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.asset(
                'assets/images/MainLogo.png',
                fit: BoxFit.cover,
              ),
            ),
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
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            job.category,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: const Color(0xFF747474),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      job.price,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
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
                      color: const Color(0xFFFFC700),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      '${job.rating?.toStringAsFixed(1) ?? '5.0'} (${job.reviewCount ?? 0})',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: const Color(0xFF747474),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Icon(
                      Icons.flag,
                      size: 14.sp,
                      color: const Color(0xFF6D6E6F),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      job.location,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: const Color(0xFF6D6E6F),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    _Chip(text: job.type, icon: Icons.work_outline),
                    const Spacer(),
                    Icon(
                      Icons.access_time,
                      size: 12.sp,
                      color: const Color(0xFF6D6E6F),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      job.timeAgo,
                      style: TextStyle(
                        fontSize: 11.sp,
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
            height: 132.h,
            decoration: BoxDecoration(
              color: const Color(0xFFBFAAFF),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: const Center(
              child: Icon(Icons.person, size: 60, color: Colors.white),
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              const CircleAvatar(
                radius: 14,
                backgroundColor: Colors.black12,
                child: Icon(Icons.person, size: 16),
              ),
              SizedBox(width: 8.w),
              Text(
                provider.name,
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Text(
            provider.category,
            style: TextStyle(fontSize: 12.sp, color: const Color(0xFF747474)),
          ),
          SizedBox(height: 6.h),
          Row(
            children: [
              Icon(Icons.star, size: 14.sp, color: const Color(0xFFFFC700)),
              SizedBox(width: 4.w),
              Text(
                '${provider.rating} (${provider.reviewCount})',
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
          Container(
            height: 138.h,
            margin: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: const Color(0xFFF6F6F6),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: const Center(
              child: Icon(Icons.laptop, size: 48, color: Colors.black54),
            ),
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
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            job.category,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: const Color(0xFF747474),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      job.price,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
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
                      color: const Color(0xFFFFC700),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      '${job.rating} (${job.reviewCount})',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: const Color(0xFF747474),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Icon(
                      Icons.flag,
                      size: 14.sp,
                      color: const Color(0xFF6D6E6F),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      job.location,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: const Color(0xFF6D6E6F),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    _Chip(text: job.type, icon: Icons.work_outline),
                    const Spacer(),
                    Icon(
                      Icons.access_time,
                      size: 12.sp,
                      color: const Color(0xFF6D6E6F),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      job.timeAgo,
                      style: TextStyle(
                        fontSize: 11.sp,
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
      padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 36.w,
            height: 36.w,
            child: _CircleIcon(icon: step.icon, onTap: () {}),
          ),
          SizedBox(height: 2.h),
          Text(
            step.title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 3.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 2.h),
            decoration: const BoxDecoration(
              color: Color(0xFFCAFF45),
              shape: BoxShape.circle,
            ),
            child: Text(
              step.number,
              style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w700),
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
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F3F6),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14.sp, color: const Color(0xFF6D6E6F)),
          SizedBox(width: 4.w),
          Text(
            text,
            style: TextStyle(fontSize: 12.sp, color: const Color(0xFF6D6E6F)),
          ),
        ],
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
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFDEDD7),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 12.sp, color: const Color(0xFFCB8709)),
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 95.h,
      padding: EdgeInsets.only(bottom: 10.h),
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
              _NavItem(icon: Icons.work_outline, label: 'Project'),
              SizedBox(width: 48),
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
        Icon(icon, color: active ? Colors.black : const Color(0xFF797979)),
        SizedBox(height: 4.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            color: active ? Colors.black : const Color(0xFF797979),
            fontWeight: active ? FontWeight.w600 : FontWeight.w400,
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
    icon: Icons.apps,
    color: const Color(0xFF000000),
    bgColor: const Color(0xFF020402),
  ),
  CategoryItem(
    title: 'Professional Help',
    subtitle: '12 jobs posted',
    icon: Icons.design_services_outlined,
    color: const Color(0xFF6942F7),
    bgColor: const Color(0xFFC7C7FF),
  ),
  CategoryItem(
    title: 'Business Support',
    subtitle: '12 jobs posted',
    icon: Icons.business_center_outlined,
    color: const Color(0xFF2BB0BA),
    bgColor: const Color(0xFFDBF8FF),
  ),
  CategoryItem(
    title: 'Logo Design',
    subtitle: '12 jobs posted',
    icon: Icons.brush_outlined,
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
    imageUrl: '',
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
    imageUrl: '',
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
    imageUrl: '',
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
    imageUrl: '',
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
    imageUrl: '',
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
    imageUrl: '',
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
    imageUrl: '',
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
    imageUrl: '',
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
    imageUrl: '',
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
    imageUrl: '',
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
    imageUrl: '',
  ),
];

final List<StepItem> steps = [
  StepItem(number: '1', title: 'Post a job', icon: Icons.work_outline),
  StepItem(number: '2', title: 'Get Offers', icon: Icons.handshake_outlined),
  StepItem(number: '3', title: 'Choose a workpeer', icon: Icons.people_outline),
  StepItem(number: '4', title: 'Make Payment', icon: Icons.account_balance),
  StepItem(number: '5', title: 'Review Job', icon: Icons.star_border),
  StepItem(number: '6', title: 'Accept Job', icon: Icons.check_circle_outline),
];

// Models
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
