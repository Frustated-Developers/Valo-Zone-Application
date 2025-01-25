import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:valo_zone/home/view/homepage.dart';
import 'package:valo_zone/landing/view/landingPage.dart';
import 'package:valo_zone/legal/view/privacy.dart';
import 'package:valo_zone/legal/view/terms.dart';
import 'package:valo_zone/services/admob_services.dart';
import 'package:valo_zone/services/login_service.dart';
import 'package:valo_zone/utils/AppColors.dart';
import 'package:valo_zone/utils/Assets_path.dart';
import 'package:valo_zone/utils/navigation.dart';

class SettingsDrawer extends StatefulWidget {
  const SettingsDrawer({super.key});

  @override
  State<SettingsDrawer> createState() => _SettingsDrawerState();
}

class _SettingsDrawerState extends State<SettingsDrawer> {
  final User? user = FirebaseAuth.instance.currentUser;
  final LoginService loginService = LoginService();
  String? userPhotoURL;
  String? userName;
  String? userEmail;
  Map<String, dynamic>? userData;
  BannerAd? _bannerAd;
  bool _isBannerAdLoaded = false;

  @override
  void initState() {
    super.initState();
    initializeUserData();
    _loadBannerAd();
  }

  void _loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: AdMobService.bannerAdUnitId!,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _isBannerAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          print('Ad failed to load: $error');
        },
      ),
    );

    _bannerAd?.load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  Future<void> initializeUserData() async {
    if (user != null) {
      // Check if user logged in with Google
      final isGoogleUser = user!.providerData
          .any((provider) => provider.providerId == 'google.com');

      if (isGoogleUser) {
        // Handle Google Sign-in user
        setState(() {
          userName = user!.displayName;
          userEmail = user!.email;
          userPhotoURL = user!.photoURL;
        });
      } else {
        // Handle Email/Password user - fetch from Firestore
        try {
          DocumentSnapshot<Map<String, dynamic>> userDoc =
              await FirebaseFirestore.instance
                  .collection('users')
                  .doc(user!.uid)
                  .get();

          if (userDoc.exists && mounted) {
            setState(() {
              userData = userDoc.data();
              userName = userData?['username'];
              userEmail = userData?['email'];
              userPhotoURL = userData?['profile']?['photoURL'];
            });
          }
        } catch (e) {
          print('Error fetching user data: $e');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.homepageBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            AssetPath.icIcon,
            height: 180.h,
            width: 180.w,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 28,
                foregroundImage: userPhotoURL != null
                    ? NetworkImage(userPhotoURL!)
                    : const AssetImage(AssetPath.dummy_avatar) as ImageProvider,
              ),
              SizedBox(
                width: 15.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName ?? "Guest User",
                    style: const TextStyle(
                        color: AppColors.whiteText, fontSize: 16),
                  ),
                  Text(
                    userEmail ?? "xxxx123@gmail.com",
                    style: const TextStyle(
                        color: AppColors.whiteText, fontSize: 11),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 30.h,
          ),
          _buildList(AssetPath.ic_feedback, "Feedback", () {
            _launchURL(
                'https://play.google.com/store/apps/details?id=com.drishtant.valo_zone');
          }, false),
          SizedBox(
            height: 15.h,
          ),
          _buildList(AssetPath.ic_share, "Refer a friend", () {
            _shareApp();
          }, false),
          SizedBox(
            height: 15.h,
          ),
          _buildList(
              AssetPath.ic_support, "Support", openGmailWithSubject, false),
          SizedBox(
            height: 15.h,
          ),
          _buildList(AssetPath.ic_privacy, "Privacy Policy", () {
            navigateTo(context, const PrivacyPolicy());
          }, false),
          SizedBox(
            height: 15.h,
          ),
          _buildList(AssetPath.ic_terms, "Terms & Conditions", () {
            navigateTo(context, const TermsNConditions());
          }, false),
          const SizedBox(
            height: 15,
          ),
          _buildADBanner(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
            child: Divider(
              thickness: 2.w,
              color: AppColors.Divider,
            ),
          ),
          _buildList(AssetPath.ic_Home, "Back to Home", () {
            navigateTo(context, const Homepage());
          }, false),
          _buildList(AssetPath.ic_logout, "Logout", () async {
            await _handleSignOut(context);
          }, false),
        ],
      ),
    );
  }

  Widget _buildList(
      String icon, String title, VoidCallback onPressed, bool isSelected) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.only(left: 35.0),
        width: 250.w,
        height: 50.h,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.SelectedSetting : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Image.asset(
              icon,
              height: 35,
            ),
            SizedBox(
              width: 15.w,
            ),
            Text(
              title,
              style: const TextStyle(
                  color: AppColors.whiteText,
                  fontWeight: FontWeight.normal,
                  fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildADBanner() {
    if (_isBannerAdLoaded && _bannerAd != null) {
      return Container(
        height: _bannerAd!.size.height.toDouble(),
        width: _bannerAd!.size.width.toDouble(),
        child: AdWidget(ad: _bannerAd!),
      );
    } else {
      return Container(
        height: 40.h,
        width: 200.w,
        color: Colors.transparent,
      );
    }
  }

  Future<void> openGmailWithSubject() async {
    const String email = 'support@valo.zone';
    const String subject = 'Support Request';
    const String body = 'Hi Support Team,\n\n';
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        'subject': subject,
        'body': body,
      },
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }

  // Function to share the app URL via WhatsApp, Instagram, etc.
  _shareApp() {
    print("Sharing app now..."); // Debugging print statement
    final String appUrl =
        'https://play.google.com/store/apps/details?id=com.drishtant.valo_zone';
    Share.share(appUrl);

    _launchWhatsApp() async {
      final String message =
          'Hey, check out this app: https://play.google.com/store/apps/details?id=com.example.myapp';
      final String whatsappUrl = 'whatsapp://send?text=$message';

      if (await canLaunch(appUrl)) {
        await launch(appUrl);
      } else {
        print("WhatsApp not installed");
      }
    }
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _handleSignOut(BuildContext context) async {
    try {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );

      // Clear SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      // Sign out using LoginService
      await loginService.signOut();

      // Close loading dialog
      if (mounted) {
        Navigator.pop(context);
      }

      // Show success message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Successfully logged out')),
        );
      }

      // Navigate to landing page
      if (mounted) {
        navigateTo(context, const LandingPage());
      }
    } catch (e) {
      // Close loading dialog if error occurs
      if (mounted) {
        Navigator.pop(context);
      }

      // Show error message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error signing out: $e')),
        );
      }
      print('Error signing out: $e');
    }
  }
}
