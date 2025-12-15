import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/features/auth/screens/confrim_document_type_screen.dart';

import '../../../core/widget/global_get_started_button.dart';

class SelectDocumentScreen extends StatefulWidget {
  const SelectDocumentScreen({super.key});
  static const String routeName = '/selectDocumentScreen';

  @override
  State<SelectDocumentScreen> createState() => _SelectDocumentScreenState();
}

enum DocumentType { idCard, passport, driversLicense }

class _SelectDocumentScreenState extends State<SelectDocumentScreen> {
  DocumentType _selected = DocumentType.idCard;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AllColor.white,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 16.h),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 4.h),

              /// Back button
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

              SizedBox(height: 24.h),

              /// Title
              Text(
                'Select a document',
                style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w500,
                  color: AllColor.black,
                  fontFamily: 'sf_pro',
                ),
              ),

              SizedBox(height: 8.h),

              /// Subtitle
              Text(
                "Which document type would you want to identity",
                style: TextStyle(
                  fontSize: 18.sp,
                  height: 1.5,
                  color: AllColor.black.withOpacity(0.6),
                  fontFamily: 'sf_pro',
                  fontWeight: FontWeight.w400,
                ),
              ),

              SizedBox(height: 24.h),

              /// Identity card
              _DocumentOptionCard(
                label: 'Identity Card',
                iconPath: 'assets/images/id_card.png',
                isSelected: _selected == DocumentType.idCard,
                onTap: () => setState(() => _selected = DocumentType.idCard),
              ),
              SizedBox(height: 12.h),
              _DocumentOptionCard(
                label: 'Passport',
                iconPath: 'assets/images/passport.png',
                isSelected: _selected == DocumentType.passport,
                onTap: () => setState(() => _selected = DocumentType.passport),
              ),
              SizedBox(height: 12.h),
              _DocumentOptionCard(
                label: 'Driver’s License',
                iconPath: 'assets/images/driver_Id.png',
                isSelected: _selected == DocumentType.driversLicense,
                onTap: () => setState(() => _selected = DocumentType.driversLicense),
              ),



              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),

      /// Bottom button
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(22.w, 0, 22.w, 24.h),
        child: SizedBox(
          width: double.infinity,
          height: 56.h,
          child: CustomButton(
            text: "Continue",
            icon: Icons.arrow_forward,
            onTap: () {
             context.push(ConfirmDocumentTypeScreen.routeName);
            },
          ),
        ),
      ),
    );
  }
}

// ───────────────────────────────────────────────────────────
// Single option card
class _DocumentOptionCard extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final String iconPath; // 🔹 image path

  const _DocumentOptionCard({
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    const primaryText = Color(0xFF111111);
    const cardBorderColor = Color(0xFFE5E5EA);
    const selectedBorderColor = Color(0xFF02021D);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: Colors.white,               // unselected bg
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(
            color: isSelected ? selectedBorderColor : cardBorderColor,
            width: isSelected ? 1.6 : 1,
          ),
        ),
        child: Row(
          children: [
            // 🔹 Left icon box (image)
            Container(
              height: 36.r,
              width: 36.r,
              decoration: BoxDecoration(
                color: const Color(0xFFF1F2F6),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(
                child: Image.asset(
                  iconPath,
                  width: 20.r,
                  height: 20.r,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(width: 14.w),

            // 🔹 Label
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w500,
                  color: primaryText,
                ),
              ),
            ),

            // 🔹 Right radio (double-ring style)
            Container(
              height: 24.r,
              width: 24.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? selectedBorderColor
                      : const Color(0xFFE3E3EA),
                  width: 2,
                ),
              ),
              alignment: Alignment.center,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 160),
                height: isSelected ? 12.r : 0,
                width: isSelected ? 12.r : 0,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: selectedBorderColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
