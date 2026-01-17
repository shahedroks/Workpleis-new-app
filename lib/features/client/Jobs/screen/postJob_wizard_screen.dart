import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

/// =======================
///  MODELS
/// =======================

/// =======================
///  MAIN SCREEN (WIZARD)
/// =======================
class PostJobWizardScreen extends StatefulWidget {
  const PostJobWizardScreen({super.key});
  static const String routeName = '/post-job-wizard';

  @override
  State<PostJobWizardScreen> createState() => _PostJobWizardScreenState();
}

class _PostJobWizardScreenState extends State<PostJobWizardScreen> {
  final PageController _page = PageController();
  int _step = 0;

  // controllers
  final _titleCtrl = TextEditingController();
  final _searchCtrl = TextEditingController();
  final _descCtrl = TextEditingController();

  final ImagePicker _imagePicker = ImagePicker();

  // data
  late final List<StepItem> steps;
  late final List<CategoryItem> mostUsed;
  late final List<CategoryItem> allCategories;

  final Set<String> _selectedSearchCategoryIds = {};
  final Set<String> _selectedMostUsedCategoryIds = {};
  ProjectSize? _projectSize;
  final List<AttachedFile> _files = [];

  String? _budgetDropdown; // "$600-$1200"
  String? _budgetQuick; // "SAR 600"
  bool _budgetError = false;

  @override
  void initState() {
    super.initState();

    steps = [
      StepItem(
        id: "post",
        title: "Post a job",
        icon: Icons.work_outline,
        number: "1",
      ),
      StepItem(
        id: "offers",
        title: "Get Offers",
        icon: Icons.person_outline,
        number: "2",
      ),
      StepItem(
        id: "choose",
        title: "Choose a\nworkpeer",
        icon: Icons.share_outlined,
        number: "3",
      ),
    ];

    mostUsed = [
      CategoryItem("assembly", "Assembly"),
      CategoryItem("mounting", "Mounting"),
      CategoryItem("moving", "Moving"),
      CategoryItem("cleaning", "Cleaning"),
      CategoryItem("outdoor", "Outdoor Help"),
      CategoryItem("home", "Home Repairs"),
      CategoryItem("painting", "Painting"),
      CategoryItem("trending", "Trending"),
    ];

    allCategories = [
      CategoryItem("gfa", "General Furniture Assembly"),
      CategoryItem("ikea", "IKEA Assembly"),
      CategoryItem("crib", "Crib Assembly"),
      CategoryItem("pax", "PAX Assembly"),
      CategoryItem("desk", "Desk Assembly"),
      CategoryItem("bookshelf", "Bookshelf Assembly"),
    ];

    _projectSize = ProjectSize.small;

    _descCtrl.addListener(() => setState(() {}));
    _searchCtrl.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _page.dispose();
    _titleCtrl.dispose();
    _searchCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  // -----------------------
  //  UI TOKENS (design)
  // -----------------------
  static const Color kBorder = Color(0xFFE6E7EB);
  static const Color kMuted = Color(0xFF7A7A7A);
  static const Color kText = Color(0xFF111111);
  static const Color kChipBg = Color(0xFFF3F3F3);
  static const Color kLime = Color(0xFF82b500);

  // -----------------------
  //  FLOW ACTIONS
  // -----------------------
  void _back() {
    if (_step == 0) {
      Navigator.maybePop(context);
      return;
    }
    setState(() => _step -= 1);
    _page.previousPage(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }

  void _next() {
    // validations
    if (_step == 0) {
      if (_titleCtrl.text.trim().isEmpty) {
        _toast("Please write a title.");
        return;
      }
    }

    if (_step == 3) {
      final ok =
          (_budgetDropdown != null && _budgetDropdown!.isNotEmpty) ||
          (_budgetQuick != null);
      if (!ok) {
        setState(() => _budgetError = true);
        return;
      }
      // go preview
      final draft = JobDraft(
        title: _titleCtrl.text.trim(),
        categories: _selectedCategories(),
        size: _projectSize ?? ProjectSize.small,
        description: _descCtrl.text.trim(),
        files: List.of(_files),
        budget: _budgetQuick ?? _budgetDropdown ?? "",
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => JobPreviewScreen(
            draft: draft,
            onEdit: () => Navigator.pop(context),
            onPublish: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const JobPostedSuccessScreen(),
                ),
              );
            },
          ),
        ),
      );
      return;
    }

    setState(() => _step += 1);
    _page.nextPage(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }

  void _toast(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg, style: GoogleFonts.plusJakartaSans())),
    );
  }

  Set<String> _allSelectedCategoryIds() {
    return {..._selectedSearchCategoryIds, ..._selectedMostUsedCategoryIds};
  }

  List<CategoryItem> _categoriesFromIds(Set<String> ids) {
    final map = <String, CategoryItem>{};
    for (final c in mostUsed) map[c.id] = c;
    for (final c in allCategories) map[c.id] = c;
    return ids.map((id) => map[id]).whereType<CategoryItem>().toList();
  }

  List<CategoryItem> _selectedCategories() {
    return _categoriesFromIds(_allSelectedCategoryIds());
  }

  List<CategoryItem> _selectedSearchCategories() {
    return _categoriesFromIds(_selectedSearchCategoryIds);
  }

  // -----------------------
  //  CATEGORY actions
  // -----------------------
  void _toggleSearchCategory(CategoryItem c) {
    setState(() {
      if (_selectedSearchCategoryIds.contains(c.id)) {
        _selectedSearchCategoryIds.remove(c.id);
      } else {
        _selectedSearchCategoryIds.add(c.id);
      }
    });
  }

  void _toggleMostUsedCategory(CategoryItem c) {
    setState(() {
      if (_selectedMostUsedCategoryIds.contains(c.id)) {
        _selectedMostUsedCategoryIds.remove(c.id);
      } else {
        _selectedMostUsedCategoryIds.add(c.id);
      }
    });
  }

  // -----------------------
  //  FILE actions (images)
  // -----------------------
  static const int _maxAttachmentBytes = 10 * 1024 * 1024; // 10 MB

  Future<void> _showAttachImageSheet() async {
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18.r)),
      ),
      builder: (sheetCtx) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 16.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 44.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE6E7EB),
                    borderRadius: BorderRadius.circular(99.r),
                  ),
                ),
                SizedBox(height: 14.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Attach image",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w800,
                      color: kText,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F3F3),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: kBorder),
                    ),
                    child: Icon(
                      Icons.camera_alt_rounded,
                      color: kText,
                      size: 20.sp,
                    ),
                  ),
                  title: Text(
                    "Camera",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                      color: kText,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(sheetCtx).pop();
                    _pickSingleImage(ImageSource.camera);
                  },
                ),
                Divider(color: kBorder, height: 1.h),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F3F3),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: kBorder),
                    ),
                    child: Icon(
                      Icons.photo_library_rounded,
                      color: kText,
                      size: 20.sp,
                    ),
                  ),
                  title: Text(
                    "Gallery",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                      color: kText,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(sheetCtx).pop();
                    _pickImagesFromGallery();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _pickSingleImage(ImageSource source) async {
    try {
      // Let the sheet close first (avoids UI flicker on some devices)
      await Future.delayed(const Duration(milliseconds: 150));

      final picked = await _imagePicker.pickImage(
        source: source,
        imageQuality: 85,
      );
      if (picked == null) return;
      await _addPickedImage(picked);
    } catch (_) {
      if (!mounted) return;
      _toast("Couldn't pick image. Please try again.");
    }
  }

  Future<void> _pickImagesFromGallery() async {
    try {
      await Future.delayed(const Duration(milliseconds: 150));

      final picked = await _imagePicker.pickMultiImage(imageQuality: 85);
      if (picked.isEmpty) return;

      int added = 0;
      int skipped = 0;

      for (final x in picked) {
        final ok = await _addPickedImage(x, showErrors: false);
        if (ok) {
          added += 1;
        } else {
          skipped += 1;
        }
      }

      if (!mounted) return;
      if (added > 0 && skipped > 0) {
        _toast("Added $added image(s), skipped $skipped.");
      } else if (added == 0 && skipped > 0) {
        _toast("No image added (some were too large / duplicated).");
      }
    } catch (_) {
      if (!mounted) return;
      _toast("Couldn't pick images. Please try again.");
    }
  }

  Future<bool> _addPickedImage(XFile picked, {bool showErrors = true}) async {
    final exists = _files.any((f) => f.path == picked.path);
    if (exists) {
      if (showErrors) _toast("This image is already attached.");
      return false;
    }

    final byteLength = await picked.length();
    if (byteLength > _maxAttachmentBytes) {
      if (showErrors) _toast("Max file size is 10 MB.");
      return false;
    }

    final name = picked.name.isNotEmpty ? picked.name : _basename(picked.path);
    final sizeLabel = _formatBytes(byteLength);
    final previewBytes = await picked.readAsBytes();

    if (!mounted) return false;
    setState(() {
      _files.add(
        AttachedFile(
          name: name,
          sizeLabel: sizeLabel,
          path: picked.path,
          bytes: previewBytes,
        ),
      );
    });

    return true;
  }

  String _basename(String p) {
    final parts = p.split(RegExp(r'[\\/]+'));
    return parts.isEmpty ? p : parts.last;
  }

  String _formatBytes(int bytes) {
    if (bytes <= 0) return "0 B";
    const units = ["B", "KB", "MB", "GB"];
    double size = bytes.toDouble();
    int unit = 0;
    while (size >= 1024 && unit < units.length - 1) {
      size /= 1024;
      unit += 1;
    }
    final label = unit == 0 ? size.toStringAsFixed(0) : size.toStringAsFixed(1);
    return "$label ${units[unit]}";
  }

  void _removeFile(int i) {
    setState(() => _files.removeAt(i));
  }

  // -----------------------
  //  BUDGET actions
  // -----------------------
  void _pickQuickBudget(String v) {
    setState(() {
      _budgetError = false;
      _budgetQuick = v.replaceAll("+", "").trim();
      _budgetDropdown = null;
    });
  }

  // -----------------------
  //  APP BAR (1/4 progress)
  // -----------------------
  PreferredSizeWidget _buildAppBar() {
    final progress = (_step + 1) / 4.0;

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      toolbarHeight: 84.h, // ✅ match your big header height
      centerTitle: true,

      leadingWidth: 24.w + 40.w + 12.w, // left padding + button + small space
      leading: Padding(
        padding: EdgeInsets.only(left: 24.w),
        child: Align(
          alignment: Alignment.centerLeft, // ✅ vertically centered
          child: InkWell(
            onTap: _back,
            borderRadius: BorderRadius.circular(8.r),
            child: Container(
              width: 40.w,
              height: 40.w,
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
              ),
              child: Center(
                child: Icon(
                  Icons.arrow_back_ios_new_rounded, // ✅ thin like figma
                  size: 18.sp,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ),

      title: Padding(
        padding: EdgeInsets.only(top: 2.h),
        child: Text(
          "Post a job",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: "SF Pro Display", // ✅ if added in pubspec
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            height: 1.0,
            letterSpacing: 0,
            color: const Color(0xFF000000),
          ),
        ),
      ),

      actions: [
        Padding(
          padding: EdgeInsets.only(right: 16.w),
          child: Center(
            // ✅ actions vertically centered
            child: Row(
              children: [
                Container(
                  width: 54.w,
                  height: 6.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEDEDED),
                    borderRadius: BorderRadius.circular(99.r),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: 54.w * progress,
                      height: 6.h,
                      decoration: BoxDecoration(
                        color: kLime,
                        borderRadius: BorderRadius.circular(99.r),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  "${_step + 1}/4",
                  style: TextStyle(
                    fontFamily: "SF Pro Display",
                    fontSize: 18.sp, // ✅ figma side number looks big
                    fontWeight: FontWeight.w500,
                    height: 1.0,
                    color: const Color(0xFF9B9B9B),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // -----------------------
  //  BOTTOM BUTTON (black bar)
  // -----------------------
  Widget _bottomButton() {
    final isLast = _step == 3;
    final label = isLast ? "Submit & review job post  →" : "Next Step  →";

    return AnimatedPadding(
      duration: const Duration(milliseconds: 200),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SafeArea(
        top: false,
        child: Container(
          height: 54.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(0),
          ),
          child: InkWell(
            onTap: _next,
            child: Center(
              child: Text(
                label,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // -----------------------
  //  PAGE: Step 1
  // -----------------------
  Widget _step1() {
    final query = _searchCtrl.text.trim().toLowerCase();
    final results = query.isEmpty
        ? <CategoryItem>[]
        : allCategories
              .where((c) => c.name.toLowerCase().contains(query))
              .toList();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: ListView(
        children: [
          SizedBox(height: 10.h),
          _fieldLabel("Job title *"),
          SizedBox(height: 8.h),
          _textField(controller: _titleCtrl, hint: "Write a title"),
          SizedBox(height: 16.h),
          _fieldLabel("Search skills or add your won *"),
          SizedBox(height: 8.h),
          _textField(
            controller: _searchCtrl,
            hint: "Search category / type",
            suffix: Icon(Icons.search_rounded, color: kMuted, size: 18.sp),
          ),

          // Search results (like screenshot: list with Add/Added)
          if (query.isNotEmpty) ...[
            SizedBox(height: 10.h),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(color: kBorder),
              ),
              child: Column(
                children: results.map((c) {
                  final added = _selectedSearchCategoryIds.contains(c.id);
                  return InkWell(
                    onTap: () => _toggleSearchCategory(c),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 12.h,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              c.name,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                                color: kText,
                              ),
                            ),
                          ),
                          Text(
                            added ? "Added" : "Add",
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w700,
                              color: added ? kLime : kMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],

          SizedBox(height: 14.h),
          Text(
            "MOST USED CATEGORIES",
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFFB0B0B0),
              letterSpacing: 0.6,
            ),
          ),
          SizedBox(height: 10.h),

          // Most used chips (with + like screenshot)
          Wrap(
            spacing: 10.w,
            runSpacing: 10.h,
            children: mostUsed.map((c) {
              final selected = _selectedMostUsedCategoryIds.contains(c.id);
              return _pillChip(
                text: c.name,
                selected: selected,
                trailing: selected ? null : const Icon(Icons.add, size: 16),
                onTap: () => _toggleMostUsedCategory(c),
              );
            }).toList(),
          ),

          SizedBox(height: 14.h),

          // Selected category chips (green bordered like screenshot)
          if (_selectedSearchCategoryIds.isNotEmpty) ...[
            Wrap(
              spacing: 10.w,
              runSpacing: 10.h,
              children: _selectedSearchCategories().map((c) {
                return _selectedChip(
                  text: c.name,
                  onRemove: () => _toggleSearchCategory(c),
                );
              }).toList(),
            ),
          ],

          SizedBox(height: 80.h),
        ],
      ),
    );
  }

  // -----------------------
  //  PAGE: Step 2
  // -----------------------
  Widget _step2() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: ListView(
        children: [
          SizedBox(height: 10.h),
          _fieldLabel("Project Size"),
          SizedBox(height: 10.h),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(color: kBorder),
            ),
            child: Column(
              children: [
                _projectSizeOption(
                  title: "Large",
                  subtitlePrefix: "Extended or multifaceted  ",
                  estimateText: "[estimate : 1+ day ]",
                  value: ProjectSize.large,
                ),
                _projectSizeOption(
                  title: "Medium",
                  subtitlePrefix: "Precisely defined projects ",
                  estimateText: "[estimate : 6 - 10 hours]",
                  value: ProjectSize.medium,
                ),
                _projectSizeOption(
                  title: "Small",
                  subtitlePrefix: "Simple and efficient tasks ",
                  estimateText: "[estimate : 4 - 6 hours]",
                  value: ProjectSize.small,
                ),
              ],
            ),
          ),
          SizedBox(height: 80.h),
        ],
      ),
    );
  }

  // -----------------------
  //  PAGE: Step 3
  // -----------------------
  Widget _step3() {
    const maxChars = 1000;
    final used = _descCtrl.text.length;
    final left = max(0, maxChars - used);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: ListView(
        children: [
          SizedBox(height: 10.h),
          _fieldLabel("Description"),
          SizedBox(height: 10.h),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: kBorder),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              children: [
                TextField(
                  controller: _descCtrl,
                  maxLines: 9,
                  decoration: InputDecoration(
                    hintText: "Write job description...",
                    hintStyle: GoogleFonts.plusJakartaSans(
                      fontSize: 13.sp,
                      color: const Color(0xFFB0B0B0),
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(14.w),
                  ),
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: kText,
                    height: 1.25,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 12.w, bottom: 10.h),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "$left characters left",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11.sp,
                        color: const Color(0xFFB0B0B0),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 18.h),
          _fieldLabel("Attach File"),
          SizedBox(height: 10.h),

          // dashed attach box (no plugin)
          DashedBorder(
            radius: 12.r,
            child: InkWell(
              onTap: _showAttachImageSheet,
              child: Container(
                padding: EdgeInsets.all(14.w),
                child: Row(
                  children: [
                    Container(
                      width: 36.w,
                      height: 36.w,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF7D7),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Icon(Icons.attach_file, size: 20.sp, color: kLime),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Attach file",
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w800,
                              color: kText,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            "png, jpeg • max 10mb",
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600,
                              color: kMuted,
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

          if (_files.isNotEmpty) ...[
            SizedBox(height: 14.h),
            Text(
              "Just attached files",
              style: GoogleFonts.plusJakartaSans(
                fontSize: 11.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFFB0B0B0),
              ),
            ),
            SizedBox(height: 10.h),
            ...List.generate(_files.length, (i) {
              final f = _files[i];
              return Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: Row(
                  children: [
                    Container(
                      width: 36.w,
                      height: 36.w,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F3F3),
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(color: kBorder),
                      ),
                      child: Icon(
                        f.isImage
                            ? Icons.image_rounded
                            : Icons.insert_drive_file_rounded,
                        size: 18.sp,
                        color: kMuted,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            f.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                              color: kText,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            f.sizeLabel,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600,
                              color: kMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10.w),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: kBorder),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 8.h,
                        ),
                      ),
                      onPressed: () => _removeFile(i),
                      child: Text(
                        "Delete",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          color: kText,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],

          SizedBox(height: 80.h),
        ],
      ),
    );
  }

  // -----------------------
  //  PAGE: Step 4
  // -----------------------
  Widget _step4() {
    final dropdownBorder = _budgetError ? Colors.red : kBorder;

    final quickCosts = [
      "SAR 400",
      "SAR 600",
      "SAR 800",
      "SAR 1000",
      "SAR 1200",
      "SAR 1400",
      "SAR 1600",
      "SAR 1800",
      "SAR 2000",
      "SAR 2200",
    ];

    final dropdownItems = [
      "\$600-\$1200",
      "\$1200-\$2000",
      "\$2000-\$3500",
      "\$3500+",
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: ListView(
        children: [
          SizedBox(height: 10.h),
          _fieldLabel("select a budget"),
          SizedBox(height: 10.h),

          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: dropdownBorder),
            ),
            child: DropdownButtonFormField<String>(
              value: _budgetDropdown,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 12.h,
                ),
                border: InputBorder.none,
                hintText: "Type budget",
                hintStyle: GoogleFonts.plusJakartaSans(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFB0B0B0),
                ),
              ),
              icon: Icon(Icons.keyboard_arrow_down_rounded, size: 22.sp),
              items: dropdownItems.map((v) {
                return DropdownMenuItem(
                  value: v,
                  child: Text(
                    v,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                      color: kText,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (v) {
                setState(() {
                  _budgetError = false;
                  _budgetDropdown = v;
                  _budgetQuick = null;
                });
              },
            ),
          ),

          if (_budgetError) ...[
            SizedBox(height: 8.h),
            Row(
              children: [
                Icon(
                  Icons.info_outline_rounded,
                  size: 16.sp,
                  color: Colors.red,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    "Your should put a price for move forward",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ],

          SizedBox(height: 16.h),
          Text(
            "SELECT COST",
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFFB0B0B0),
              letterSpacing: 0.6,
            ),
          ),
          SizedBox(height: 10.h),

          Wrap(
            spacing: 10.w,
            runSpacing: 10.h,
            children: quickCosts.map((c) {
              final selected = _budgetQuick?.replaceAll("+", "").trim() == c;
              final label = c;
              return InkWell(
                onTap: () => _pickQuickBudget(c),
                borderRadius: BorderRadius.circular(999.r),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: selected ? Colors.white : const Color(0xFFEDEDED),
                    borderRadius: BorderRadius.circular(999.r),
                    border: Border.all(
                      color: selected ? kLime : Colors.transparent,
                      width: selected ? 2 : 1,
                    ),
                    boxShadow: selected
                        ? [
                            BoxShadow(
                              color: kLime.withOpacity(0.20),
                              blurRadius: 18,
                              spreadRadius: 2,
                              offset: const Offset(0, 10),
                            ),
                          ]
                        : null,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        label,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          color: selected ? kLime : const Color(0xFF4E4E4E),
                        ),
                      ),
                      SizedBox(width: 6.w),
                      if (selected)
                        Icon(Icons.check_rounded, size: 18.sp, color: kLime)
                      else
                        Text(
                          "+",
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w900,
                            color: kText,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),

          SizedBox(height: 80.h),
        ],
      ),
    );
  }

  // -----------------------
  //  Common small widgets
  // -----------------------
  Widget _fieldLabel(String t) {
    return Text(
      t,
      style: GoogleFonts.plusJakartaSans(
        fontSize: 16.sp,
        fontWeight: FontWeight.w700,
        color: kText,
      ),
    );
  }

  Widget _textField({
    required TextEditingController controller,
    required String hint,
    Widget? suffix,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFFfffff),
        border: Border.all(color: kBorder),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.plusJakartaSans(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFFB0B0B0),
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 12.h,
          ),
          suffixIcon: suffix == null
              ? null
              : Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: suffix,
                ),
          suffixIconConstraints: BoxConstraints(
            minWidth: 28.w,
            minHeight: 28.w,
          ),
        ),
        style: GoogleFonts.plusJakartaSans(
          fontSize: 13.sp,
          fontWeight: FontWeight.w700,
          color: kText,
        ),
      ),
    );
  }

  Widget _pillChip({
    required String text,
    required bool selected,
    required VoidCallback onTap,
    Widget? trailing,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: selected ? Colors.black : kChipBg,
          borderRadius: BorderRadius.circular(999.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                color: selected ? Colors.white : const Color(0xFF4E4E4E),
              ),
            ),
            if (!selected && trailing != null) ...[
              SizedBox(width: 6.w),
              Icon(Icons.add, size: 16.sp, color: const Color(0xFF4E4E4E)),
            ],
          ],
        ),
      ),
    );
  }

  Widget _selectedChip({required String text, required VoidCallback onRemove}) {
    return InkWell(
      onTap: onRemove,
      borderRadius: BorderRadius.circular(999.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(999.r),
          border: Border.all(color: kLime, width: 2),
          boxShadow: [
            BoxShadow(
              color: kLime.withOpacity(0.22),
              blurRadius: 22,
              spreadRadius: 4,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                color: kLime,
              ),
            ),
            SizedBox(width: 10.w),
            Icon(Icons.check_rounded, size: 18.sp, color: kLime),
          ],
        ),
      ),
    );
  }

  Widget _projectSizeOption({
    required String title,
    required String subtitlePrefix,
    required String estimateText,
    required ProjectSize value,
  }) {
    return InkWell(
      onTap: () => setState(() => _projectSize = value),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 18.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Radio<ProjectSize>(
              value: value,
              groupValue: _projectSize,
              activeColor: kLime,
              fillColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) return kLime;
                return const Color(0xFFBDBDBD);
              }),
              onChanged: (v) => setState(() => _projectSize = v),
            ),
            SizedBox(width: 6.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w800,
                      color: kText,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  RichText(
                    text: TextSpan(
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: kMuted,
                        height: 1.3,
                      ),
                      children: [
                        TextSpan(text: subtitlePrefix),
                        TextSpan(
                          text: estimateText,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF3A3A3A),
                            height: 1.3,
                          ),
                        ),
                      ],
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: PageView(
        controller: _page,
        physics: const NeverScrollableScrollPhysics(),
        children: [_step1(), _step2(), _step3(), _step4()],
      ),
      bottomNavigationBar: _bottomButton(),
    );
  }
}

/// =======================
///  PREVIEW SCREEN
/// =======================
class JobPreviewScreen extends StatelessWidget {
  final JobDraft draft;
  final VoidCallback onEdit;
  final VoidCallback onPublish;

  const JobPreviewScreen({
    super.key,
    required this.draft,
    required this.onEdit,
    required this.onPublish,
  });

  static const Color kBorder = Color(0xFFE6E7EB);
  static const Color kMuted = Color(0xFF7A7A7A);
  static const Color kText = Color(0xFF111111);
  static const Color kLime = Color(0xFF82b500);

  ({String title, String subtitlePrefix, String estimateText}) _sizeMeta(
    ProjectSize s,
  ) {
    switch (s) {
      case ProjectSize.large:
        return (
          title: "Large",
          subtitlePrefix: "Extended or multifaceted tasks ",
          estimateText: "[estimate : 1+ day ]",
        );
      case ProjectSize.medium:
        return (
          title: "Medium",
          subtitlePrefix: "Precisely defined projects ",
          estimateText: "[estimate : 6 - 10 hours]",
        );
      case ProjectSize.small:
        return (
          title: "Small",
          subtitlePrefix: "Simple and efficient tasks ",
          estimateText: "[estimate : 4 - 6 hours]",
        );
    }
  }

  Widget _sectionLabel(String t) {
    return Text(
      t,
      style: GoogleFonts.plusJakartaSans(
        fontSize: 12.sp,
        fontWeight: FontWeight.w700,
        color: kMuted,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = _sizeMeta(draft.size);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 18.sp,
            color: kText,
          ),
        ),
        centerTitle: true,
        title: Text(
          "Job Preview",
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            color: kText,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                InkWell(
                  onTap: () => _openMenu(context),
                  borderRadius: BorderRadius.circular(8.r),
                  child: Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color: const Color(0xFFE0E0E0),
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.more_vert_rounded,
                        size: 22.sp,
                        color: kText,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: ListView(
          children: [
            SizedBox(height: 12.h),
            _sectionLabel("Job title"),
            SizedBox(height: 6.h),
            Text(
              draft.title,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 16.sp,
                fontWeight: FontWeight.w800,
                color: kText,
                height: 1.25,
              ),
            ),
            SizedBox(height: 14.h),
            Divider(color: kBorder, height: 1.h),
            SizedBox(height: 14.h),
            _sectionLabel("Added categories"),
            SizedBox(height: 10.h),
            Wrap(
              spacing: 10.w,
              runSpacing: 10.h,
              children: draft.categories.map((c) {
                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(999.r),
                    border: Border.all(color: kLime, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: kLime.withOpacity(0.10),
                        blurRadius: 10,
                        spreadRadius: 1,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Text(
                    c.name,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      color: kLime,
                    ),
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: 14.h),
            Divider(color: kBorder, height: 1.h),
            SizedBox(height: 14.h),
            _sectionLabel("Project size"),
            SizedBox(height: 8.h),
            Text(
              size.title,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13.sp,
                fontWeight: FontWeight.w800,
                color: kText,
              ),
            ),
            SizedBox(height: 4.h),
            RichText(
              text: TextSpan(
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: kMuted,
                  height: 1.35,
                ),
                children: [
                  TextSpan(text: size.subtitlePrefix),
                  TextSpan(
                    text: size.estimateText,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF3A3A3A),
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 14.h),
            Divider(color: kBorder, height: 1.h),
            SizedBox(height: 14.h),
            _sectionLabel("Description"),
            SizedBox(height: 8.h),
            Text(
              draft.description.isEmpty ? "-" : draft.description,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: kText,
                height: 1.35,
              ),
            ),

            SizedBox(height: 14.h),
            Divider(color: kBorder, height: 1.h),
            SizedBox(height: 14.h),
            _sectionLabel("Attached files"),
            SizedBox(height: 10.h),
            if (draft.files.isEmpty)
              Text(
                "-",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: kText,
                ),
              )
            else
              ...draft.files.map((f) {
                final lower = f.name.toLowerCase();
                final isPdf = lower.endsWith(".pdf");

                final thumb = (f.isImage && f.bytes != null)
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10.r),
                        child: Image.memory(
                          f.bytes!,
                          width: 44.w,
                          height: 44.w,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Container(
                        width: 44.w,
                        height: 44.w,
                        decoration: BoxDecoration(
                          color: isPdf
                              ? const Color(0xFFF8EDE4)
                              : const Color(0xFFF3F3F3),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Icon(
                          isPdf
                              ? Icons.picture_as_pdf_rounded
                              : Icons.insert_drive_file_rounded,
                          size: 20.sp,
                          color: isPdf ? const Color(0xFFB35A1D) : kMuted,
                        ),
                      );

                return Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      thumb,
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              f.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w800,
                                color: kText,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              f.sizeLabel,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w600,
                                color: kMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),

            SizedBox(height: 2.h),
            Divider(color: kBorder, height: 1.h),
            SizedBox(height: 14.h),
            _sectionLabel("Project cost"),
            SizedBox(height: 10.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F3F3),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                draft.budget,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w800,
                  color: kText,
                ),
              ),
            ),

            SizedBox(height: 26.h),
            SafeArea(
              top: false,
              child: Container(
                height: 54.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF0A0D2C),
                  borderRadius: BorderRadius.circular(999.r),
                ),
                child: InkWell(
                  onTap: onPublish,
                  child: Center(
                    child: Text(
                      "Publish",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 18.h),
          ],
        ),
      ),
    );
  }

  void _openMenu(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (sheetCtx) {
        return CupertinoActionSheet(
          title: Text(
            "A Short Title is Best",
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF8E8E93),
            ),
          ),
          message: Text(
            "A message should be a short, complete sentence.",
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF8E8E93),
            ),
          ),
          actions: [
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.of(sheetCtx).pop();
                onEdit();
              },
              child: Text(
                "Edit Job Post",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF007AFF),
                ),
              ),
            ),
            CupertinoActionSheetAction(
              onPressed: () => Navigator.of(sheetCtx).pop(),
              child: Text(
                "Save as a draft",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF007AFF),
                ),
              ),
            ),
            CupertinoActionSheetAction(
              isDestructiveAction: true,
              onPressed: () => Navigator.of(sheetCtx).pop(),
              child: Text(
                "Delete the Job Post",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () => Navigator.of(sheetCtx).pop(),
            child: Text(
              "Cancel",
              style: GoogleFonts.plusJakartaSans(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF007AFF),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// =======================
///  SUCCESS SCREEN
/// =======================
class JobPostedSuccessScreen extends StatelessWidget {
  const JobPostedSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
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
                "Job posted successfully.",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              Container(
                height: 54.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF0A0D2C),
                  borderRadius: BorderRadius.circular(999.r),
                ),
                child: InkWell(
                  onTap: () => Navigator.popUntil(context, (r) => r.isFirst),
                  child: Center(
                    child: Text(
                      "Go to Discovery Page",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 18.h),
            ],
          ),
        ),
      ),
    );
  }
}

/// =======================
///  DASHED BORDER (no plugin)
/// =======================
class DashedBorder extends StatelessWidget {
  final Widget child;
  final double radius;
  const DashedBorder({super.key, required this.child, required this.radius});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedPainter(radius: radius),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: child,
      ),
    );
  }
}

class _DashedPainter extends CustomPainter {
  final double radius;
  _DashedPainter({required this.radius});

  @override
  void paint(Canvas canvas, Size size) {
    const dashWidth = 8.0;
    const dashSpace = 6.0;

    final paint = Paint()
      ..color = const Color(0xFFE6E7EB)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(radius),
    );

    final path = Path()..addRRect(rrect);
    final metrics = path.computeMetrics().first;

    double distance = 0.0;
    while (distance < metrics.length) {
      final next = distance + dashWidth;
      final extract = metrics.extractPath(distance, next);
      canvas.drawPath(extract, paint);
      distance = next + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant _DashedPainter oldDelegate) {
    return oldDelegate.radius != radius;
  }
}

class StepItem {
  final String id;
  final String title;
  final IconData icon;
  final String number; // 1,2,3 bubble
  StepItem({
    required this.id,
    required this.title,
    required this.icon,
    required this.number,
  });
}

class CategoryItem {
  final String id;
  final String name;
  CategoryItem(this.id, this.name);
}

enum ProjectSize { large, medium, small }

class AttachedFile {
  final String name;
  final String sizeLabel; // "1.2 MB"
  final String path;
  final Uint8List? bytes;

  AttachedFile({
    required this.name,
    required this.sizeLabel,
    required this.path,
    this.bytes,
  });

  bool get isImage {
    final n = name.toLowerCase();
    return n.endsWith(".png") ||
        n.endsWith(".jpg") ||
        n.endsWith(".jpeg") ||
        n.endsWith(".webp") ||
        n.endsWith(".gif");
  }
}

class JobDraft {
  final String title;
  final List<CategoryItem> categories;
  final ProjectSize size;
  final String description;
  final List<AttachedFile> files;
  final String budget; // "SAR 600" or "$600-$1200"
  JobDraft({
    required this.title,
    required this.categories,
    required this.size,
    required this.description,
    required this.files,
    required this.budget,
  });
}
