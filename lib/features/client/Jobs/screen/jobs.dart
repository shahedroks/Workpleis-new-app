import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'job_details_screen.dart';
import '../model/project_model.dart';
import '../model/flow_type.dart';
import '../data/projects_data.dart';

class ClientProjectsScreen extends StatefulWidget {
  const ClientProjectsScreen({
    super.key,
    this.flowType = FlowType.project,
  });

  static const String routeName = '/client_projects';

  final FlowType flowType;

  @override
  State<ClientProjectsScreen> createState() => _ClientProjectsScreenState();
}

class _ClientProjectsScreenState extends State<ClientProjectsScreen>
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

  ProjectStatus get _selectedTab {
    switch (_tabController.index) {
      case 0:
        return ProjectStatus.active;
      case 1:
        return ProjectStatus.pending;
      case 2:
        return ProjectStatus.completed;
      case 3:
        return ProjectStatus.cancelled;
      default:
        return ProjectStatus.active;
    }
  }

  List<ProjectModel> get _currentProjects {
    switch (_selectedTab) {
      case ProjectStatus.active:
        return activeProjects;
      case ProjectStatus.pending:
        return pendingProjects;
      case ProjectStatus.completed:
        return completedProjects;
      case ProjectStatus.cancelled:
        return cancelledProjects;
    }
  }

  int _getProjectCount(ProjectStatus status) {
    switch (status) {
      case ProjectStatus.active:
        return activeProjects.length;
      case ProjectStatus.pending:
        return pendingProjects.length;
      case ProjectStatus.completed:
        return completedProjects.length;
      case ProjectStatus.cancelled:
        return cancelledProjects.length;
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
                    widget.flowType.plural,
                    style: TextStyle(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'plus_Jakarta_Sans',
                      color: AllColor.black,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // TODO: Navigate to create ${widget.flowType.singular.toLowerCase()} screen
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
              getProjectCount: _getProjectCount,
              flowType: widget.flowType,
            ),

            // Project List
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                itemCount: _currentProjects.length,
                separatorBuilder: (context, index) => SizedBox(height: 16.h),
                itemBuilder: (context, index) {
                  return _ProjectCard(
                    project: _currentProjects[index],
                    flowType: widget.flowType,
                    onMenuTap: () => _showProjectOptionsBottomSheet(context, _currentProjects[index]),
                    onReviewTap: () => _showGiveReviewBottomSheet(context, _currentProjects[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showProjectOptionsBottomSheet(BuildContext context, ProjectModel project) async {
    final action = await showModalBottomSheet<_ProjectOptionsAction>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) => _ProjectOptionsBottomSheet(project: project),
    );

    if (!mounted) return;

    if (action == _ProjectOptionsAction.viewDetails) {
      context.push(ProjectDetailsScreen.routeName, extra: {
        'project': project,
        'flowType': widget.flowType,
      });
    }
  }

  void _showGiveReviewBottomSheet(BuildContext context, ProjectModel project) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return _GiveReviewBottomSheet(
          project: project,
          flowType: widget.flowType,
        );
      },
    );
  }
}

class _TabsSection extends StatelessWidget {
  final TabController tabController;
  final int Function(ProjectStatus) getProjectCount;
  final FlowType flowType;

  const _TabsSection({
    required this.tabController,
    required this.getProjectCount,
    required this.flowType,
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
            text: 'Active (${getProjectCount(ProjectStatus.active)})',
          ),
          Tab(
            text: 'Pending (${getProjectCount(ProjectStatus.pending)})',
          ),
          Tab(
            text: 'Completed',
          ),
          Tab(
            text: 'Cancelled (${getProjectCount(ProjectStatus.cancelled)})',
          ),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatelessWidget {
  final ProjectModel project;
  final FlowType flowType;
  final VoidCallback onMenuTap;
  final VoidCallback? onReviewTap;

  const _ProjectCard({
    required this.project,
    required this.flowType,
    required this.onMenuTap,
    this.onReviewTap,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = project.status == ProjectStatus.active;
    final isCompleted = project.status == ProjectStatus.completed;
    final isCancelled = project.status == ProjectStatus.cancelled;
    
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
                  project.title,
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
                  child: _InfoBox(label: 'Quote', value: project.quote ?? ''),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: _InfoBox(label: 'Price', value: project.price ?? ''),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: _InfoBox(label: 'Bid', value: project.bid ?? ''),
                ),
              ],
            )
          else if (isCompleted)
            // Completed: Estimate, Cost, Review
            Row(
              children: [
                Expanded(
                  child: _InfoBox(label: 'Estimate', value: project.estimate ?? ''),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: _InfoBox(label: 'Cost', value: project.cost ?? ''),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: _ReviewBox(
                    reviewStatus: project.reviewStatus,
                    rating: project.rating,
                  ),
                ),
              ],
            )
          else if (isCancelled)
            // Cancelled: Estimate, Cost only
            Row(
              children: [
                Expanded(
                  child: _InfoBox(label: 'Estimate', value: project.estimate ?? ''),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: _InfoBox(label: 'Cost', value: project.cost ?? ''),
                ),
              ],
            )
          else
            // Pending: Estimate, Cost, Provider
            Row(
              children: [
                Expanded(
                  child: _InfoBox(label: 'Estimate', value: project.estimate ?? ''),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: _InfoBox(label: 'Cost', value: project.cost ?? ''),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: _InfoBox(
                    label: 'Provider',
                    value: project.provider ?? '',
                    showAvatar: true,
                  ),
                ),
              ],
            ),
          SizedBox(height: 16.h),

          // Project Description - Only for Pending/Others, not Active
          if (!isActive && project.description != null) ...[
            Text(
              project.description!,
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
            children: project.services.map((service) {
              return _ServiceTag(label: service);
            }).toList(),
          ),

          // Action Buttons - Different for each status
          if (isCompleted) ...[
            SizedBox(height: 16.h),
            _ReviewButton(
              onTap: onReviewTap ?? () {},
            ),
          ] else if (!isActive && !isCancelled) ...[
            // Pending only: Report and Completed buttons
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
                    text: 'Completed the ${flowType.singular.toLowerCase()}',
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
          // Cancelled projects have no action buttons
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

enum _ProjectOptionsAction { viewDetails }

class _ProjectOptionsBottomSheet extends StatelessWidget {
  final ProjectModel project;

  const _ProjectOptionsBottomSheet({required this.project});

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
              Navigator.pop(context, _ProjectOptionsAction.viewDetails);
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
  final ProjectModel project;
  final FlowType flowType;

  const _GiveReviewBottomSheet({
    required this.project,
    required this.flowType,
  });

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

  void _showCompletionConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Container(
            padding: EdgeInsets.all(24.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Title
                Text(
                  'Are you sure your work is complete?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'plus_Jakarta_Sans',
                    color: AllColor.black,
                  ),
                ),
                SizedBox(height: 12.h),
                
                // Message
                Text(
                  'Are you confident everything is correct? If so, please leave a review for the provider.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'plus_Jakarta_Sans',
                    color: AllColor.grey600,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 24.h),
                
                // Separator
                Divider(
                  color: AllColor.grey200,
                  height: 1,
                ),
                SizedBox(height: 16.h),
                
                // Buttons
                // Yes button (Blue)
                SizedBox(
                  width: double.infinity,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(dialogContext); // Close dialog
                        Navigator.pop(context); // Close bottom sheet
                        // Navigate to success screen
                        final flowType = widget.flowType;
                        context.push('/${flowType.singular.toLowerCase()}_completed_success');
                      },
                      borderRadius: BorderRadius.circular(12.r),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        child: Center(
                          child: Text(
                            'Yes',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'plus_Jakarta_Sans',
                              color: const Color(0xFF007AFF), // Blue
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                
                // No button (Red)
                SizedBox(
                  width: double.infinity,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(dialogContext); // Close dialog and go back
                      },
                      borderRadius: BorderRadius.circular(12.r),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        child: Center(
                          child: Text(
                            'No',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'plus_Jakarta_Sans',
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
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
            child: ConstrainedBox(
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
          ),
          SizedBox(height: 8.h),
          // Character count below the box, aligned left
          Align(
            alignment: Alignment.centerRight,
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
          SizedBox(height: 24.h),

          // Publish button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _experienceController.text.trim().isNotEmpty
                  ? () {
                      // Show confirmation dialog
                      _showCompletionConfirmationDialog(context);
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

