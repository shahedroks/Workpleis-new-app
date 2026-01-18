import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';

class ReferralScreen extends StatefulWidget {
  static final routeName = "/raferral_screen";
  static const String _referralIllustration =
      'assets/images/getNotification.png';
  static const String _sendIcon = 'assets/images/chat_icon.png';
  static const String _shareIcon = 'assets/images/typeicon.png';

  @override
  State<ReferralScreen> createState() => _ReferralScreenState();
}

class _ReferralScreenState extends State<ReferralScreen> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _handleShare() async {
    final emailText = _emailController.text.trim();
    final shareText = emailText.isNotEmpty
        ? 'Check out Workpeer Application! Email: $emailText'
        : 'Check out Workpeer Application! Join me on this amazing platform.';

    await Share.share(shareText, subject: 'Invitation to Workpeer Application');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf4f5f6),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
              sliver: SliverToBoxAdapter(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        onTap: () => context.pop(),
                        borderRadius: BorderRadius.circular(12.r),
                        child: Container(
                          height: 40.w,
                          width: 40.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: AllColor.grey200,
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.arrow_back,
                              size: 22.sp,
                              color: const Color(0xFF111111),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'Tasker Center',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontFamily: 'sf_pro',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 24.h),
                    Container(
                      width: double.infinity,
                      height: 240.h,
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2F3E0A),
                        borderRadius: BorderRadius.circular(18.r),
                      ),
                      child: Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 96.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Ramjan Khan, take the credit for referring friends '
                                  'to Workpeer Application',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w700,
                                    height: 1.25,
                                    fontFamily: 'sf_pro',
                                  ),
                                ),
                                SizedBox(height: 18.h),
                                Text(
                                  'A friend you referred, sadia2042, just signed up',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 18.sp,
                                    height: 1.3,
                                    fontFamily: 'sf_pro',
                                  ),
                                ),
                                SizedBox(height: 18.h),
                                TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    minimumSize: Size.zero,
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  child: Text(
                                    'Terms & Conditions',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.sp,
                                      decoration: TextDecoration.underline,
                                      fontFamily: 'sf_pro',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Image.asset(
                              ReferralScreen._referralIllustration,
                              height: 80.h,
                              width: 80.h,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Text(
                      'Invite friends through email',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontFamily: 'sf_pro',
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Container(
                      height: 48.h,
                      padding: EdgeInsets.only(left: 16.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 8.w, right: 6.w),
                              child: TextField(
                                controller: _emailController,
                                textAlignVertical: TextAlignVertical.center,
                                decoration: InputDecoration(
                                  hintText: 'Add email addresses',
                                  hintStyle: TextStyle(
                                    color: Colors.black45,
                                    fontSize: 14.sp,
                                    fontFamily: 'sf_pro',
                                  ),
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                ),
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontFamily: 'sf_pro',
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: double.infinity,
                            child: ElevatedButton(
                              onPressed: _handleShare,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                foregroundColor: Colors.white,
                                shape: const StadiumBorder(),
                                padding: EdgeInsets.symmetric(horizontal: 24.w),
                                minimumSize: Size(0, 36.h),
                              ),
                              child: Text(
                                'Send',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'sf_pro',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        Icon(
                          Icons.open_in_new,
                          size: 18.sp,
                          color: Colors.black,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'Share File',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black,
                            fontFamily: 'sf_pro',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
