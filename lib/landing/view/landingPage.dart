import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:valo_zone/home/view/homepage.dart';
import 'package:valo_zone/login/view/loginPage.dart';
import 'package:valo_zone/utils/AppColors.dart';
import 'package:valo_zone/utils/Assets_path.dart';
import 'package:valo_zone/utils/navigation.dart';
import 'package:valo_zone/utils/reusable_widgets/CustomButton.dart/CustomButton.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AssetPath.landing_background),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Dividers
              _buildDividers(),

              _buildVerticalDividers(),

              // Logo at the top left
              Positioned(
                top: 45.h,
                left: 10.w,
                child: Image.asset(
                  AssetPath.ic_valo,
                  width: 80.w,
                  height: 80.h,
                ),
              ),

              // Background Character (Scaled for responsiveness)
              Positioned(
                bottom: MediaQuery.of(context).size.height >= 669
                    ? -1050.h
                    : -1100.h,
                left: -910.w,
                child: Image.asset(
                  AssetPath.sage,
                  width: 2000.w,
                  height: 2000.h,
                ),
              ),

              // Intro Text
              Positioned(
                top: 83.h,
                right: 18.w,
                child: Container(
                  constraints: BoxConstraints(maxWidth: 280.w),
                  child: Text(
                    "You are given 13 rounds to attack and \ndefend your side with fierce \nmarksman skills and tactical abilities.",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              // Main Title
              Positioned(
                bottom:
                    MediaQuery.of(context).size.height >= 669 ? 120.h : 120.h,
                left: 40.h,
                child: Text(
                  "We are \nValoZone".toUpperCase(),
                  style: TextStyle(
                    shadows: const [
                      Shadow(
                        blurRadius: 0.0,
                        color: AppColors.landingTitleShadow,
                        offset: Offset(-1.0, -5.0),
                      ),
                    ],
                    fontWeight: FontWeight.bold,
                    color: AppColors.landingTitle,
                    fontSize: 40.sp,
                  ),
                ),
              ),

              // Login Button
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.all(
                      MediaQuery.of(context).size.height >= 669 ? 50.w : 25.w),
                  child: CustomButton(
                    onPressed: () {
                      navigateTo(context,LoginPage());
                    },
                    width:
                        MediaQuery.of(context).size.height >= 669 ? 400 : 300,
                    text: "LET'S GET STARTED",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVerticalDividers() {
    return Row(
      children: [
        SizedBox(width: 10.w),
        const VerticalDivider(color: Colors.white, thickness: 1),
        SizedBox(width: 50.w),
        const VerticalDivider(color: Colors.white, thickness: 1),
        SizedBox(width: 60.w),
      ],
    );
  }

  Widget _buildDividers() {
    return Column(
      children: [
        SizedBox(height: 45.h),
        const Divider(color: Colors.white, thickness: 1),
        SizedBox(height: 50.h),
        const Divider(color: Colors.white, thickness: 1),
        SizedBox(height: 60.h),
      ],
    );
  }
}
