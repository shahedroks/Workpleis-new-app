import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/features/auth/screens/account_successful.dart';

import '../../../core/constants/color_control/all_color.dart';
import '../../../core/widget/global_get_started_button.dart';

class VeryfiyYourBusiness extends StatefulWidget {
  const VeryfiyYourBusiness({super.key});

  static const routeName = '/verify-your-business';

  @override
  State<VeryfiyYourBusiness> createState() => _VeryfiyYourBusinessState();
}

class _VeryfiyYourBusinessState extends State<VeryfiyYourBusiness> {
  final List<PlatformFile> _pickedFiles = [];

  Future<void> _pickBusinessDocs() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      withData: true,
      type: FileType.custom,
      allowedExtensions: const ['png', 'jpg', 'jpeg'],
    );

    if (result == null || result.files.isEmpty) return;

    final incoming = result.files;

    final valid = <PlatformFile>[];
    for (final f in incoming) {
      final ext = (f.extension ?? '').toLowerCase();
      if (['png', 'jpg', 'jpeg'].contains(ext)) valid.add(f);
    }

    if (valid.isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Only PNG or JPG files are allowed')),
      );
      return;
    }

    final existingKeys = _pickedFiles.map((e) => '${e.name}_${e.size}').toSet();
    for (final f in valid) {
      final key = '${f.name}_${f.size}';
      if (!existingKeys.contains(key)) {
        _pickedFiles.add(f);
        existingKeys.add(key);
      }
    }

    setState(() {});
  }

  void _removeFile(int index) {
    setState(() => _pickedFiles.removeAt(index));
  }

  void _onContinue() {
    if (_pickedFiles.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please upload at least 1 PNG/JPG document'),
        ),
      );
      return;
    }
    context.push(AccountSuccessful.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.w),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),

                // Back button
                InkWell(
                  onTap: () => context.pop(),
                  borderRadius: BorderRadius.circular(14.r),
                  child: Container(
                    height: 40.w,
                    width: 40.w,
                    decoration: BoxDecoration(
                      color: AllColor.grey70,
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.arrow_back,
                        size: 24.sp,
                        color: const Color(0xff111111),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20.h),

                Text(
                  'Verify Your Business',
                  style: TextStyle(
                    fontFamily: 'sf_pro',
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF02040B),
                  ),
                ),

                SizedBox(height: 20.h),

                Text(
                  'Upload a clear photo of any of your business\n'
                      'documents listed below.',
                  style: TextStyle(
                    fontFamily: 'sf_pro',
                    fontSize: 18.sp,
                    height: 1,
                    fontWeight: FontWeight.w400,
                    color: AllColor.black,
                  ),
                ),

                SizedBox(height: 40.h),

                _UploadCard(
                  onPick: _pickBusinessDocs,
                  pickedFiles: _pickedFiles,
                  onRemove: _removeFile,
                ),

                SizedBox(height: 20.h),

                _Bullet(text: 'Certificate of Assumed Name; Business License'),
                _Bullet(text: 'Sales/Use Tax License'),
                _Bullet(text: 'Registration of Trade Name'),
                _Bullet(
                  text: 'EIN Documentation (IRS-Issued SS4 Confirmation Letter)',
                ),

                // ✅ bottom button overlap avoid (since button fixed in bottomNavigationBar)
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(22.w, 0, 22.w, 24.h),
        child: SizedBox(
          width: double.infinity,
          height: 56.h,
          child: CustomButton(
            text: "Continue",
            onTap: _onContinue,
            icon: Icons.arrow_forward,
          ),
        ),
      ),
    );
  }
}

class _UploadCard extends StatelessWidget {
  const _UploadCard({
    required this.onPick,
    required this.pickedFiles,
    required this.onRemove,
  });

  final VoidCallback onPick;
  final List<PlatformFile> pickedFiles;
  final void Function(int index) onRemove;

  @override
  Widget build(BuildContext context) {
    return _DashedRoundedBorder(
      radius: 18.r,
      dashWidth: 6.w,
      dashGap: 5.w,
      strokeWidth: 1.2,
      color: const Color(0xFFE5E7EB),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: onPick,
              borderRadius: BorderRadius.circular(999.r),
              child: Container(
                width: 56.w,
                height: 56.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AllColor.white,
                  border: Border.all(color: const Color(0xFFEAEDF1)),
                ),
                child: Center(
                  child: Icon(
                    Icons.file_upload_outlined,
                    size: 24.sp,
                    color: const Color(0xFF9D47FF),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              'Choose files or drag and drop',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'sf_pro',
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF161618),
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'Only jpg or png file type accepted',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'sf_pro',
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF747476),
              ),
            ),
            SizedBox(height: 12.h),
            SizedBox(
              height: 36.h,
              child: OutlinedButton(
                onPressed: onPick,
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF111111),
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: Color(0xFFEAEDF1), width: 1),
                  padding: EdgeInsets.symmetric(horizontal: 18.w),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                child: Text(
                  'Browse File',
                  style: TextStyle(
                    fontFamily: 'sf_pro',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF5D5D5F),
                  ),
                ),
              ),
            ),

            if (pickedFiles.isNotEmpty) ...[
              SizedBox(height: 12.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '${pickedFiles.length} file(s) selected',
                  style: TextStyle(
                    fontFamily: 'sf_pro',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF161618),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              ListView.separated(
                itemCount: pickedFiles.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (_, __) => SizedBox(height: 8.h),
                itemBuilder: (context, index) {
                  final f = pickedFiles[index];
                  final Uint8List? bytes = f.bytes;

                  return Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF7F7F7),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: const Color(0xFFEAEDF1)),
                    ),
                    child: Row(
                      children: [
                        if (bytes != null)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.r),
                            child: Image.memory(
                              bytes,
                              width: 34.w,
                              height: 34.w,
                              fit: BoxFit.cover,
                            ),
                          )
                        else
                          Container(
                            width: 34.w,
                            height: 34.w,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.r),
                              border: Border.all(color: const Color(0xFFEAEDF1)),
                            ),
                            child: Icon(
                              Icons.image_outlined,
                              size: 18.sp,
                              color: const Color(0xFF747476),
                            ),
                          ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Text(
                            f.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: 'sf_pro',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF161618),
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        InkWell(
                          onTap: () => onRemove(index),
                          borderRadius: BorderRadius.circular(999.r),
                          child: Padding(
                            padding: EdgeInsets.all(6.w),
                            child: Icon(
                              Icons.close,
                              size: 18.sp,
                              color: const Color(0xFF747476),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  const _Bullet({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 6.h),
            child: Container(
              width: 4.w,
              height: 4.w,
              decoration: const BoxDecoration(
                color: AllColor.black,
                shape: BoxShape.circle,
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontFamily: 'sf_pro',
                fontSize: 12.sp,
                height: 1.4,
                fontWeight: FontWeight.w300,
                color: AllColor.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
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
