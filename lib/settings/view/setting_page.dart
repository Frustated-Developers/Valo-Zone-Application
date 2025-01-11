import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:valo_zone/legal/view/privacy.dart';
import 'package:valo_zone/legal/view/terms.dart';
import 'package:valo_zone/utils/AppColors.dart';
import 'package:valo_zone/utils/Assets_path.dart';
import 'package:valo_zone/utils/navigation.dart';

class SettingsDrawer extends StatefulWidget {
  const SettingsDrawer({super.key});

  @override
  State<SettingsDrawer> createState() => _SettingsDrawerState();
}

class _SettingsDrawerState extends State<SettingsDrawer> {
  String selectedItem = ''; // Track selected item

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.homepageBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(AssetPath.icIcon,height: 180.h,width: 180.w,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 28,
                foregroundImage: AssetImage(AssetPath.dummy_avatar),
              ),
              SizedBox(
                width: 15.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Yesra",style: TextStyle(color: AppColors.whiteText,fontSize: 16),),
                  Text("fyesra0@gmail.com",style: TextStyle(color: AppColors.whiteText),),
                ],
              )
            ],
          ),
          SizedBox(
            height: 30.h,
          ),

          _buildList(AssetPath.ic_feedback, "Feedback", () {
            setState(() {
              selectedItem = "Feedback";
            });
          }, selectedItem == "Feedback"),
          SizedBox(
            height: 15.h,
          ),
          _buildList(AssetPath.ic_share, "Refer a friend", () {
            setState(() {
              selectedItem = "Refer a friend";
            });
          }, selectedItem == "Refer a friend"),
          SizedBox(
            height: 15.h,
          ),
          _buildList(AssetPath.ic_support, "Support", () {
            setState(() {
              selectedItem = "Support";
            });
          }, selectedItem == "Support"),
          SizedBox(
            height: 15.h,
          ),
          _buildList(AssetPath.ic_privacy, "Privacy Policy", () {
            navigateTo(context, PrivacyPolicy());
            setState(() {
              selectedItem = "Privacy Policy";
            });
          }, selectedItem == "Privacy Policy"),
          SizedBox(
            height: 15.h,
          ),
          _buildList(AssetPath.ic_terms, "Terms & Conditions", () {
            navigateTo(context, TermsNConditions());
            setState(() {
              selectedItem = "Terms & Conditions";
            });
          }, selectedItem == "Terms & Conditions"),

          SizedBox(
            height: 15,
          ),

          _buildADBanner(),

          Divider(
            thickness: 2.w,
            color: AppColors.Divider,

          ),

          _buildList(AssetPath.ic_Home, "Back to Home", () {
            setState(() {
              selectedItem = "Back to Home";
            });
          }, selectedItem == "Back to Home"),

          _buildList(AssetPath.ic_logout, "Logout", () {
            setState(() {
              selectedItem = "Logout";
            });
          }, selectedItem == " Logout"),
        ],
      ),
    );
  }

  Widget _buildList(String icon, String title, VoidCallback onPressed, bool isSelected) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.only(left: 35.0),
        width: 250.w,
        height: 50.h,// Make container full width
        decoration: BoxDecoration(
          color: isSelected ? AppColors.SelectedSetting : Colors.transparent,
          // Optional: Add rounded corners
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(icon, height: 35,),
            SizedBox(
              width: 15.w,
            ),
            Text(
              title,
              style: TextStyle(
                  color: AppColors.whiteText,
                  fontWeight: FontWeight.normal,
                  fontSize: 14
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildADBanner() {
    return Container(
      height: 40.h,
      width: 200.w,
      color: AppColors.whiteText,
    );
  }


}