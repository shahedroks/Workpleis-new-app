import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/features/onboarding/screen/onboarding_screen_01.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../nav_bar/screen/bottom_nav_bar.dart';
import '../../nav_bar/screen/service_bottom_nav_bar.dart';

void loginCheck(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  final email = prefs.getString("email");
  final token = prefs.getString("token");
  final role = prefs.getString("role");

  if (!context.mounted) return;
  
  if (email != null && email.isNotEmpty && token != null && token.isNotEmpty) {
    final normalizedRole = (role ?? '').toLowerCase().trim();
    final isProvider = normalizedRole.contains('provider');
    context.go(isProvider ? ServiceBottomNavBar.routeName : BottomNavBar.routeName);
  } else {
    context.go(OnboardingScreen01.routeName);
  }
}
