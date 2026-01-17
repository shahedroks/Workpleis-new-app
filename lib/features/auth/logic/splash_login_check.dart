import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/features/onboarding/screen/onboarding_screen_01.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../nav_bar/screen/bottom_nav_bar.dart';

void loginCheck(BuildContext context) async {
  SharedPreferences _pref = await SharedPreferences.getInstance();
  String? email = _pref.getString("email");
  String? token = _pref.getString("token");

  if (!context.mounted) return;
  
  if (email != null && token != null) {
    context.go(BottomNavBar.routeName);
  } else {
    context.go(OnboardingScreen01.routeName);
  }
}
