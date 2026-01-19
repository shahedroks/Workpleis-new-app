import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/features/service/service_jobs/quote_submitted_success_screen.dart';

/// Flutter conversion of `lib/features/service/screen/react.tsx`.
///
/// Screen: "Submit a quote" (proposal form)
/// - Description (max 500 chars + remaining counter)
/// - Attach file (pick files + list with delete)
/// - Timeline selection chips
/// - Project cost input
/// - Bottom "Submit Proposal" button
class SubmitQuoteScreen extends StatefulWidget {
  const SubmitQuoteScreen({super.key});

  static const String routeName = '/submit-quote';

  @override
  State<SubmitQuoteScreen> createState() => _SubmitQuoteScreenState();
}

class _SubmitQuoteScreenState extends State<SubmitQuoteScreen> {
  static const int _maxChars = 500;
  static const int _maxFileBytes = 10 * 1024 * 1024; // 10 MB

  final TextEditingController _descriptionCtrl = TextEditingController(
    text:
        'I am seeking a skilled and reliable service provider to handle the assembly of furniture in my shop. \n\n'
        'The ideal candidate will have experience with assembling various types of furniture, including shelving units, display cases, and seating. ',
  );
  final TextEditingController _projectCostCtrl = TextEditingController(
    text: 'SAR 1,500',
  );

  int _selectedTimelineId = 4; // 1-2 Days

  int _nextFileId = 3;
  final List<_AttachedFile> _attachedFiles = [
    const _AttachedFile(
      id: 1,
      name: 'Attachment file 2024.jpeg',
      sizeBytes: 1258291, // ~1.2MB
      extension: 'jpeg',
      bytes: null,
    ),
    const _AttachedFile(
      id: 2,
      name: 'Requirement of project.pdf',
      sizeBytes: 3250586, // ~3.1MB
      extension: 'pdf',
      bytes: null,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _descriptionCtrl.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _descriptionCtrl.dispose();
    _projectCostCtrl.dispose();
    super.dispose();
  }

  int get _charsLeft => _maxChars - _descriptionCtrl.text.length;

  Future<void> _pickAttachments() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      withData: true,
      type: FileType.custom,
      allowedExtensions: const ['pdf', 'png', 'jpg', 'jpeg'],
    );
    if (result == null || result.files.isEmpty) return;

    final incoming = result.files;
    final List<PlatformFile> valid = [];

    for (final f in incoming) {
      final ext = (f.extension ?? '').toLowerCase();
      final isAllowed = ['pdf', 'png', 'jpg', 'jpeg'].contains(ext);
      final isSizeOk = f.size <= _maxFileBytes;
      if (isAllowed && isSizeOk) valid.add(f);
    }

    if (!mounted) return;

    if (valid.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Only pdf/png/jpg/jpeg files up to 10MB are allowed'),
        ),
      );
      return;
    }

    final existingKeys = _attachedFiles
        .map((e) => '${e.name}_${e.sizeBytes}')
        .toSet();

    setState(() {
      for (final f in valid) {
        final key = '${f.name}_${f.size}';
        if (existingKeys.contains(key)) continue;

        _attachedFiles.add(
          _AttachedFile(
            id: _nextFileId++,
            name: f.name,
            sizeBytes: f.size,
            extension: f.extension?.toLowerCase(),
            bytes: f.bytes,
          ),
        );
        existingKeys.add(key);
      }
    });
  }

  void _removeFile(int id) {
    setState(() => _attachedFiles.removeWhere((f) => f.id == id));
  }

  void _submit() {
    final timeline = timelineOptions
        .firstWhere((t) => t.id == _selectedTimelineId)
        .label;

    debugPrint(
      'Submitting proposal: {'
      'description: ${_descriptionCtrl.text}, '
      'timeline: $timeline, '
      'cost: ${_projectCostCtrl.text}, '
      'files: ${_attachedFiles.map((e) => e.name).toList()}'
      '}',
    );

    // Show success screen (matches the provided design image).
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const QuoteSubmittedSuccessScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(24.w, 8.h, 24.w, 0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: _HeaderIconButton(
                      icon: Icons.arrow_back,
                      onTap: () => Navigator.maybePop(context),
                    ),
                  ),
                  Text(
                    'Submit a quote',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: AllColor.black,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(24.w, 18.h, 24.w, 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _SectionTitle(title: 'Description'),
                    SizedBox(height: 8.h),
                    _DescriptionBox(
                      controller: _descriptionCtrl,
                      maxChars: _maxChars,
                      onClear: () => _descriptionCtrl.clear(),
                    ),
                    SizedBox(height: 16.h),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '$_charsLeft characters left',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF7C7C7C),
                          fontFamily: 'SF Pro Display',
                        ),
                      ),
                    ),
                    SizedBox(height: 26.h),
                    _SectionTitle(title: 'Attach File'),
                    SizedBox(height: 18.h),
                    _AttachUploadArea(onTap: _pickAttachments),
                    SizedBox(height: 18.h),
                    Text(
                      'Just attached files',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(
                          0x8C808080,
                        ), // rgba(128,128,128,0.55)
                        fontFamily: 'SF Pro Display',
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Column(
                      children: _attachedFiles.map((file) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 16.h),
                          child: _AttachedFileRow(
                            file: file,
                            onDelete: () => _removeFile(file.id),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'Estimate timeline task done?*',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: AllColor.black,
                        fontFamily: 'Inter',
                      ),
                    ),
                    SizedBox(height: 8.h),
                    _SelectionField(
                      value: timelineOptions
                          .firstWhere((t) => t.id == _selectedTimelineId)
                          .label,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'SELECT TIME',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0x61000000), // rgba(0,0,0,0.38)
                        fontFamily: 'Inter',
                        letterSpacing: 0.4,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: timelineOptions.map((opt) {
                        final isSelected = opt.id == _selectedTimelineId;
                        return _TimelineChip(
                          label: opt.label,
                          selected: isSelected,
                          onTap: () =>
                              setState(() => _selectedTimelineId = opt.id),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 28.h),
                    Text(
                      'Project cost add your won *',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: AllColor.black,
                        fontFamily: 'SF Pro Display',
                      ),
                    ),
                    SizedBox(height: 8.h),
                    _CostField(controller: _projectCostCtrl),
                    SizedBox(height: 120.h), // space for bottom button
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AllColor.white,
          boxShadow: [
            BoxShadow(
              color: AllColor.black.withOpacity(0.08),
              blurRadius: 12.4,
              offset: const Offset(4, 0),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 12.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 60.h,
                  child: ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AllColor.black50,
                      foregroundColor: const Color(0xFFF5F5F5),
                      elevation: 0,
                      shape: const StadiumBorder(),
                    ),
                    child: Text(
                      'Submit Proposal',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Container(
                  height: 5.h,
                  width: 134.w,
                  decoration: BoxDecoration(
                    color: AllColor.black50,
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: AllColor.black,
        fontFamily: 'SF Pro Display',
      ),
    );
  }
}

class _DescriptionBox extends StatelessWidget {
  const _DescriptionBox({
    required this.controller,
    required this.maxChars,
    required this.onClear,
  });

  final TextEditingController controller;
  final int maxChars;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 226.h,
          decoration: BoxDecoration(
            color: AllColor.white,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: const Color(0xFFEAEAEA), width: 1.5),
          ),
          padding: EdgeInsets.all(24.w),
          child: TextField(
            controller: controller,
            maxLines: null,
            expands: true,
            maxLength: maxChars,
            decoration: InputDecoration(
              border: InputBorder.none,
              counterText: '',
              hintText: '',
            ),
            style: TextStyle(
              fontSize: 16.sp,
              height: 22 / 16,
              color: AllColor.black,
              fontFamily: 'Inter',
            ),
          ),
        ),
        Positioned(
          right: 16.w,
          top: 16.h,
          child: InkWell(
            onTap: onClear,
            borderRadius: BorderRadius.circular(999.r),
            child: Padding(
              padding: EdgeInsets.all(6.w),
              child: Icon(
                Icons.close,
                size: 14.sp,
                color: AllColor.black.withOpacity(0.3),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _AttachUploadArea extends StatelessWidget {
  const _AttachUploadArea({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: _DashedRoundedBorder(
        radius: 8.r,
        dashWidth: 6.w,
        dashGap: 4.w,
        strokeWidth: 1.2,
        color: const Color(0xFF827373),
        child: Container(
          height: 73.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AllColor.white,
            borderRadius: BorderRadius.circular(8.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            children: [
              Container(
                height: 31.w,
                width: 31.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF82B600),
                  borderRadius: BorderRadius.circular(9.r),
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.attach_file,
                  color: AllColor.white,
                  size: 19.sp,
                ),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Attach file',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF111111),
                        fontFamily: 'Inter',
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'pdf, png, jpeg and max 10mb',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(
                          0x8C808080,
                        ), // rgba(128,128,128,0.55)
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AttachedFileRow extends StatelessWidget {
  const _AttachedFileRow({required this.file, required this.onDelete});

  final _AttachedFile file;
  final VoidCallback onDelete;

  static const _imageExts = {'png', 'jpg', 'jpeg', 'webp', 'gif'};

  @override
  Widget build(BuildContext context) {
    final ext = (file.extension ?? '').toLowerCase();
    final isImage = _imageExts.contains(ext);

    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4.r),
                child: Container(
                  width: 41.w,
                  height: 39.h,
                  color: const Color(0xFFF0F0F0),
                  alignment: Alignment.center,
                  child: isImage && file.bytes != null
                      ? Image.memory(
                          file.bytes!,
                          width: 41.w,
                          height: 39.h,
                          fit: BoxFit.cover,
                        )
                      : Icon(
                          ext == 'pdf'
                              ? Icons.picture_as_pdf
                              : (isImage
                                    ? Icons.image
                                    : Icons.insert_drive_file),
                          size: 22.sp,
                          color: const Color(0xFF777777),
                        ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      file.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF111111),
                        fontFamily: 'SF Pro Display',
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      _formatBytes(file.sizeBytes),
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0x4D000000), // rgba(0,0,0,0.3)
                        fontFamily: 'SF Pro Display',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 12.w),
        InkWell(
          onTap: onDelete,
          borderRadius: BorderRadius.circular(8.r),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 6.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: const Color(0x8C808080), // rgba(128,128,128,0.55)
              ),
            ),
            child: Text(
              'Delete',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AllColor.black,
                fontFamily: 'SF Pro Display',
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SelectionField extends StatelessWidget {
  const _SelectionField({required this.value});

  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.h,
      width: double.infinity,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: AllColor.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xFFEAEAEA), width: 1.5),
      ),
      child: Text(
        value,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: AllColor.black,
          fontFamily: 'Inter',
        ),
      ),
    );
  }
}

class _TimelineChip extends StatelessWidget {
  const _TimelineChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: selected ? AllColor.white : const Color(0xFFE3E3E3),
          borderRadius: BorderRadius.circular(16.r),
          border: selected
              ? Border.all(color: const Color(0xFF82B600), width: 1)
              : null,
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: const Color(0xFF4EA52F).withOpacity(0.18),
                    blurRadius: 4,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                fontFamily: 'Inter',
                color: selected
                    ? const Color(0xFF82B600)
                    : const Color(0xB3000000), // rgba(0,0,0,0.7)
              ),
            ),
            SizedBox(width: 4.w),
            Icon(
              selected ? Icons.check_circle : Icons.radio_button_unchecked,
              size: 14.sp,
              color: selected ? const Color(0xFF82B600) : AllColor.black,
            ),
          ],
        ),
      ),
    );
  }
}

class _CostField extends StatelessWidget {
  const _CostField({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.h,
      width: double.infinity,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: AllColor.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xFFEAEAEA), width: 1.5),
      ),
      child: TextField(
        controller: controller,
        decoration: const InputDecoration(border: InputBorder.none),
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: AllColor.black,
          fontFamily: 'Inter',
        ),
      ),
    );
  }
}

class _HeaderIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _HeaderIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        height: 40.w,
        width: 40.w,
        decoration: BoxDecoration(
          color: AllColor.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
        ),
        alignment: Alignment.center,
        child: Icon(icon, size: 24.sp, color: const Color(0xFF111111)),
      ),
    );
  }
}

/// Timeline options (same labels as the React source).
const List<_TimelineOption> timelineOptions = [
  _TimelineOption(1, '1-2 hr'),
  _TimelineOption(2, '3-5 hr'),
  _TimelineOption(3, '6-10 hr'),
  _TimelineOption(4, '1-2 Days'),
  _TimelineOption(5, '3-5 Days'),
  _TimelineOption(6, '1-2 Weeks'),
  _TimelineOption(7, '1 Month'),
  _TimelineOption(8, '2 Month'),
  _TimelineOption(9, '3 Month'),
];

class _TimelineOption {
  final int id;
  final String label;

  const _TimelineOption(this.id, this.label);
}

class _AttachedFile {
  final int id;
  final String name;
  final int sizeBytes;
  final String? extension;
  final Uint8List? bytes;

  const _AttachedFile({
    required this.id,
    required this.name,
    required this.sizeBytes,
    required this.extension,
    required this.bytes,
  });
}

String _formatBytes(int bytes) {
  if (bytes <= 0) return '0 B';
  const kb = 1024;
  const mb = 1024 * 1024;
  const gb = 1024 * 1024 * 1024;
  if (bytes >= gb) return '${(bytes / gb).toStringAsFixed(1)} GB';
  if (bytes >= mb) return '${(bytes / mb).toStringAsFixed(1)} MB';
  if (bytes >= kb) return '${(bytes / kb).toStringAsFixed(1)} KB';
  return '$bytes B';
}

/// Rounded dashed border (no extra package)
class _DashedRoundedBorder extends StatelessWidget {
  const _DashedRoundedBorder({
    required this.child,
    required this.radius,
    required this.color,
    this.strokeWidth = 1,
    this.dashWidth = 6,
    this.dashGap = 4,
  });

  final Widget child;
  final double radius;
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashGap;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedRRectPainter(
        radius: radius,
        color: color,
        strokeWidth: strokeWidth,
        dashWidth: dashWidth,
        dashGap: dashGap,
      ),
      child: child,
    );
  }
}

class _DashedRRectPainter extends CustomPainter {
  _DashedRRectPainter({
    required this.radius,
    required this.color,
    required this.strokeWidth,
    required this.dashWidth,
    required this.dashGap,
  });

  final double radius;
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashGap;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(radius),
    );

    final path = Path()..addRRect(rrect);

    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        final extractPath = metric.extractPath(distance, distance + dashWidth);
        canvas.drawPath(extractPath, paint);
        distance += dashWidth + dashGap;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedRRectPainter oldDelegate) {
    return oldDelegate.radius != radius ||
        oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.dashWidth != dashWidth ||
        oldDelegate.dashGap != dashGap;
  }
}
