import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/color_control/all_color.dart';
import 'set_up_withdrawals_screen.dart';

/// Flutter conversion of `lib/features/service/screen/react.tsx`.
class GetPaidNowScreen extends StatelessWidget {
  const GetPaidNowScreen({super.key});

  static const String routeName = '/get_paid_now';

  @override
  Widget build(BuildContext context) {
    final bottomNoteHeight = 70.h;

    return Scaffold(
      backgroundColor: AllColor.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(24.w, 18.h, 24.w, bottomNoteHeight),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Header(
                title: 'Get paid now',
                onBack: () => Navigator.maybePop(context),
              ),
              SizedBox(height: 32.h),
              const _InfoCard(),
              SizedBox(height: 16.h),
              const _WithdrawalMethodCard(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 8.h),
          child: const _BottomNote(),
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
                    Icons.arrow_back_ios_new_rounded,
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
              fontFamily: 'plus_Jakarta_Sans',
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

class _InfoCard extends StatelessWidget {
  const _InfoCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 13.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF5DF),
        border: Border.all(color: const Color(0xFFF2F2F2)),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          Container(
            width: 61.w,
            height: 61.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFFF9EBCD),
              border: Border.all(color: const Color(0xFFE5D4AE)),
              borderRadius: BorderRadius.circular(33.r),
            ),
            child: Text(
              'SAR',
              style: TextStyle(
                fontFamily: 'plus_Jakarta_Sans',
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
                color: const Color(0xFF8E6A1A),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              'They get paid once work is completed',
              style: TextStyle(
                fontFamily: 'sf_pro',
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
                color: Color(0xB3000000),
                height: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WithdrawalMethodCard extends StatelessWidget {
  const _WithdrawalMethodCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AllColor.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xFFF2F2F2), width: 2),
        boxShadow: [
          BoxShadow(
            color: Color(0x0A000000),
            offset: const Offset(0, 10),
            blurRadius: 13.9,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Withdrawal method',
            style: TextStyle(
              fontFamily: 'sf_pro',
              fontWeight: FontWeight.w400,
              fontSize: 14.sp,
              color: Color(0xB3000000),
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            'Alinma Bank, Riyad',
            style: TextStyle(
              fontFamily: 'sf_pro',
              fontWeight: FontWeight.w700,
              fontSize: 16.sp,
              color: AllColor.black,
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Account no: **********9876',
                  style: TextStyle(
                    fontFamily: 'sf_pro',
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                    color: Color(0xB3000000),
                  ),
                ),
              ),
              _LinkText(
                text: 'Edit',
                underline: true,
                color: const Color(0xFF82B600),
                onTap: () {},
              ),
            ],
          ),
          SizedBox(height: 18.h),
          _PrimaryPillButton(
            text: 'Get paid (SAR 635)',
            onTap: () => _showPayoutInProcessDialog(context),
          ),
          SizedBox(height: 10.h),
          Center(
            child: Text(
              'You would receive SAR 635.75 each week for 4 weeks.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'sf_pro',
                fontWeight: FontWeight.w400,
                fontSize: 12.sp,
                color: const Color(0xFF5F5F5F),
              ),
            ),
          ),
          SizedBox(height: 14.h),
          _LinkText(
            text: '+ Add new payment method',
            underline: false,
            color: const Color(0xFF82B600),
            onTap: () => context.push(SetUpWithdrawalsScreen.routeName),
          ),
        ],
      ),
    );
  }
}

class _PrimaryPillButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const _PrimaryPillButton({
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Material(
        color: const Color(0xFF02021D),
        borderRadius: BorderRadius.circular(999.r),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(999.r),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  fontFamily: 'plus_Jakarta_Sans',
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                  color: AllColor.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LinkText extends StatelessWidget {
  final String text;
  final Color color;
  final bool underline;
  final VoidCallback onTap;

  const _LinkText({
    required this.text,
    required this.color,
    required this.underline,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(6.r),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
          child: Text(
            text,
            style: TextStyle(
              fontFamily: 'sf_pro',
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
              color: color,
              decoration: underline ? TextDecoration.underline : null,
              decorationColor: color,
            ),
          ),
        ),
      ),
    );
  }
}

class _BottomNote extends StatelessWidget {
  const _BottomNote();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.info_outline_rounded,
          size: 24.sp,
          color: const Color(0xFF9B9B9B),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            'Beneficiary information will be retrieve and may take 15 seconds',
            style: TextStyle(
              fontFamily: 'plus_Jakarta_Sans',
              fontWeight: FontWeight.w400,
              fontSize: 16.sp,
              color: Color(0xB3000000),
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}

void _showPayoutInProcessDialog(BuildContext context) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final paidDate = today.add(const Duration(days: 7));

  showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (dialogContext) {
      return _PayoutInProcessDialog(
        today: today,
        paidDate: paidDate,
        days: 7,
        payoutAmount: 'SAR 635',
        totalAmount: 'SAR 2,543',
      );
    },
  );
}

class _PayoutInProcessDialog extends StatelessWidget {
  final DateTime today;
  final DateTime paidDate;
  final int days;
  final String payoutAmount;
  final String totalAmount;

  const _PayoutInProcessDialog({
    required this.today,
    required this.paidDate,
    required this.days,
    required this.payoutAmount,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Padding(
        padding: EdgeInsets.fromLTRB(24.w, 28.h, 24.w, 28.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 104.w,
              height: 104.w,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF85ae1e),
              ),
              child: Icon(
                Icons.check_rounded,
                size: 56.sp,
                color: AllColor.white,
              ),
            ),
            SizedBox(height: 22.h),
            Text(
              'Payout in process',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'plus_Jakarta_Sans',
                fontWeight: FontWeight.w700,
                fontSize: 24.sp,
                color: AllColor.black,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              'You will get paid from today next\n$days days later',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'sf_pro',
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
                color: const Color(0xFF5F5F5F),
                height: 1.3,
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              'Today: ${_formatDialogDate(today)}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'sf_pro',
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
                color: AllColor.black,
                height: 1.4,
              ),
            ),
            Text(
              'Paid date : ${_formatDialogDate(paidDate)}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'sf_pro',
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
                color: AllColor.black,
                height: 1.4,
              ),
            ),
            SizedBox(height: 22.h),
            Text.rich(
              TextSpan(
                text: 'Amount : ',
                style: TextStyle(
                  fontFamily: 'sf_pro',
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                  color: AllColor.black,
                ),
                children: [
                  TextSpan(
                    text: payoutAmount,
                    style: TextStyle(
                      fontFamily: 'sf_pro',
                      fontWeight: FontWeight.w700,
                      fontSize: 14.sp,
                      color: AllColor.black,
                    ),
                  ),
                  TextSpan(
                    text: ' ($totalAmount)',
                    style: TextStyle(
                      fontFamily: 'sf_pro',
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                      color: const Color(0xFF9B9B9B),
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

String _formatDialogDate(DateTime date) {
  const months = <String>[
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  return '${date.day} ${months[date.month - 1]} ${date.year}';
}

