import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateNewProjectFlow extends StatefulWidget {
  const CreateNewProjectFlow({super.key});
  static const String routeName = '/create-new-project-flow';

  @override
  State<CreateNewProjectFlow> createState() => _CreateNewProjectFlowState();
}

enum Urgency { immediate, oneTwoWeeks, flexible }

enum BudgetRange { under5k, from5to10k, from10to20k }

class _CreateNewProjectFlowState extends State<CreateNewProjectFlow> {
  final _pageController = PageController();
  int _step = 0; // 0..4 (4 = success)

  // Form state
  final titleCtrl = TextEditingController();
  final descCtrl = TextEditingController();
  final fullNameCtrl = TextEditingController();
  final roleCtrl = TextEditingController();

  String? category;
  Urgency urgency = Urgency.flexible;
  bool nda = true;

  BudgetRange budget = BudgetRange.from10to20k;
  String? attachmentName;

  String? preferredCommunication;
  String? bestTimeToContact;

  // Category mock
  final List<String> categories = const [
    "Compliance",
    "Specialized Procurement",
    "Rare & Specialized Procurement",
    "Technical & Engineering",
    "Confidential & Sensitive Services",
    "Executive & VIP Services",
  ];

  // Dropdown mock
  final List<String> communications = const [
    "WhatsApp",
    "Email",
    "Phone Call",
    "Zoom/Google Meet",
  ];

  final List<String> contactTimes = const [
    "Morning",
    "Afternoon",
    "Evening",
    "Anytime",
  ];

  @override
  void initState() {
    super.initState();
    descCtrl.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _pageController.dispose();
    titleCtrl.dispose();
    descCtrl.dispose();
    fullNameCtrl.dispose();
    roleCtrl.dispose();
    super.dispose();
  }

  int get totalFormSteps => 4; // step 0..3
  double get progress =>
      (_step.clamp(0, totalFormSteps - 1) + 1) / totalFormSteps;

  void _goTo(int index) {
    setState(() => _step = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOut,
    );
  }

  void _next() {
    if (_step < 3) {
      _goTo(_step + 1);
    } else if (_step == 3) {
      // Submit -> Success
      _goTo(4);
    } else if (_step == 4) {
      // Go to Discovery Page
      Navigator.popUntil(context, (r) => r.isFirst);
    }
  }

  void _back() {
    if (_step == 0) return;
    _goTo(_step - 1);
  }

  Future<void> _pickDropdown({
    required String title,
    required List<String> items,
    required String? selected,
    required ValueChanged<String> onSelected,
  }) async {
    final picked = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) =>
          _SimplePickerSheet(title: title, items: items, selected: selected),
    );
    if (picked != null) onSelected(picked);
  }

  @override
  Widget build(BuildContext context) {
    // ScreenUtilInit সাধারণত main.dart এ করবেন। এখানে ধরে নিলাম আপনার app এ already আছে।
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            if (_step <= 3)
              _Header(
                step: _step,
                total: totalFormSteps,
                onBack: _step == 0 ? null : _back,
                progress: progress,
              ),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _Step1(
                    titleCtrl: titleCtrl,
                    categories: categories,
                    category: category,
                    onCategoryChanged: (v) => setState(() => category = v),
                  ),
                  _Step2(
                    descCtrl: descCtrl,
                    urgency: urgency,
                    onUrgencyChanged: (v) => setState(() => urgency = v),
                    nda: nda,
                    onNdaChanged: (v) => setState(() => nda = v),
                  ),
                  _Step3(
                    budget: budget,
                    onBudgetChanged: (v) => setState(() => budget = v),
                    attachmentName: attachmentName,
                    onAttach: () {
                      // UI only (আপনি চাইলে file_picker দিয়ে বাস্তবে attach করবেন)
                      setState(() => attachmentName = "proposal.pdf");
                    },
                  ),
                  _Step4(
                    fullNameCtrl: fullNameCtrl,
                    roleCtrl: roleCtrl,
                    preferredCommunication: preferredCommunication,
                    bestTimeToContact: bestTimeToContact,
                    onPickCommunication: () => _pickDropdown(
                      title: "Preferred communication",
                      items: communications,
                      selected: preferredCommunication,
                      onSelected: (v) =>
                          setState(() => preferredCommunication = v),
                    ),
                    onPickBestTime: () => _pickDropdown(
                      title: "Best time to contact",
                      items: contactTimes,
                      selected: bestTimeToContact,
                      onSelected: (v) => setState(() => bestTimeToContact = v),
                    ),
                  ),
                  const _SuccessStep(),
                ],
              ),
            ),
            if (_step <= 4) _BottomBar(step: _step, onNext: _next),
          ],
        ),
      ),
    );
  }
}

/// ======================= Header =======================
class _Header extends StatelessWidget {
  const _Header({
    required this.step,
    required this.total,
    required this.onBack,
    required this.progress,
  });

  final int step;
  final int total;
  final VoidCallback? onBack;
  final double progress;

  @override
  Widget build(BuildContext context) {
    final isSuccess = step >= total;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
      child: SizedBox(
        height: 44.w,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: _BackBtn(onTap: onBack),
            ),
            Center(
              child: Text(
                "Create New Project",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF111111),
                ),
              ),
            ),
            if (!isSuccess)
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "${(step + 1)}/$total",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF6B7280),
                      ),
                    ),
                    SizedBox(width: 6.w),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(99.r),
                      child: SizedBox(
                        width: 48.w,
                        child: LinearProgressIndicator(
                          minHeight: 6.h,
                          value: progress,
                          backgroundColor: const Color(0xFFE5E7EB),
                          valueColor: const AlwaysStoppedAnimation(
                            Color(0xFF96d103),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _BackBtn extends StatelessWidget {
  const _BackBtn({required this.onTap});
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
          borderRadius: BorderRadius.circular(10.r),
        ),
        width: 44.w,
        height: 44.w,
        child: Icon(
          Icons.arrow_back,
          size: 18.sp,
          color: const Color(0xFF111111),
        ),
      ),
    );
  }
}

/// ======================= Bottom Bar =======================
class _BottomBar extends StatelessWidget {
  const _BottomBar({required this.step, required this.onNext});
  final int step;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final isSuccess = step == 4;

    String label;
    if (isSuccess) {
      label = "Go to Discovery Page";
    } else if (step == 0) {
      label = "Next Step";
    } else if (step == 3) {
      label = "Submit";
    } else {
      label = "Next";
    }

    final showArrow = !isSuccess && step != 3;

    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 18.h),
      color: Colors.white,
      child: _PrimaryButton(
        label: label,
        trailing: showArrow ? Icons.arrow_forward_rounded : null,
        onTap: onNext,
      ),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({
    required this.label,
    required this.onTap,
    this.trailing,
  });

  final String label;
  final VoidCallback onTap;
  final IconData? trailing;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52.h,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0B0B2B),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26.r),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            if (trailing != null) ...[
              SizedBox(width: 8.w),
              Icon(trailing, size: 18.sp, color: Colors.white),
            ],
          ],
        ),
      ),
    );
  }
}

/// ======================= Shared Field UI =======================
class _Label extends StatelessWidget {
  const _Label(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF111111),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}

class _Input extends StatelessWidget {
  const _Input({
    required this.hint,
    required this.controller,
    this.maxLines = 1,
  });

  final String hint;
  final TextEditingController controller;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: TextStyle(fontSize: 13.sp, color: const Color(0xFF111111)),
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintText: hint,
        hintStyle: TextStyle(fontSize: 13.sp, color: const Color(0xFF9CA3AF)),
        contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(color: Color(0xFFE5E7EB), width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(color: Color(0xFFE5E7EB), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(color: Color(0xFFCBD5E1), width: 1),
        ),
      ),
    );
  }
}

class _SelectField extends StatelessWidget {
  const _SelectField({
    required this.text,
    required this.onTap,
    required this.hint,
  });

  final String? text;
  final String hint;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        height: 48.h,
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                text ?? hint,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: text == null
                      ? const Color(0xFF9CA3AF)
                      : const Color(0xFF111111),
                ),
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 20.sp,
              color: const Color(0xFF6B7280),
            ),
          ],
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: child,
    );
  }
}

/// ======================= Step 1 =======================
class _Step1 extends StatelessWidget {
  const _Step1({
    required this.titleCtrl,
    required this.categories,
    required this.category,
    required this.onCategoryChanged,
  });

  final TextEditingController titleCtrl;
  final List<String> categories;
  final String? category;
  final ValueChanged<String> onCategoryChanged;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Column(
        children: [
          _Section(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _Label("Project title *"),
                SizedBox(height: 8.h),
                _Input(hint: "Write a title", controller: titleCtrl),
              ],
            ),
          ),
          _Section(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _Label("Category"),
                SizedBox(height: 8.h),
                _CategoryDropdownField(
                  hint: "Search category / type",
                  items: categories,
                  value: category,
                  onChanged: onCategoryChanged,
                ),
                SizedBox(height: 8.h),
                Text(
                  "Tip: Choose the closest category for faster matching.",
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: const Color(0xFF9CA3AF),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 80.h),
        ],
      ),
    );
  }
}

class _CategoryDropdownField extends StatefulWidget {
  const _CategoryDropdownField({
    required this.hint,
    required this.items,
    required this.value,
    required this.onChanged,
  });

  final String hint;
  final List<String> items;
  final String? value;
  final ValueChanged<String> onChanged;

  @override
  State<_CategoryDropdownField> createState() => _CategoryDropdownFieldState();
}

class _CategoryDropdownFieldState extends State<_CategoryDropdownField> {
  final _link = LayerLink();
  final _targetKey = GlobalKey();
  OverlayEntry? _entry;

  bool get _isOpen => _entry != null;

  @override
  void dispose() {
    _hide();
    super.dispose();
  }

  void _toggle() {
    if (_isOpen) {
      _hide();
    } else {
      _show();
    }
  }

  void _hide() {
    _entry?.remove();
    _entry = null;
    if (mounted) setState(() {});
  }

  void _show() {
    final overlay = Overlay.maybeOf(context);
    final box = _targetKey.currentContext?.findRenderObject() as RenderBox?;
    if (overlay == null || box == null) return;

    final targetSize = box.size;
    final highlight = const Color(0xFFC7FF38);

    _entry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: _hide,
              ),
            ),
            CompositedTransformFollower(
              link: _link,
              showWhenUnlinked: false,
              offset: Offset(0, targetSize.height + 8.h),
              child: Material(
                color: Colors.transparent,
                child: SizedBox(
                  width: targetSize.width,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 6.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: const Color(0xFFE5E7EB),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.08),
                          blurRadius: 18,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    constraints: BoxConstraints(maxHeight: 280.h),
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      shrinkWrap: true,
                      itemCount: widget.items.length,
                      separatorBuilder: (_, __) => SizedBox(height: 6.h),
                      itemBuilder: (_, i) {
                        final item = widget.items[i];
                        final selected = item == widget.value;
                        return InkWell(
                          onTap: () {
                            widget.onChanged(item);
                            _hide();
                          },
                          borderRadius: BorderRadius.circular(10.r),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 10.h,
                            ),
                            decoration: BoxDecoration(
                              color: selected ? highlight : Colors.transparent,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Text(
                              item,
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF111111),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );

    overlay.insert(_entry!);
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _link,
      child: InkWell(
        key: _targetKey,
        onTap: _toggle,
        borderRadius: BorderRadius.circular(10.r),
        child: Container(
          height: 48.h,
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
            color: Colors.white,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  widget.value ?? widget.hint,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: widget.value == null
                        ? const Color(0xFF9CA3AF)
                        : const Color(0xFF111111),
                  ),
                ),
              ),
              Icon(
                _isOpen
                    ? Icons.keyboard_arrow_up_rounded
                    : Icons.keyboard_arrow_down_rounded,
                size: 20.sp,
                color: const Color(0xFF6B7280),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// ======================= Step 2 =======================
class _Step2 extends StatelessWidget {
  const _Step2({
    required this.descCtrl,
    required this.urgency,
    required this.onUrgencyChanged,
    required this.nda,
    required this.onNdaChanged,
  });

  final TextEditingController descCtrl;
  final Urgency urgency;
  final ValueChanged<Urgency> onUrgencyChanged;
  final bool nda;
  final ValueChanged<bool> onNdaChanged;

  @override
  Widget build(BuildContext context) {
    final remaining = 999 - descCtrl.text.length;

    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Column(
        children: [
          _Section(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _Label("Project Description"),
                SizedBox(height: 8.h),
                _Input(
                  hint: "Write project description...",
                  controller: descCtrl,
                  maxLines: 5,
                ),
                SizedBox(height: 6.h),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "$remaining characters left",
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: const Color(0xFF9CA3AF),
                    ),
                  ),
                ),
              ],
            ),
          ),
          _Section(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _Label("Urgency"),
                SizedBox(height: 8.h),
                _UrgencyGroup(value: urgency, onChanged: onUrgencyChanged),
              ],
            ),
          ),
          _Section(
            child: Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "NDA",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF111111),
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          "This project involves confidential information\nthat requires a non-disclosure agreement",
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: const Color(0xFF6B7280),
                            height: 1.25,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: nda,
                    onChanged: onNdaChanged,
                    activeColor: Colors.white, // thumb (ON)
                    activeTrackColor: const Color(0xFF81B401), // track (ON)
                    inactiveThumbColor: Colors.white, // thumb (OFF)
                    inactiveTrackColor: const Color(0xFFE5E7EB), // track (OFF)
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 80.h),
        ],
      ),
    );
  }
}

/// ======================= Step 3 =======================
class _Step3 extends StatelessWidget {
  const _Step3({
    required this.budget,
    required this.onBudgetChanged,
    required this.attachmentName,
    required this.onAttach,
  });

  final BudgetRange budget;
  final ValueChanged<BudgetRange> onBudgetChanged;
  final String? attachmentName;
  final VoidCallback onAttach;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Column(
        children: [
          _Section(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _Label("Budget Range"),
                SizedBox(height: 8.h),
                _BudgetGroup(value: budget, onChanged: onBudgetChanged),
              ],
            ),
          ),
          _Section(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _Label("Attach File"),
                SizedBox(height: 8.h),
                InkWell(
                  onTap: onAttach,
                  borderRadius: BorderRadius.circular(12.r),
                  child: CustomPaint(
                    painter: _DashedBorderPainter(
                      color: const Color(0xFF9CA3AF),
                      radius: 12.r,
                      dash: 5.w,
                      gap: 4.w,
                    ),
                    child: Container(
                      height: 68.h,
                      padding: EdgeInsets.symmetric(horizontal: 14.w),
                      child: Row(
                        children: [
                          Container(
                            width: 34.w,
                            height: 34.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              color: const Color(0xFF81B401),
                            ),
                            child: Icon(
                              Icons.attachment_rounded,
                              size: 18.sp,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  attachmentName ?? "Attach file",
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF111111),
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  "pdf, png, jpeg and max 10mb",
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    color: const Color(0xFF9CA3AF),
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
              ],
            ),
          ),
          SizedBox(height: 80.h),
        ],
      ),
    );
  }
}

/// ======================= Step 4 =======================
class _Step4 extends StatelessWidget {
  const _Step4({
    required this.fullNameCtrl,
    required this.roleCtrl,
    required this.preferredCommunication,
    required this.bestTimeToContact,
    required this.onPickCommunication,
    required this.onPickBestTime,
  });

  final TextEditingController fullNameCtrl;
  final TextEditingController roleCtrl;

  final String? preferredCommunication;
  final String? bestTimeToContact;
  final VoidCallback onPickCommunication;
  final VoidCallback onPickBestTime;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Column(
        children: [
          _Section(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _Label("Full Name"),
                SizedBox(height: 8.h),
                _Input(hint: "Write a name", controller: fullNameCtrl),
                SizedBox(height: 14.h),
                const _Label("Role"),
                SizedBox(height: 8.h),
                _Input(hint: "Type your role here", controller: roleCtrl),
                SizedBox(height: 14.h),
                const _Label("Preferred communication"),
                SizedBox(height: 8.h),
                _SelectField(
                  text: preferredCommunication,
                  hint: "How should we contact you",
                  onTap: onPickCommunication,
                ),
                SizedBox(height: 14.h),
                const _Label("Best time to contact"),
                SizedBox(height: 8.h),
                _SelectField(
                  text: bestTimeToContact,
                  hint: "When is the best time to reach you",
                  onTap: onPickBestTime,
                ),
              ],
            ),
          ),
          SizedBox(height: 80.h),
        ],
      ),
    );
  }
}

/// ======================= Success Step =======================
class _SuccessStep extends StatelessWidget {
  const _SuccessStep();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            const Spacer(),
            Image.asset(
              "assets/images/sucessfull.png",
              width: 220.w,
              height: 220.w,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 14.h),
            Text(
              "Project Created successfully.",
              style: GoogleFonts.plusJakartaSans(
                fontSize: 28.sp,
                fontWeight: FontWeight.w900,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            SizedBox(height: 12.h),
          ],
        ),
      ),
    );
  }
}

class _BudgetGroup extends StatelessWidget {
  const _BudgetGroup({required this.value, required this.onChanged});

  final BudgetRange value;
  final ValueChanged<BudgetRange> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
      ),
      child: Column(
        children: [
          _RadioRowSimple(
            selected: value == BudgetRange.under5k,
            title: "Under \$5,000",
            onTap: () => onChanged(BudgetRange.under5k),
          ),
          SizedBox(height: 22.h),
          _RadioRowSimple(
            selected: value == BudgetRange.from5to10k,
            title: "\$5,000 - \$10,000",
            onTap: () => onChanged(BudgetRange.from5to10k),
          ),
          SizedBox(height: 22.h),
          _RadioRowSimple(
            selected: value == BudgetRange.from10to20k,
            title: "\$10,000 - \$20,000",
            onTap: () => onChanged(BudgetRange.from10to20k),
          ),
        ],
      ),
    );
  }
}

class _RadioRowSimple extends StatelessWidget {
  const _RadioRowSimple({
    required this.selected,
    required this.title,
    required this.onTap,
  });

  final bool selected;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 6.h),
        child: Row(
          children: [
            _RadioDot(selected: selected),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF111111),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UrgencyGroup extends StatelessWidget {
  const _UrgencyGroup({required this.value, required this.onChanged});

  final Urgency value;
  final ValueChanged<Urgency> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
      ),
      child: Column(
        children: [
          _RadioRow(
            selected: value == Urgency.immediate,
            title: "Immediate",
            subtitle: "Start work within 24 hours",
            onTap: () => onChanged(Urgency.immediate),
          ),
          SizedBox(height: 12.h),
          _RadioRow(
            selected: value == Urgency.oneTwoWeeks,
            title: "1-2 weeks",
            subtitle: "Standard timeline for complex projects",
            onTap: () => onChanged(Urgency.oneTwoWeeks),
          ),
          SizedBox(height: 12.h),
          _RadioRow(
            selected: value == Urgency.flexible,
            title: "Flexible",
            subtitle: "Timeline can be adjusted based on requirements",
            onTap: () => onChanged(Urgency.flexible),
          ),
        ],
      ),
    );
  }
}

class _RadioRow extends StatelessWidget {
  const _RadioRow({
    required this.selected,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final bool selected;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 2.h),
              child: _RadioDot(selected: selected),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF111111),
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: const Color(0xFF6B7280),
                      height: 1.25,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RadioDot extends StatelessWidget {
  const _RadioDot({required this.selected});
  final bool selected;

  @override
  Widget build(BuildContext context) {
    const accent = Color(0xFF81B401);
    return Container(
      width: 20.w,
      height: 20.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: selected ? accent : const Color(0xFFD1D5DB),
          width: 3,
        ),
      ),
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          width: selected ? 10.w : 0,
          height: selected ? 10.w : 0,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: accent,
          ),
        ),
      ),
    );
  }
}

/// ======================= Simple Picker Sheet =======================
class _SimplePickerSheet extends StatelessWidget {
  const _SimplePickerSheet({
    required this.title,
    required this.items,
    required this.selected,
  });

  final String title;
  final List<String> items;
  final String? selected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 16.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 44.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: const Color(0xFFE5E7EB),
              borderRadius: BorderRadius.circular(99.r),
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            title,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 10.h),
          Flexible(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: items.length,
              separatorBuilder: (_, __) =>
                  Divider(height: 1.h, color: const Color(0xFFF3F4F6)),
              itemBuilder: (_, i) {
                final item = items[i];
                final isSel = item == selected;
                return ListTile(
                  onTap: () => Navigator.pop(context, item),
                  title: Text(
                    item,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  trailing: isSel
                      ? const Icon(
                          Icons.check_rounded,
                          color: Color(0xFF75D325),
                        )
                      : null,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// ======================= Dashed Border Painter =======================
class _DashedBorderPainter extends CustomPainter {
  _DashedBorderPainter({
    required this.color,
    required this.radius,
    required this.dash,
    required this.gap,
  });

  final Color color;
  final double radius;
  final double dash;
  final double gap;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = color;

    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(radius),
    );

    final path = Path()..addRRect(rrect);
    final metrics = path.computeMetrics().toList();

    for (final m in metrics) {
      double distance = 0;
      while (distance < m.length) {
        final next = min(distance + dash, m.length);
        final seg = m.extractPath(distance, next);
        canvas.drawPath(seg, paint);
        distance = next + gap;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedBorderPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.radius != radius ||
        oldDelegate.dash != dash ||
        oldDelegate.gap != gap;
  }
}

/// ======================= Confetti Painter =======================
// (Confetti painter removed — success screen now matches the existing app design)
