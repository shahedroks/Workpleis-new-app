import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';

import '../model/proposal_model.dart';

class ProposalDetailsScreen extends StatelessWidget {
  const ProposalDetailsScreen({
    super.key,
    this.proposal,
  });

  static const String routeName = '/proposal_details';

  final ProposalModel? proposal;

  @override
  Widget build(BuildContext context) {
    final currentProposal = proposal;
    if (currentProposal == null) {
      return Scaffold(
        backgroundColor: AllColor.white,
        body: SafeArea(
          child: Center(
            child: Text(
              'No proposal details found.',
              style: TextStyle(
                fontFamily: 'sf_pro',
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
                color: AllColor.grey600,
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AllColor.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(24.w, 18.h, 24.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Header(
                title: 'Proposal Details',
                onBack: () => Navigator.maybePop(context),
              ),
              SizedBox(height: 20.h),
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
                    child: currentProposal.providerImageUrl != null
                        ? ClipOval(
                            child: Image.asset(
                              currentProposal.providerImageUrl!,
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
                          currentProposal.providerName,
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
                              '${currentProposal.rating}',
                              style: TextStyle(
                                fontFamily: 'sf_pro',
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp,
                                color: AllColor.black,
                              ),
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              '| ${currentProposal.reviewCount} reviews',
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
                    currentProposal.timeAgo,
                    style: TextStyle(
                      fontFamily: 'sf_pro',
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                      color: const Color(0xFF9B9B9B),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              // Full Description
              Text(
                currentProposal.description,
                style: TextStyle(
                  fontFamily: 'sf_pro',
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                  color: const Color(0xFF111111),
                  height: 1.45,
                ),
              ),
              SizedBox(height: 20.h),
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
                            currentProposal.offeringCost,
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
                              '${currentProposal.workPerformance}%',
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
                                  value: currentProposal.workPerformance / 100,
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
                          'Total completed Project',
                          style: TextStyle(
                            fontFamily: 'sf_pro',
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp,
                            color: const Color(0xB3000000),
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          '${currentProposal.totalCompletedJobs}',
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
                          'Project estimate timeline',
                          style: TextStyle(
                            fontFamily: 'sf_pro',
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp,
                            color: const Color(0xB3000000),
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          currentProposal.projectEstimateTimeline,
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
              if (currentProposal.attachments.isNotEmpty) ...[
                SizedBox(height: 30.h),
                Text(
                  'Attached files',
                  style: TextStyle(
                    fontFamily: 'sf_pro',
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                    color: AllColor.black,
                  ),
                ),
                SizedBox(height: 15.h),
                ...currentProposal.attachments.map((attachment) => Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
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
              SizedBox(height: 80.h),
              // Action Buttons
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: _ActionButton(
                      text: 'Cancel',
                      isRed: true,
                      onTap: () => Navigator.maybePop(context),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    flex: 3,
                    child: _ActionButton(
                      text: 'Accept & Continue',
                      isRed: false,
                      showArrow: true,
                      onTap: () {
                        // TODO: Handle accept action
                        Navigator.maybePop(context);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
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
    return SizedBox(
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
        ],
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
