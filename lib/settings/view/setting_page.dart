import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
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
            openGmailWithSubject();
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

  Future<void> openGmailWithSubject() async {
    // Email details
    const String email = 'drishtantranjansrivastava54@gmail.com';
    const String subject = 'Support Request';
    const String body = 'Hi Support Team,\n\n';

    // Create mailto URI - Modified to ensure it opens in mail apps
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        'subject': subject,
        'body': body,
      },
    );

    try {
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(
          emailUri,
          mode: LaunchMode.platformDefault,  // This ensures it opens in mail apps
        );
      } else {
        // Try alternative launch method if the first one fails
        final String emailString = 'mailto:$email?subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}';
        final Uri alternativeUri = Uri.parse(emailString);

        if (await canLaunchUrl(alternativeUri)) {
          await launchUrl(
            alternativeUri,
            mode: LaunchMode.platformDefault,
          );
        } else {
          throw 'Could not launch email client';
        }
      }
    } catch (e) {
      throw 'Failed to open email app: $e';
    }
  }


}