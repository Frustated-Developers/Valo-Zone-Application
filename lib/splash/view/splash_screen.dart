import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:valo_zone/home/view/homepage.dart';
import 'package:valo_zone/landing/view/landingPage.dart';
import 'package:valo_zone/utils/AppColors.dart';
import 'package:valo_zone/utils/Assets_path.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginState();
  }

  Future<void> _checkLoginState() async {
    // Add a small delay to show splash screen
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool isLoggedIn = prefs.getBool('is_logged_in') ?? false;
    final currentUser = FirebaseAuth.instance.currentUser;

    if (mounted) {
      // Only consider user logged in if both SharedPreferences and Firebase auth state are true
      if (isLoggedIn && currentUser != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Homepage()),
        );
      } else {
        // If either is false, clear preferences and go to landing page
        await prefs.setBool('is_logged_in', false);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LandingPage()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.homepageBackground,
      child: Center(
        child: Image.asset(
          AssetPath.splashlogo,
          height: 275.h,
          width: 275.w,
        ),
      ),
    );
  }
}
