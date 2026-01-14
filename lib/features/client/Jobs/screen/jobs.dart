import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/core/constants/color_control/home_color.dart';
import '../model/job_model.dart';
import '../data/jobs_data.dart';

class ClientJobsScreen extends StatefulWidget {
  const ClientJobsScreen({super.key});

  static const String routeName = '/client_jobs';

  @override
  State<ClientJobsScreen> createState() => _ClientJobsScreenState();
}

class _ClientJobsScreenState extends State<ClientJobsScreen> {
  JobStatus _selectedTab = JobStatus.active;

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
      backgroundColor: HomeColor.backgroundWhite,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Jobs',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'sf_pro',
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
              selectedTab: _selectedTab,
              onTabSelected: (tab) {
                setState(() {
                  _selectedTab = tab;
                });
              },
              getJobCount: _getJobCount,
            ),

            // Job List
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                itemCount: _currentJobs.length,
                separatorBuilder: (context, index) => SizedBox(height: 16.h),
                itemBuilder: (context, index) {
                  return _JobCard(job: _currentJobs[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TabsSection extends StatelessWidget {
  final JobStatus selectedTab;
  final Function(JobStatus) onTabSelected;
  final int Function(JobStatus) getJobCount;

  const _TabsSection({
    required this.selectedTab,
    required this.onTabSelected,
    required this.getJobCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _TabItem(
              label: 'Active',
              count: getJobCount(JobStatus.active),
              isSelected: selectedTab == JobStatus.active,
              onTap: () => onTabSelected(JobStatus.active),
            ),
            SizedBox(width: 24.w),
            _TabItem(
              label: 'Pending',
              count: getJobCount(JobStatus.pending),
              isSelected: selectedTab == JobStatus.pending,
              onTap: () => onTabSelected(JobStatus.pending),
            ),
            SizedBox(width: 24.w),
            _TabItem(
              label: 'Completed',
              count: getJobCount(JobStatus.completed),
              isSelected: selectedTab == JobStatus.completed,
              onTap: () => onTabSelected(JobStatus.completed),
            ),
            SizedBox(width: 24.w),
            _TabItem(
              label: 'Cancelled',
              count: getJobCount(JobStatus.cancelled),
              isSelected: selectedTab == JobStatus.cancelled,
              onTap: () => onTabSelected(JobStatus.cancelled),
            ),
          ],
        ),
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  final String label;
  final int count;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabItem({
    required this.label,
    required this.count,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            count > 0 ? '$label ($count)' : label,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              fontFamily: 'sf_pro',
              color: AllColor.black,
            ),
          ),
          SizedBox(height: 8.h),
          Container(
            width: count > 0 ? null : 60.w,
            height: 2.h,
            decoration: BoxDecoration(
              color: isSelected ? AllColor.black : Colors.transparent,
              borderRadius: BorderRadius.circular(1.r),
            ),
          ),
        ],
      ),
    );
  }
}

class _JobCard extends StatelessWidget {
  final JobModel job;

  const _JobCard({required this.job});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: HomeColor.backgroundWhite,
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
                    fontWeight: FontWeight.w500,
                    fontFamily: 'sf_pro',
                    color: AllColor.black,
                    height: 1.3,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              GestureDetector(
                onTap: () {
                  // TODO: Show job options menu
                },
                child: Icon(
                  Icons.more_vert,
                  size: 20.sp,
                  color: AllColor.black,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // Quote, Price, Bid boxes
          Row(
            children: [
              _InfoBox(label: 'Quote', value: job.quote),
              SizedBox(width: 8.w),
              _InfoBox(label: 'Price', value: job.price),
              SizedBox(width: 8.w),
              _InfoBox(label: 'Bid', value: job.bid),
            ],
          ),
          SizedBox(height: 16.h),

          // Services label
          Text(
            'SERVICES',
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              fontFamily: 'sf_pro',
              color: AllColor.black,
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
        ],
      ),
    );
  }
}

class _InfoBox extends StatelessWidget {
  final String label;
  final String value;

  const _InfoBox({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
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
          SizedBox(height: 2.h),
          Text(
            value,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              fontFamily: 'sf_pro',
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
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AllColor.grey100,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          fontFamily: 'sf_Pro',
          color: AllColor.black,
        ),
      ),
    );
  }
}

