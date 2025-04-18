import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:valo_zone/services/admob_services.dart';
import 'package:valo_zone/utils/AppColors.dart';
import 'package:valo_zone/utils/reusable_widgets/CustomButton.dart/CustomButton.dart';

class FullImagePage extends StatefulWidget {
  final String imageUrl;

  const FullImagePage({Key? key, required this.imageUrl})
      : assert(imageUrl != null, 'imageUrl must not be null'),
        super(key: key);

  @override
  State<FullImagePage> createState() => _FullImagePageState();
}

class _FullImagePageState extends State<FullImagePage> {
  bool _isLoading = false;
  bool _isAdLoading = false;

  @override
  void initState() {
    super.initState();
    _preloadAd();
  }

  void _preloadAd() {
    debugPrint('Preloading ad');
    AdMobService.loadRewardedAd();
  }

  void _handleDownloadButtonPress() {
    debugPrint('Download button pressed');

    // Show a dialog to confirm if user wants to watch an ad
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          title: Text('Enjoy a Free Wallpaper'),
          content: Text(
              'Want to download this awesome wallpaper? Just watch a quick ad to unlock it!'),
          actions: <Widget>[
            // Cancel button: close the dialog and do nothing
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            // OK button: show ad and then download wallpaper
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Show the ad before downloading
                _showAdAndDownload();
              },
              child: Text('Continue'),
            ),
          ],
        );
      },
    );
  }

  void _showAdAndDownload() {
    // If rewarded ad is loading, show interstitial ad instead
    if (_isAdLoading) {
      AdMobService.showInterstitialAd(
        onAdDismissed: () {
          _downloadWallpaper();
        },
      );
      return;
    }

    // Start loading the ad
    setState(() {
      _isAdLoading = true;
    });

    // Show rewarded ad if available
    AdMobService.showRewardedAd(
      onUserEarnedReward: (_) {
        debugPrint('Ad reward earned');
        _downloadWallpaper();
      },
    );
  }

  @override
  void dispose() {
    AdMobService.disposeRewardedAd();
    super.dispose();
  }

  Future<bool> _requestPermission() async {
    if (Platform.isAndroid) {
      final deviceInfo = DeviceInfoPlugin();
      final androidInfo = await deviceInfo.androidInfo;

      if (androidInfo.version.sdkInt >= 33) {
        final photos = await Permission.photos.request();
        return photos.isGranted;
      } else {
        final storage = await Permission.storage.request();
        return storage.isGranted;
      }
    } else if (Platform.isIOS) {
      final photos = await Permission.photos.request();
      return photos.isGranted;
    }
    return false;
  }

  Future<void> _downloadWallpaper() async {
    if (_isLoading) return;

    setState(() => _isLoading = true);

    try {
      final hasPermission = await _requestPermission();
      if (!hasPermission) {
        throw Exception('Permission denied to access gallery');
      }

      final response = await http.get(Uri.parse(widget.imageUrl));
      if (!mounted) return;

      final result = await ImageGallerySaver.saveImage(
        response.bodyBytes,
        quality: 100,
        name: "wallpaper_${DateTime.now().millisecondsSinceEpoch}",
      );

      if (!mounted) return;

      if (result['isSuccess']) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Wallpaper downloaded successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        throw Exception('Failed to save wallpaper to gallery');
      }
    } catch (e) {
      debugPrint('Error downloading wallpaper: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error downloading wallpaper: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _isAdLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !_isLoading,
      child: Scaffold(
        backgroundColor: AppColors.homepageBackground,
        extendBody: true,
        body: Stack(
          children: [
            SafeArea(
              child: Stack(
                children: [
                  // Background image
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.imageUrl),
                        fit: BoxFit.cover,
                        onError: (error, stackTrace) {
                          debugPrint('Error loading image: $error');
                        },
                      ),
                    ),
                  ),
                  // Back button
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 16),
                      child: GestureDetector(
                        onTap: _isLoading ? null : () => Navigator.pop(context),
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
                  // Download button
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 16),
                      child: CustomButton(
                        borderColor: AppColors.dullWhiteText,
                        height: 50.h,
                        width: 200.w,
                        text: "Download",
                        textStyle: TextStyle(
                          color: AppColors.dullWhiteText,
                          fontWeight: FontWeight.w700,
                        ),
                        onPressed:
                            _isLoading ? null : _handleDownloadButtonPress,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (_isLoading)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(
                        color: AppColors.buttonBlue,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Downloading wallpaper...',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
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
