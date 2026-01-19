import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';

import '../model/project_model.dart';
import '../model/proposal_model.dart';
import '../model/flow_type.dart';
import '../data/proposals_data.dart';
import 'proposal_details_screen.dart';
import 'account_add_screen.dart';

class ProjectDetailsScreen extends StatefulWidget {
  const ProjectDetailsScreen({
    super.key,
    this.project,
    this.proposalCount = 34,
    this.flowType = FlowType.project,
  });

  static const String routeName = '/project_details';

  final ProjectModel? project;
  final int proposalCount;
  final FlowType flowType;

  @override
  State<ProjectDetailsScreen> createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AllColor.white,
      body: SafeArea(
        child: Column(
          children: [
            _Header(
              title: '${widget.flowType.singular} Details',
              onBack: () => Navigator.maybePop(context),
            ),
            _ProjectDetailsTabBar(
              controller: _tabController,
              proposalCount: widget.proposalCount,
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _DetailsTab(
                    project: widget.project,
                    proposalCount: widget.proposalCount,
                    flowType: widget.flowType,
                  ),
                  _ProposalsTab(
                    proposalCount: widget.proposalCount,
                    flowType: widget.flowType,
                  ),
                  _CancelTab(flowType: widget.flowType),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final String title;
  final VoidCallback onBack;

  const _Header({
    required this.title,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(24.w, 18.h, 24.w, 12.h),
      child: SizedBox(
        height: 40.h,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onBack,
                  borderRadius: BorderRadius.circular(8.r),
                  child: Ink(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFE0E0E0)),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(
                      Icons.arrow_back,
                      size: 20.sp,
                      color: const Color(0xFF111111),
                    ),
                  ),
                ),
              ),
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'sf_pro',
                fontWeight: FontWeight.w600,
                fontSize: 18.sp,
                color: AllColor.black,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.more_vert,
                size: 20.sp,
                color: const Color(0xFF111111),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProjectDetailsTabBar extends StatelessWidget {
  final TabController controller;
  final int proposalCount;

  const _ProjectDetailsTabBar({
    required this.controller,
    required this.proposalCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: AllColor.grey200, width: 1)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: TabBar(
        controller: controller,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: AllColor.black, width: 2.h),
        ),
        indicatorSize: TabBarIndicatorSize.label,
        labelColor: AllColor.black,
        unselectedLabelColor: const Color(0xFF9B9B9B),
        labelStyle: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          fontFamily: 'sf_pro',
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          fontFamily: 'sf_pro',
        ),
        tabs: [
          const Tab(text: 'Details'),
          Tab(text: 'Proposal ($proposalCount)'),
          const Tab(text: 'Cancel'),
        ],
      ),
    );
  }
}

class _DetailsTab extends StatefulWidget {
  final ProjectModel? project;
  final int proposalCount;
  final FlowType flowType;

  const _DetailsTab({
    required this.project,
    required this.proposalCount,
    required this.flowType,
  });

  @override
  State<_DetailsTab> createState() => _DetailsTabState();
}

class _DetailsTabState extends State<_DetailsTab> {
  bool _isDescriptionExpanded = false;

  @override
  Widget build(BuildContext context) {
    final currentProject = widget.project;
    if (currentProject == null) {
      return Center(
        child: Text(
          'No ${widget.flowType.singular.toLowerCase()} details found.',
          style: TextStyle(
            fontFamily: 'sf_pro',
            fontWeight: FontWeight.w500,
            fontSize: 16.sp,
            color: AllColor.grey600,
          ),
        ),
      );
    }

    final estimate = currentProject.quote ?? currentProject.estimate ?? '—';
    final cost = currentProject.price ?? currentProject.cost ?? '—';
    final description = currentProject.description ?? '';
    final fullDescription = description;
    final shortDescription = description.length > 200
        ? '${description.substring(0, 200)}...'
        : description;
    final showMoreLink = description.length > 200;

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 24.h),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AllColor.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AllColor.grey200, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    currentProject.title,
                    style: TextStyle(
                      fontFamily: 'sf_pro',
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp,
                      color: AllColor.black,
                      height: 1.2,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Icon(
                  Icons.more_vert,
                  size: 18.sp,
                  color: const Color(0xFF9B9B9B),
                ),
              ],
            ),
            SizedBox(height: 14.h),
            Row(
              children: [
                Expanded(child: _InfoBox(label: 'Estimate', value: estimate)),
                SizedBox(width: 10.w),
                Expanded(child: _InfoBox(label: 'Cost', value: cost)),
                SizedBox(width: 10.w),
                Expanded(
                  child: _InfoBox(label: 'Proposal', value: '${widget.proposalCount}'),
                ),
              ],
            ),
            SizedBox(height: 14.h),
            _ExpandableDescription(
              text: fullDescription,
              shortText: shortDescription,
              isExpanded: _isDescriptionExpanded,
              showMoreLink: showMoreLink,
              onToggle: () {
                setState(() {
                  _isDescriptionExpanded = !_isDescriptionExpanded;
                });
              },
            ),
            if (currentProject.responsibilities != null &&
                currentProject.responsibilities!.isNotEmpty) ...[
              SizedBox(height: 22.h),
              _SectionHeading(text: 'Responsibilities:'),
              SizedBox(height: 10.h),
              _BulletList(items: currentProject.responsibilities!),
            ],
            if (currentProject.requirements != null &&
                currentProject.requirements!.isNotEmpty) ...[
              SizedBox(height: 22.h),
              _SectionHeading(text: 'Requirements:'),
              SizedBox(height: 10.h),
              _BulletList(items: currentProject.requirements!),
            ],
            if (currentProject.location != null && currentProject.location!.isNotEmpty) ...[
              SizedBox(height: 22.h),
              _SectionHeading(text: 'Location:'),
              SizedBox(height: 6.h),
              Text(
                currentProject.location!,
                style: TextStyle(
                  fontFamily: 'sf_pro',
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                  color: AllColor.black,
                  height: 1.4,
                ),
              ),
            ],
            if (currentProject.application != null &&
                currentProject.application!.isNotEmpty) ...[
              SizedBox(height: 22.h),
              _SectionHeading(text: 'Application:'),
              SizedBox(height: 6.h),
              Text(
                currentProject.application!,
                style: TextStyle(
                  fontFamily: 'sf_pro',
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                  color: AllColor.black,
                  height: 1.4,
                ),
              ),
            ],
            SizedBox(height: 22.h),
            Text(
              'SERVICES',
              style: TextStyle(
                fontFamily: 'sf_pro',
                fontWeight: FontWeight.w500,
                fontSize: 12.sp,
                color: const Color(0xFF9B9B9B),
                letterSpacing: 0.6,
              ),
            ),
            SizedBox(height: 10.h),
            Wrap(
              spacing: 10.w,
              runSpacing: 10.h,
              children: currentProject.services
                  .map((service) => _ServiceChip(text: service))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _ExpandableDescription extends StatelessWidget {
  final String text;
  final String shortText;
  final bool isExpanded;
  final bool showMoreLink;
  final VoidCallback onToggle;

  const _ExpandableDescription({
    required this.text,
    required this.shortText,
    required this.isExpanded,
    required this.showMoreLink,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isExpanded ? text : shortText,
          style: TextStyle(
            fontFamily: 'sf_pro',
            fontWeight: FontWeight.w400,
            fontSize: 14.sp,
            color: const Color(0xFF111111),
            height: 1.45,
          ),
        ),
        if (showMoreLink)
          GestureDetector(
            onTap: onToggle,
            child: Text(
              isExpanded ? 'less' : 'more',
              style: TextStyle(
                fontFamily: 'sf_pro',
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
                color: const Color(0xFF9B9B9B),
                decoration: TextDecoration.underline,
                decorationColor: const Color(0xFF9B9B9B),
              ),
            ),
          ),
      ],
    );
  }
}

class _SectionHeading extends StatelessWidget {
  final String text;

  const _SectionHeading({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'sf_pro',
        fontWeight: FontWeight.w700,
        fontSize: 14.sp,
        color: AllColor.black,
      ),
    );
  }
}

class _BulletList extends StatelessWidget {
  final List<String> items;

  const _BulletList({required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((item) {
        return Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 6.h, right: 8.w),
                child: Container(
                  width: 4.w,
                  height: 4.w,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AllColor.black,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  item,
                  style: TextStyle(
                    fontFamily: 'sf_pro',
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                    color: AllColor.black,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
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
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F7EB),
        border: Border.all(color: const Color(0xFFDCE8C8), width: 1),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontFamily: 'sf_pro',
              fontWeight: FontWeight.w400,
              fontSize: 12.sp,
              color: const Color(0xFF9B9B9B),
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: 'sf_pro',
              fontWeight: FontWeight.w700,
              fontSize: 14.sp,
              color: AllColor.black,
            ),
          ),
        ],
      ),
    );
  }
}

class _ServiceChip extends StatelessWidget {
  final String text;

  const _ServiceChip({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AllColor.white,
        borderRadius: BorderRadius.circular(999.r),
        border: Border.all(color: AllColor.grey200, width: 1),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'sf_pro',
          fontWeight: FontWeight.w500,
          fontSize: 12.sp,
          color: AllColor.black,
        ),
      ),
    );
  }
}

class _ProposalsTab extends StatelessWidget {
  final int proposalCount;
  final FlowType flowType;

  const _ProposalsTab({
    required this.proposalCount,
    required this.flowType,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 24.h),
      child: Column(
        children: [
          ...sampleProposals.map((proposal) => Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: _ProposalCard(
                  proposal: proposal,
                  flowType: flowType,
                ),
              )),
        ],
      ),
    );
  }
}

class _ProposalCard extends StatefulWidget {
  final ProposalModel proposal;
  final FlowType flowType;

  const _ProposalCard({
    required this.proposal,
    required this.flowType,
  });

  @override
  State<_ProposalCard> createState() => _ProposalCardState();
}

class _ProposalCardState extends State<_ProposalCard> {
  bool _isDescriptionExpanded = false;

  @override
  Widget build(BuildContext context) {
    final proposal = widget.proposal;
    final description = proposal.description;
    final shortDescription = description.length > 150
        ? '${description.substring(0, 150)}...'
        : description;
    final showMoreLink = description.length > 150;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          context.push(ProposalDetailsScreen.routeName, extra: proposal);
        },
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: AllColor.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AllColor.grey200, width: 1),
          ),
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Provider Info Row
          Row(
            children: [
              // Profile Picture
              Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AllColor.grey200,
                ),
                child: proposal.providerImageUrl != null
                    ? ClipOval(
                        child: Image.asset(
                          proposal.providerImageUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Icon(
                                Icons.person,
                                size: 24.sp,
                                color: AllColor.grey600,
                              ),
                        ),
                      )
                    : Icon(
                        Icons.person,
                        size: 24.sp,
                        color: AllColor.grey600,
                      ),
              ),
              SizedBox(width: 12.w),
              // Name and Rating
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      proposal.providerName,
                      style: TextStyle(
                        fontFamily: 'sf_pro',
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                        color: AllColor.black,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 14.sp,
                          color: AllColor.black,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          '${proposal.rating}',
                          style: TextStyle(
                            fontFamily: 'sf_pro',
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                            color: AllColor.black,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          '${proposal.reviewCount} reviews',
                          style: TextStyle(
                            fontFamily: 'sf_pro',
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                            color: const Color(0xFF9B9B9B),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Time Ago
              Text(
                proposal.timeAgo,
                style: TextStyle(
                  fontFamily: 'sf_pro',
                  fontWeight: FontWeight.w400,
                  fontSize: 12.sp,
                  color: const Color(0xFF9B9B9B),
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          // Description
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _isDescriptionExpanded ? description : shortDescription,
                style: TextStyle(
                  fontFamily: 'sf_pro',
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                  color: const Color(0xFF111111),
                  height: 1.45,
                ),
              ),
              if (showMoreLink)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isDescriptionExpanded = !_isDescriptionExpanded;
                    });
                  },
                  child: Text(
                    _isDescriptionExpanded ? 'less' : 'More',
                    style: TextStyle(
                      fontFamily: 'sf_pro',
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                      color: const Color(0xFF9B9B9B),
                      decoration: TextDecoration.underline,
                      decorationColor: const Color(0xFF9B9B9B),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 16.h),
          // Cost and Performance Row
          Row(
            children: [
              // Offering Cost Box
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3EBF9),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 24.w,
                            height: 24.w,
                            decoration: BoxDecoration(
                              color: AllColor.white,
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: Icon(
                              Icons.attach_money_rounded,
                              size: 16.sp,
                              color: const Color(0xFFECB3E0),
                            ),
                          ),
                          SizedBox(height: 50.h),
                          Text(
                            'Offering Cost',
                            style: TextStyle(
                              fontFamily: 'sf_pro',
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                              color: const Color(0xB3000000),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        proposal.offeringCost,
                        style: TextStyle(
                          fontFamily: 'sf_pro',
                          fontWeight: FontWeight.w800,
                          fontSize: 16.sp,
                          color: AllColor.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              // Performance & Project Details
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Work Performance
                    Text(
                      'Work performance',
                      style: TextStyle(
                        fontFamily: 'sf_pro',
                        fontWeight: FontWeight.w400,
                        fontSize: 12.sp,
                        color: const Color(0xB3000000),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Text(
                          '${proposal.workPerformance}%',
                          style: TextStyle(
                            fontFamily: 'sf_pro',
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                            color: AllColor.black,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(2.r),
                            child: LinearProgressIndicator(
                              value: proposal.workPerformance / 100,
                              backgroundColor: AllColor.grey200,
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                Color(0xFF82B600),
                              ),
                              minHeight: 4.h,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    // Total Completed Projects
                    Text(
                      'Total completed ${widget.flowType.singular}',
                      style: TextStyle(
                        fontFamily: 'sf_pro',
                        fontWeight: FontWeight.w400,
                        fontSize: 12.sp,
                        color: const Color(0xB3000000),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '${proposal.totalCompletedJobs}',
                      style: TextStyle(
                        fontFamily: 'sf_pro',
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                        color: AllColor.black,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    // Project Estimate Timeline
                    Text(
                      '${widget.flowType.singular} estimate timeline',
                      style: TextStyle(
                        fontFamily: 'sf_pro',
                        fontWeight: FontWeight.w400,
                        fontSize: 12.sp,
                        color: const Color(0xB3000000),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      proposal.projectEstimateTimeline,
                      style: TextStyle(
                        fontFamily: 'sf_pro',
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                        color: AllColor.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (proposal.attachments.isNotEmpty) ...[
            SizedBox(height: 20.h),
            Text(
              'ATTACHED FILES',
              style: TextStyle(
                fontFamily: 'sf_pro',
                fontWeight: FontWeight.w500,
                fontSize: 12.sp,
                color: const Color(0xFF9B9B9B),
                letterSpacing: 0.6,
              ),
            ),
            SizedBox(height: 10.h),
            ...proposal.attachments.map((attachment) => Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: Row(
                    children: [
                      Container(
                        width: 48.w,
                        height: 48.w,
                        decoration: BoxDecoration(
                          color: AllColor.grey200,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: attachment.thumbnailUrl != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(8.r),
                                child: Image.asset(
                                  attachment.thumbnailUrl!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Icon(
                                        attachment.fileType == 'image'
                                            ? Icons.image
                                            : Icons.description,
                                        size: 24.sp,
                                        color: AllColor.grey600,
                                      ),
                                ),
                              )
                            : Icon(
                                attachment.fileType == 'image'
                                    ? Icons.image
                                    : Icons.description,
                                size: 24.sp,
                                color: AllColor.grey600,
                              ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              attachment.name,
                              style: TextStyle(
                                fontFamily: 'sf_pro',
                                fontWeight: FontWeight.w400,
                                fontSize: 14.sp,
                                color: AllColor.black,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              attachment.size,
                              style: TextStyle(
                                fontFamily: 'sf_pro',
                                fontWeight: FontWeight.w400,
                                fontSize: 12.sp,
                                color: const Color(0xFF9B9B9B),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
          ],
          SizedBox(height: 20.h),
          // Action Buttons
          Row(
            children: [
              Expanded(
                flex: 2,
                child: _ActionButton(
                  text: 'Cancel',
                  isRed: true,
                  onTap: () {},
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                flex: 5,
                child: _ActionButton(
                  text: 'Accept & Continue',
                  isRed: false,
                  showArrow: true,
                  onTap: () {},
                ),
              ),
            ],
          ),
        ],
      ),
      ),
    )
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
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(999.r),
          border: Border.all(
            color: isRed ? const Color(0xFFEF0000) : AllColor.black,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                text,
                style: TextStyle(
                  fontFamily: 'sf_pro',
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                  color: isRed ? const Color(0xFFEF0000) : AllColor.black,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
            if (showArrow) ...[
              SizedBox(width: 6.w),
              Icon(
                Icons.arrow_right_alt_rounded,
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

class _CancelTab extends StatelessWidget {
  final FlowType flowType;

  const _CancelTab({required this.flowType});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 24.h),
      child: Column(
        children: [
          ...sampleProposals.map((proposal) => Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: _CancelProposalCard(
                  proposal: proposal,
                  flowType: flowType,
                ),
              )),
        ],
      ),
    );
  }
}

class _CancelProposalCard extends StatefulWidget {
  final ProposalModel proposal;
  final FlowType flowType;

  const _CancelProposalCard({
    required this.proposal,
    required this.flowType,
  });

  @override
  State<_CancelProposalCard> createState() => _CancelProposalCardState();
}

class _CancelProposalCardState extends State<_CancelProposalCard> {
  bool _isDescriptionExpanded = false;

  @override
  Widget build(BuildContext context) {
    final proposal = widget.proposal;
    final description = proposal.description;
    final shortDescription = description.length > 150
        ? '${description.substring(0, 150)}...'
        : description;
    final showMoreLink = description.length > 150;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AllColor.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AllColor.grey200, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Provider Info Row
          Row(
            children: [
              // Profile Picture
              Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AllColor.grey200,
                ),
                child: proposal.providerImageUrl != null
                    ? ClipOval(
                        child: Image.asset(
                          proposal.providerImageUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Icon(
                                Icons.person,
                                size: 24.sp,
                                color: AllColor.grey600,
                              ),
                        ),
                      )
                    : Icon(
                        Icons.person,
                        size: 24.sp,
                        color: AllColor.grey600,
                      ),
              ),
              SizedBox(width: 12.w),
              // Name and Rating
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      proposal.providerName,
                      style: TextStyle(
                        fontFamily: 'sf_pro',
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                        color: AllColor.black,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 14.sp,
                          color: AllColor.black,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          '${proposal.rating}',
                          style: TextStyle(
                            fontFamily: 'sf_pro',
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                            color: AllColor.black,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          '${proposal.reviewCount} reviews',
                          style: TextStyle(
                            fontFamily: 'sf_pro',
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                            color: const Color(0xFF9B9B9B),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Time Ago
              Text(
                proposal.timeAgo,
                style: TextStyle(
                  fontFamily: 'sf_pro',
                  fontWeight: FontWeight.w400,
                  fontSize: 12.sp,
                  color: const Color(0xFF9B9B9B),
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          // Description
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _isDescriptionExpanded ? description : shortDescription,
                style: TextStyle(
                  fontFamily: 'sf_pro',
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                  color: const Color(0xFF111111),
                  height: 1.45,
                ),
              ),
              if (showMoreLink)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isDescriptionExpanded = !_isDescriptionExpanded;
                    });
                  },
                  child: Text(
                    _isDescriptionExpanded ? 'less' : 'More',
                    style: TextStyle(
                      fontFamily: 'sf_pro',
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                      color: const Color(0xFF9B9B9B),
                      decoration: TextDecoration.underline,
                      decorationColor: const Color(0xFF9B9B9B),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 16.h),
          // Cost and Performance Row
          Row(
            children: [
              // Offering Cost Box
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3EBF9),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 24.w,
                            height: 24.w,
                            decoration: BoxDecoration(
                              color: AllColor.white,
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: Icon(
                              Icons.attach_money_rounded,
                              size: 16.sp,
                              color: const Color(0xFFECB3E0),
                            ),
                          ),
                          SizedBox(height: 50.h),
                          Text(
                            'Offering Cost',
                            style: TextStyle(
                              fontFamily: 'sf_pro',
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                              color: const Color(0xB3000000),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        proposal.offeringCost,
                        style: TextStyle(
                          fontFamily: 'sf_pro',
                          fontWeight: FontWeight.w800,
                          fontSize: 16.sp,
                          color: AllColor.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              // Performance & Project Details
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Work Performance
                    Text(
                      'Work performance',
                      style: TextStyle(
                        fontFamily: 'sf_pro',
                        fontWeight: FontWeight.w400,
                        fontSize: 12.sp,
                        color: const Color(0xB3000000),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Text(
                          '${proposal.workPerformance}%',
                          style: TextStyle(
                            fontFamily: 'sf_pro',
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                            color: AllColor.black,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(2.r),
                            child: LinearProgressIndicator(
                              value: proposal.workPerformance / 100,
                              backgroundColor: AllColor.grey200,
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                Color(0xFF82B600),
                              ),
                              minHeight: 4.h,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    // Total Completed Projects
                    Text(
                      'Total completed ${widget.flowType.singular}',
                      style: TextStyle(
                        fontFamily: 'sf_pro',
                        fontWeight: FontWeight.w400,
                        fontSize: 12.sp,
                        color: const Color(0xB3000000),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '${proposal.totalCompletedJobs}',
                      style: TextStyle(
                        fontFamily: 'sf_pro',
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                        color: AllColor.black,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    // Project Estimate Timeline
                    Text(
                      '${widget.flowType.singular} estimate timeline',
                      style: TextStyle(
                        fontFamily: 'sf_pro',
                        fontWeight: FontWeight.w400,
                        fontSize: 12.sp,
                        color: const Color(0xB3000000),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      proposal.projectEstimateTimeline,
                      style: TextStyle(
                        fontFamily: 'sf_pro',
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                        color: AllColor.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (proposal.attachments.isNotEmpty) ...[
            SizedBox(height: 20.h),
            Text(
              'ATTACHED FILES',
              style: TextStyle(
                fontFamily: 'sf_pro',
                fontWeight: FontWeight.w500,
                fontSize: 12.sp,
                color: const Color(0xFF9B9B9B),
                letterSpacing: 0.6,
              ),
            ),
            SizedBox(height: 10.h),
            ...proposal.attachments.map((attachment) => Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: Row(
                    children: [
                      Container(
                        width: 48.w,
                        height: 48.w,
                        decoration: BoxDecoration(
                          color: AllColor.grey200,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: attachment.thumbnailUrl != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(8.r),
                                child: Image.asset(
                                  attachment.thumbnailUrl!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Icon(
                                        attachment.fileType == 'image'
                                            ? Icons.image
                                            : Icons.description,
                                        size: 24.sp,
                                        color: AllColor.grey600,
                                      ),
                                ),
                              )
                            : Icon(
                                attachment.fileType == 'image'
                                    ? Icons.image
                                    : Icons.description,
                                size: 24.sp,
                                color: AllColor.grey600,
                              ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              attachment.name,
                              style: TextStyle(
                                fontFamily: 'sf_pro',
                                fontWeight: FontWeight.w400,
                                fontSize: 14.sp,
                                color: AllColor.black,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              attachment.size,
                              style: TextStyle(
                                fontFamily: 'sf_pro',
                                fontWeight: FontWeight.w400,
                                fontSize: 12.sp,
                                color: const Color(0xFF9B9B9B),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
          ],
          SizedBox(height: 20.h),
          // Withdraw Cancel Button
          SizedBox(
            width: double.infinity,
            child: _WithdrawCancelButton(
              onTap: () {
                context.push(AccountAddScreen.routeName);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _WithdrawCancelButton extends StatelessWidget {
  final VoidCallback onTap;

  const _WithdrawCancelButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: AllColor.white,
          borderRadius: BorderRadius.circular(999.r),
          border: Border.all(
            color: const Color(0xFFEF0000),
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            'Withdraw cancel',
            style: TextStyle(
              fontFamily: 'sf_pro',
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
              color: const Color(0xFFEF0000),
            ),
          ),
        ),
      ),
    );
  }
}

