import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import '../model/job_model.dart';
import '../data/jobs_data.dart';

class ClientJobsScreen extends StatefulWidget {
  const ClientJobsScreen({super.key});

  static const String routeName = '/client_jobs';

  @override
  State<ClientJobsScreen> createState() => _ClientJobsScreenState();
}

class _ClientJobsScreenState extends State<ClientJobsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  JobStatus get _selectedTab {
    switch (_tabController.index) {
      case 0:
        return JobStatus.active;
      case 1:
        return JobStatus.pending;
      case 2:
        return JobStatus.completed;
      case 3:
        return JobStatus.cancelled;
      default:
        return JobStatus.active;
    }
  }

  List<JobModel> get _currentJobs {
    switch (_selectedTab) {
      case JobStatus.active:
        return activeJobs;
      case JobStatus.pending:
        return pendingJobs;
      case JobStatus.completed:
        return completedJobs;
      case JobStatus.cancelled:
        return cancelledJobs;
    }
  }

  int _getJobCount(JobStatus status) {
    switch (status) {
      case JobStatus.active:
        return activeJobs.length;
      case JobStatus.pending:
        return pendingJobs.length;
      case JobStatus.completed:
        return completedJobs.length;
      case JobStatus.cancelled:
        return cancelledJobs.length;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA), // Light off-white background
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Jobs',
                    style: TextStyle(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'plus_Jakarta_Sans',
                      color: AllColor.black,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // TODO: Navigate to create job screen
                    },
                    child: Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: const BoxDecoration(
                        color: AllColor.black,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.add,
                        color: AllColor.white,
                        size: 24.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Tabs
            _TabsSection(
              tabController: _tabController,
              getJobCount: _getJobCount,
            ),

            // Job List
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                itemCount: _currentJobs.length,
                separatorBuilder: (context, index) => SizedBox(height: 16.h),
                itemBuilder: (context, index) {
                  return _JobCard(
                    job: _currentJobs[index],
                    onMenuTap: () => _showJobOptionsBottomSheet(context, _currentJobs[index]),
                    onReviewTap: () => _showGiveReviewBottomSheet(context, _currentJobs[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showJobOptionsBottomSheet(BuildContext context, JobModel job) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return _JobOptionsBottomSheet(job: job);
      },
    );
  }

  void _showGiveReviewBottomSheet(BuildContext context, JobModel job) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return _GiveReviewBottomSheet(job: job);
      },
    );
  }
}

class _TabsSection extends StatelessWidget {
  final TabController tabController;
  final int Function(JobStatus) getJobCount;

  const _TabsSection({
    required this.tabController,
    required this.getJobCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: TabBar(
        controller: tabController,
        isScrollable: true,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
            color: AllColor.black,
            width: 2.h,
          ),
          insets: EdgeInsets.only(bottom: 0),
        ),
        indicatorSize: TabBarIndicatorSize.label,
        labelColor: AllColor.black,
        unselectedLabelColor: AllColor.grey600,
        labelStyle: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
          fontFamily: 'plus_Jakarta_Sans',
          color: AllColor.black,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          fontFamily: 'plus_Jakarta_Sans',
          color: AllColor.grey600,
        ),
        labelPadding: EdgeInsets.only(right: 24.w),
        tabs: [
          Tab(
            text: 'Active (${getJobCount(JobStatus.active)})',
          ),
          Tab(
            text: 'Pending (${getJobCount(JobStatus.pending)})',
          ),
          Tab(
            text: 'Completed',
          ),
          Tab(
            text: 'Cancelled (${getJobCount(JobStatus.cancelled)})',
          ),
        ],
      ),
    );
  }
}

class _JobCard extends StatelessWidget {
  final JobModel job;
  final VoidCallback onMenuTap;
  final VoidCallback? onReviewTap;

  const _JobCard({
    required this.job,
    required this.onMenuTap,
    this.onReviewTap,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = job.status == JobStatus.active;
    final isCompleted = job.status == JobStatus.completed;
    
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AllColor.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AllColor.grey200,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title and Menu
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  job.title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'plus_Jakarta_Sans',
                    color: AllColor.black,
                    height: 1.4,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              GestureDetector(
                onTap: onMenuTap,
                child: Icon(
                  Icons.more_vert,
                  size: 20.sp,
                  color: AllColor.black,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // Info boxes - Different for Active vs Pending vs Completed
          if (isActive)
            // Active: Quote, Price, Bid
            Row(
              children: [
                Expanded(
                  child: _InfoBox(label: 'Quote', value: job.quote ?? ''),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: _InfoBox(label: 'Price', value: job.price ?? ''),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: _InfoBox(label: 'Bid', value: job.bid ?? ''),
                ),
              ],
            )
          else if (isCompleted)
            // Completed: Estimate, Cost, Review
            Row(
              children: [
                Expanded(
                  child: _InfoBox(label: 'Estimate', value: job.estimate ?? ''),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: _InfoBox(label: 'Cost', value: job.cost ?? ''),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: _ReviewBox(
                    reviewStatus: job.reviewStatus,
                    rating: job.rating,
                  ),
                ),
              ],
            )
          else
            // Pending/Cancelled: Estimate, Cost, Provider
            Row(
              children: [
                Expanded(
                  child: _InfoBox(label: 'Estimate', value: job.estimate ?? ''),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: _InfoBox(label: 'Cost', value: job.cost ?? ''),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: _InfoBox(
                    label: 'Provider',
                    value: job.provider ?? '',
                    showAvatar: true,
                  ),
                ),
              ],
            ),
          SizedBox(height: 16.h),

          // Job Description - Only for Pending/Others, not Active
          if (!isActive && job.description != null) ...[
            Text(
              job.description!,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                fontFamily: 'plus_Jakarta_Sans',
                color: AllColor.black,
                height: 1.5,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'more...',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                fontFamily: 'plus_Jakarta_Sans',
                color: AllColor.grey600,
              ),
            ),
            SizedBox(height: 16.h),
          ],

          // Services label
          Text(
            'SERVICES',
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w400,
              fontFamily: 'sf_pro',
              color: AllColor.grey600,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: 8.h),

          // Service tags
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: job.services.map((service) {
              return _ServiceTag(label: service);
            }).toList(),
          ),

          // Action Buttons - Different for each status
          if (isCompleted) ...[
            SizedBox(height: 16.h),
            _ReviewButton(
              onTap: onReviewTap ?? () {},
            ),
          ] else if (!isActive) ...[
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: _ActionButton(
                    text: 'Report',
                    isRed: true,
                    onTap: () {
                      context.push('/send_report');
                    },
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: _ActionButton(
                    text: 'Completed the job',
                    isRed: false,
                    showArrow: true,
                    onTap: () {
                      // TODO: Handle complete action
                    },
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _InfoBox extends StatelessWidget {
  final String label;
  final String value;
  final bool showAvatar;

  const _InfoBox({
    required this.label,
    required this.value,
    this.showAvatar = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9), // Light green background
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w400,
              fontFamily: 'sf_pro',
              color: AllColor.black.withOpacity(0.6),
            ),
          ),
          SizedBox(height: 4.h),
          if (showAvatar)
            Row(
              children: [
                Container(
                  width: 20.w,
                  height: 20.w,
                  decoration: BoxDecoration(
                    color: AllColor.grey300,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.person,
                    size: 12.sp,
                    color: AllColor.grey600,
                  ),
                ),
                SizedBox(width: 6.w),
                Expanded(
                  child: Text(
                    value,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'plus_Jakarta_Sans',
                      color: AllColor.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            )
          else
            Text(
              value,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                fontFamily: 'plus_Jakarta_Sans',
                color: AllColor.black,
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
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AllColor.grey100,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          fontFamily: 'plus_Jakarta_Sans',
          color: AllColor.black,
        ),
      ),
    );
  }
}

class _ReviewBox extends StatelessWidget {
  final String? reviewStatus;
  final double? rating;

  const _ReviewBox({
    this.reviewStatus,
    this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9), // Light green background
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Review',
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w400,
              fontFamily: 'sf_pro',
              color: AllColor.black.withOpacity(0.6),
            ),
          ),
          SizedBox(height: 4.h),
          if (reviewStatus != null)
            Text(
              reviewStatus!,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                fontFamily: 'plus_Jakarta_Sans',
                color: const Color(0xFF4CAF50), // Green color
              ),
            )
          else if (rating != null)
            _StarRating(rating: rating!),
        ],
      ),
    );
  }
}

class _StarRating extends StatelessWidget {
  final double rating;

  const _StarRating({required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (index < rating.floor()) {
          // Full star
          return Icon(
            Icons.star,
            size: 14.sp,
            color: const Color(0xFF4CAF50),
          );
        } else if (index < rating) {
          // Half star
          return Icon(
            Icons.star_half,
            size: 14.sp,
            color: const Color(0xFF4CAF50),
          );
        } else {
          // Empty star
          return Icon(
            Icons.star_border,
            size: 14.sp,
            color: AllColor.grey300,
          );
        }
      }),
    );
  }
}

class _ReviewButton extends StatelessWidget {
  final VoidCallback onTap;

  const _ReviewButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: const Color(0xFF4CAF50), // Green border
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.star,
              size: 18.sp,
              color: const Color(0xFF4CAF50),
            ),
            SizedBox(width: 8.w),
            Text(
              'Give a review',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                fontFamily: 'plus_Jakarta_Sans',
                color: const Color(0xFF4CAF50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String text;
  final bool isRed;
  final bool showArrow;
  final VoidCallback onTap;

  const _ActionButton({
    required this.text,
    required this.isRed,
    this.showArrow = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: isRed ? AllColor.red : AllColor.black,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'plus_Jakarta_Sans',
                  color: isRed ? AllColor.red : AllColor.black,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
            if (showArrow) ...[
              SizedBox(width: 6.w),
              Icon(
                Icons.arrow_forward,
                size: 16.sp,
                color: AllColor.black,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _JobOptionsBottomSheet extends StatelessWidget {
  final JobModel job;

  const _JobOptionsBottomSheet({required this.job});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 24.w,
        right: 24.w,
        top: 32.h,
        bottom: 40.h,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // View details button
          _BottomSheetButton(
            text: 'View details',
            onTap: () {
              Navigator.pop(context);
              // TODO: Navigate to job details screen
            },
          ),
          SizedBox(height: 16.h),
          // Cancel button
          _BottomSheetButton(
            text: 'Cancel',
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

class _BottomSheetButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const _BottomSheetButton({
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5), // Light grey/off-white background
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              fontFamily: 'plus_Jakarta_Sans',
              color: const Color(0xFF3071FF), // Blue color
            ),
          ),
        ),
      ),
    );
  }
}

class _GiveReviewBottomSheet extends StatefulWidget {
  final JobModel job;

  const _GiveReviewBottomSheet({required this.job});

  @override
  State<_GiveReviewBottomSheet> createState() => _GiveReviewBottomSheetState();
}

class _GiveReviewBottomSheetState extends State<_GiveReviewBottomSheet> {
  int _selectedRating = 4;
  final TextEditingController _experienceController = TextEditingController();
  final int _maxCharacters = 999;

  @override
  void dispose() {
    _experienceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final remainingChars = (_maxCharacters - _experienceController.text.length).clamp(0, _maxCharacters);

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.9,
      ),
      decoration: BoxDecoration(
        color: AllColor.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: 24.w,
          right: 24.w,
          top: 24.h,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24.h,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          // Title
          Center(
            child: Text(
              'Give a review',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                fontFamily: 'plus_Jakarta_Sans',
                color: AllColor.black,
              ),
            ),
          ),
          SizedBox(height: 24.h),

          // Star Rating
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(5, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedRating = index + 1;
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Icon(
                      index < _selectedRating
                          ? Icons.star
                          : Icons.star_border,
                      size: 32.sp,
                      color: index < _selectedRating
                          ? const Color(0xFF4CAF50)
                          : AllColor.grey300,
                    ),
                  ),
                );
              }),
            ),
          ),
          SizedBox(height: 8.h),

          // Rating text
          Center(
            child: Text(
              '$_selectedRating/5',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                fontFamily: 'plus_Jakarta_Sans',
                color: AllColor.black,
              ),
            ),
          ),
          SizedBox(height: 24.h),

          // Provider text
          Text(
            'How was your experience with Provider',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              fontFamily: 'plus_Jakarta_Sans',
              color: AllColor.black,
            ),
          ),
          SizedBox(height: 16.h),

          // Experience text input
          Container(
            constraints: BoxConstraints(
              maxHeight: 200.h,
            ),
            decoration: BoxDecoration(
              color: AllColor.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: AllColor.grey200,
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 150.h,
                  ),
                  child: TextField(
                    controller: _experienceController,
                    maxLines: null,
                    minLines: 6,
                    maxLength: _maxCharacters,
                    expands: false,
                    textInputAction: TextInputAction.newline,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'plus_Jakarta_Sans',
                      color: AllColor.black,
                      height: 1.5,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Write your experience',
                      hintStyle: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'plus_Jakarta_Sans',
                        color: AllColor.grey600,
                        height: 1.5,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(16.w),
                      counterText: '',
                    ),
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 16.w, bottom: 12.h),
                  child: Text(
                    '$remainingChars characters left',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'plus_Jakarta_Sans',
                      color: AllColor.grey600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),

          // Publish button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _experienceController.text.trim().isNotEmpty
                  ? () {
                      // TODO: Handle publish review
                      Navigator.pop(context);
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AllColor.black,
                disabledBackgroundColor: AllColor.grey300,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                elevation: 0,
              ),
              child: Text(
                'Publish',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'plus_Jakarta_Sans',
                  color: AllColor.white,
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}

