import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/features/client/Jobs/model/project_model.dart';
import 'package:workpleis/features/client/Jobs/data/projects_data.dart';

class ProjectScreen extends StatelessWidget {
  const ProjectScreen({super.key});

  static const String routeName = '/project';

  @override
  Widget build(BuildContext context) {
    // Combine all projects for display
    final allProjects = [
      ...activeProjects,
      ...pendingProjects,
      ...completedProjects,
      ...cancelledProjects,
    ];

    return Scaffold(
      backgroundColor: AllColor.white,
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
                    'Project',
                    style: TextStyle(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'plus_Jakarta_Sans',
                      color: AllColor.black,
                    ),
                  ),
                ],
              ),
            ),
            // Project List
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                itemCount: allProjects.length,
                separatorBuilder: (context, index) => SizedBox(height: 16.h),
                itemBuilder: (context, index) {
                  return _ProjectCard(project: allProjects[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final ProjectModel project;

  const _ProjectCard({required this.project});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _isDescriptionExpanded = false;

  @override
  Widget build(BuildContext context) {
    final currentProject = widget.project;
    final estimate = currentProject.quote ?? currentProject.estimate ?? '—';
    final cost = currentProject.price ?? currentProject.cost ?? '—';
    final description = currentProject.description ?? '';
    final fullDescription = description;
    final shortDescription = description.length > 200
        ? '${description.substring(0, 200)}...'
        : description;
    final showMoreLink = description.length > 200;
    // Calculate proposal count (using bid if available, otherwise default to 0)
    final proposalCount = currentProject.bid != null && currentProject.bid!.isNotEmpty
        ? (currentProject.bid!.replaceAll(RegExp(r'[^0-9]'), '').isEmpty
            ? '0'
            : currentProject.bid!.replaceAll(RegExp(r'[^0-9]'), ''))
        : '0';

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
                child: _InfoBox(label: 'Proposal', value: proposalCount),
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
