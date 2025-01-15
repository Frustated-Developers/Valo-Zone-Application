import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:valo_zone/utils/AppColors.dart';
import 'package:valo_zone/utils/reusable_widgets/CustomButton.dart/CustomButton.dart';

class FullImagePage extends StatelessWidget {
  final String imageUrl;

  const FullImagePage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.homepageBackground,
      extendBody: true,
      body: SafeArea(
        child: Stack(
          children: [
            // Background image
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Back button
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: AppColors.whiteText,
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: AppColors.blackText,
                      weight: 10,
                      size: 15,
                    ),
                  ),
                ),
              ),
            ),
            // Apply button
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
                child: CustomButton(
                  borderColor: AppColors.dullWhiteText,
                  height: 50.h,
                  width: 200.w,
                  text: "Apply",
                  textStyle: TextStyle(
                      color: AppColors.dullWhiteText,
                      fontWeight: FontWeight.w700),
                  onPressed: () {
                    _showApplyOptions(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to show bottom sheet with options
  void _showApplyOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Apply Wallpaper",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.blackText,
                ),
              ),
              SizedBox(height: 16.h),
              ListTile(
                leading: Icon(Icons.home, color: AppColors.buttonBlue),
                title: Text("Home Screen"),
                onTap: () {
                  Navigator.pop(context);
                  _applyWallpaper("home screen");
                },
              ),
              ListTile(
                leading: Icon(Icons.lock, color: AppColors.buttonBlue),
                title: Text("Lock Screen"),
                onTap: () {
                  Navigator.pop(context);
                  _applyWallpaper("lock screen");
                },
              ),
              ListTile(
                leading: Icon(Icons.layers, color: AppColors.buttonBlue),
                title: Text("Both"),
                onTap: () {
                  Navigator.pop(context);
                  _applyWallpaper("both");
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Placeholder function for applying the wallpaper
  void _applyWallpaper(String option) {
    // Replace with actual implementation for applying wallpaper
    print("Wallpaper applied to $option");
  }
}
