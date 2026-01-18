import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/color_control/all_color.dart';

/// Flutter conversion of `lib/features/service/screen/react.tsx` (Set up withdrawals).
class SetUpWithdrawalsScreen extends StatefulWidget {
  const SetUpWithdrawalsScreen({super.key});

  static const String routeName = '/set_up_withdrawals';

  @override
  State<SetUpWithdrawalsScreen> createState() => _SetUpWithdrawalsScreenState();
}

class _SetUpWithdrawalsScreenState extends State<SetUpWithdrawalsScreen> {
  String? _selectedBank;
  String? _accountType;
  String? _country;
  DateTime? _dob;
  bool _attest = false;
  _CustomerIdType _customerIdType = _CustomerIdType.driversLicenseOnly;

  Future<void> _pickDob() async {
    final now = DateTime.now();
    final initial = _dob ?? DateTime(now.year - 18, now.month, now.day);

    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(1900),
      lastDate: now,
    );

    if (picked == null) return;
    setState(() => _dob = picked);
  }

  void _onSubmit() {
    if (!_attest) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please confirm the attestation checkbox.'),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Submitted (UI only).')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomBarPadding = 170.h;
    final dobText =
        _dob == null ? '' : MaterialLocalizations.of(context).formatMediumDate(_dob!);

    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(24.w, 18.h, 24.w, bottomBarPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Header(
                title: 'Set up withdrawals',
                onBack: () => Navigator.maybePop(context),
              ),
              SizedBox(height: 24.h),
              _LabeledDropdownField(
                label: 'Select bank *',
                value: _selectedBank,
                hintText: 'Please Select...',
                items: const [
                  'AL RAJHI BANK',
                  'Alinma Bank, Riyad',
                ],
                onChanged: (v) => setState(() => _selectedBank = v),
              ),
              SizedBox(height: 24.h),
              const _SelectedBankCard(),
              SizedBox(height: 22.h),
              Text(
                'Account Holder Bank Information',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: 'sf_pro',
                  fontWeight: FontWeight.w500,
                  fontSize: 22.sp,
                  color: const Color(0xFFB5B5B5),
                ),
              ),
              SizedBox(height: 20.h),
              const _LabeledTextField(
                label: 'Account number *',
                hintText: '23456788765',
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 24.h),
              const _LabeledTextField(
                label: 'Zip code *',
                hintText: '234',
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 24.h),
              _LabeledDropdownField(
                label: 'Bank account type *',
                value: _accountType,
                hintText: 'Please Select...',
                items: const ['Checking', 'Savings'],
                onChanged: (v) => setState(() => _accountType = v),
              ),
              SizedBox(height: 24.h),
              const _LabeledTextField(
                label: 'Bank Name*',
                hintText: 'Branch name',
              ),
              SizedBox(height: 24.h),
              const _LabeledTextField(
                label: 'Bank Address *',
                hintText: 'Branch address',
              ),
              SizedBox(height: 24.h),
              const _LabeledTextField(
                label: 'First name *',
                hintText: 'First name',
              ),
              SizedBox(height: 24.h),
              const _LabeledTextField(
                label: 'Last name *',
                hintText: 'Last name',
              ),
              SizedBox(height: 24.h),
              _LabeledTextField(
                key: ValueKey(_dob),
                label: 'Enter date of birth *',
                hintText: 'Enter date of birth',
                initialValue: dobText,
                readOnly: true,
                keyboardType: TextInputType.datetime,
                prefixIcon: Icon(
                  Icons.calendar_month_outlined,
                  size: 22.sp,
                  color: const Color(0xFFB5B5B5),
                ),
                onTap: _pickDob,
              ),
              SizedBox(height: 24.h),
              _CustomerIdTypeSection(
                value: _customerIdType,
                onChanged: (v) => setState(() => _customerIdType = v),
              ),
              SizedBox(height: 24.h),
              const _LabeledTextField(
                label: 'Name on account *',
                hintText: 'Enter account name',
              ),
              SizedBox(height: 24.h),
              const _LabeledTextField(
                label: 'City & Sate/province *',
                hintText: 'Enter account name',
              ),
              SizedBox(height: 24.h),
              _LabeledDropdownField(
                label: 'Country *',
                value: _country,
                hintText: 'Please Select...',
                items: const ['Saudi Arabia', 'United States', 'United Kingdom'],
                onChanged: (v) => setState(() => _country = v),
              ),
              SizedBox(height: 24.h),
              const _LabeledTextField(
                label: 'Phone Number *',
                hintText: 'Enter number',
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 24.h),
              _AttestationRow(
                value: _attest,
                onChanged: (v) => setState(() => _attest = v),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          decoration: const BoxDecoration(
            color: AllColor.white,
            boxShadow: [
              BoxShadow(
                color: Color(0x14000000),
                offset: Offset(0, 0),
                blurRadius: 12.4,
              ),
            ],
          ),
          padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 8.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _PrimaryPillButton(
                text: 'Submit Proposal',
                onTap: _onSubmit,
              ),
              SizedBox(height: 10.h),
              Container(
                width: 134.w,
                height: 5.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF02021D),
                  borderRadius: BorderRadius.circular(100.r),
                ),
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

class _SelectedBankCard extends StatelessWidget {
  const _SelectedBankCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AllColor.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xFFEAEAEA), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your selected bank',
            style: TextStyle(
              fontFamily: 'sf_pro',
              fontWeight: FontWeight.w400,
              fontSize: 14.sp,
              color: const Color(0xB2000000),
            ),
          ),
          SizedBox(height: 14.h),
          Text(
            'AL RAJHI BANK',
            style: TextStyle(
              fontFamily: 'sf_pro',
              fontWeight: FontWeight.w700,
              fontSize: 16.sp,
              color: AllColor.black,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            '8467 KING FAHD ROAD, AL MURUJ DISTRICT',
            style: TextStyle(
              fontFamily: 'sf_pro',
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
              color: AllColor.black,
            ),
          ),
          SizedBox(height: 14.h),
          _LinkText(
            text: 'Not your bank or branch?',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _LabeledTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextInputType? keyboardType;
  final bool readOnly;
  final String? initialValue;
  final VoidCallback? onTap;
  final Widget? prefixIcon;

  const _LabeledTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.keyboardType,
    this.readOnly = false,
    this.initialValue,
    this.onTap,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'sf_pro',
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
            color: AllColor.black,
          ),
        ),
        SizedBox(height: 10.h),
        SizedBox(
          height: 56.h,
          child: TextFormField(
            initialValue: initialValue,
            readOnly: readOnly,
            onTap: onTap,
            keyboardType: keyboardType,
            textAlignVertical: TextAlignVertical.center,
            style: TextStyle(
              fontFamily: 'sf_pro',
              fontWeight: FontWeight.w400,
              fontSize: 18.sp,
              color: AllColor.black,
            ),
            decoration: _fieldDecoration(
              hintText: hintText,
              prefixIcon: prefixIcon,
            ),
          ),
        ),
      ],
    );
  }
}

class _LabeledDropdownField extends StatelessWidget {
  final String label;
  final String hintText;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const _LabeledDropdownField({
    required this.label,
    required this.hintText,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'sf_pro',
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
            color: AllColor.black,
          ),
        ),
        SizedBox(height: 10.h),
        SizedBox(
          height: 56.h,
          child: DropdownButtonFormField<String>(
            value: value,
            onChanged: onChanged,
            icon: Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 26.sp,
              color: const Color(0xFF002807),
            ),
            style: TextStyle(
              fontFamily: 'sf_pro',
              fontWeight: FontWeight.w400,
              fontSize: 18.sp,
              color: AllColor.black,
            ),
            decoration: _fieldDecoration(hintText: hintText),
            items: items
                .map(
                  (item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}

InputDecoration _fieldDecoration({
  required String hintText,
  Widget? prefixIcon,
}) {
  return InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(
      fontFamily: 'sf_pro',
      fontWeight: FontWeight.w400,
      fontSize: 18.sp,
      color: const Color(0xFFB5B5B5),
    ),
    filled: true,
    fillColor: AllColor.white,
    isDense: true,
    contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
    prefixIcon: prefixIcon,
    prefixIconConstraints: BoxConstraints(minWidth: 44.w, minHeight: 44.w),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: BorderSide(color: const Color(0xFFEAEAEA), width: 1.5.w),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: BorderSide(color: const Color(0xFFEAEAEA), width: 1.5.w),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: BorderSide(color: const Color(0xFF82B600), width: 1.5.w),
    ),
  );
}

enum _CustomerIdType { driversLicenseOnly }

class _CustomerIdTypeSection extends StatelessWidget {
  final _CustomerIdType value;
  final ValueChanged<_CustomerIdType> onChanged;

  const _CustomerIdTypeSection({
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Customer ID type',
          style: TextStyle(
            fontFamily: 'sf_pro',
            fontWeight: FontWeight.w500,
            fontSize: 14.sp,
            color: AllColor.black,
          ),
        ),
        SizedBox(height: 9.h),
        InkWell(
          onTap: () => onChanged(_CustomerIdType.driversLicenseOnly),
          borderRadius: BorderRadius.circular(8.r),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 6.h),
            child: Row(
              children: [
                _RadioDot(
                  selected: value == _CustomerIdType.driversLicenseOnly,
                ),
                SizedBox(width: 8.w),
                Text(
                  "Driver's license only",
                  style: TextStyle(
                    fontFamily: 'sf_pro',
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                    color: AllColor.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _RadioDot extends StatelessWidget {
  final bool selected;

  const _RadioDot({required this.selected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24.w,
      height: 24.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFF82B600)),
      ),
      child: selected
          ? Center(
              child: Container(
                width: 14.w,
                height: 14.w,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF82B600),
                ),
              ),
            )
          : null,
    );
  }
}

class _AttestationRow extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const _AttestationRow({
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SquareCheckbox(value: value, onChanged: onChanged),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            'I attest that I’m the owner and have full authorization to this bank account.',
            style: TextStyle(
              fontFamily: 'sf_pro',
              fontWeight: FontWeight.w600,
              fontSize: 16.sp,
              color: const Color(0xDE000000),
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}

class _SquareCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SquareCheckbox({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onChanged(!value),
        borderRadius: BorderRadius.circular(6.r),
        child: Ink(
          width: 24.w,
          height: 24.w,
          decoration: BoxDecoration(
            color: AllColor.white,
            border: Border.all(color: const Color(0xFF9B9B9B)),
            borderRadius: BorderRadius.circular(6.r),
          ),
          child: value
              ? Icon(
                  Icons.check_rounded,
                  size: 18.sp,
                  color: const Color(0xFF82B600),
                )
              : null,
        ),
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
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  fontFamily: 'plus_Jakarta_Sans',
                  fontWeight: FontWeight.w600,
                  fontSize: 18.sp,
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
  final VoidCallback onTap;

  const _LinkText({required this.text, required this.onTap});

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
              fontWeight: FontWeight.w700,
              fontSize: 14.sp,
              color: const Color(0xFF82B600),
            ),
          ),
        ),
      ),
    );
  }
}
