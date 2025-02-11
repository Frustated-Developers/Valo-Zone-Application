import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobService {
  static String? get bannerAdUnitId {
    return 'ca-app-pub-5440541895724236/1887047336';
  }

  static String? get interstitialAdUnitId {
    return 'ca-app-pub-5440541895724236/8853547410';
  }

  static String? get rewardedAdUnitId {
    return 'ca-app-pub-5440541895724236/3682241084';
  }

  static final BannerAdListener bannerAdListener = BannerAdListener(
    onAdLoaded: (ad) => debugPrint('Ad loaded: ${ad.responseInfo}'),
    onAdFailedToLoad: (ad, error) {
      ad.dispose();
      debugPrint('Ad failed to load: $error');
    },
    onAdOpened: (ad) => debugPrint('Ad opened'),
    onAdClosed: (ad) => debugPrint('Ad closed'),
  );

  static InterstitialAd? interstitialAd;
  static bool isInterstitialAdReady = false;

  static RewardedAd? _rewardedAd;
  static bool isRewardedAdReady = false;

  static BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: bannerAdUnitId!,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: bannerAdListener,
    );
  }

  static void loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: interstitialAdUnitId!,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          interstitialAd = ad;
          isInterstitialAdReady = true;
          debugPrint('Interstitial ad loaded successfully');
        },
        onAdFailedToLoad: (error) {
          isInterstitialAdReady = false;
          debugPrint('Interstitial ad failed to load: $error');
        },
      ),
    );
  }

  static void showInterstitialAd({Function? onAdDismissed}) {
    if (isInterstitialAdReady && interstitialAd != null) {
      interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          debugPrint('Interstitial ad dismissed');
          ad.dispose();
          isInterstitialAdReady = false;
          loadInterstitialAd();
          onAdDismissed?.call();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          debugPrint('Interstitial ad failed to show: $error');
          ad.dispose();
          isInterstitialAdReady = false;
          loadInterstitialAd();
          onAdDismissed?.call();
        },
      );
      interstitialAd!.show();
    } else {
      debugPrint('Interstitial ad not ready, loading new ad');
      loadInterstitialAd();
      onAdDismissed?.call();
    }
  }

  static Future<void> loadRewardedAd() async {
    try {
      debugPrint('Loading rewarded ad...');
      await RewardedAd.load(
        adUnitId: rewardedAdUnitId!,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (ad) {
            _rewardedAd = ad;
            isRewardedAdReady = true;
            debugPrint('Rewarded ad loaded successfully');
          },
          onAdFailedToLoad: (error) {
            _rewardedAd = null;
            isRewardedAdReady = false;
            debugPrint('Rewarded ad failed to load: $error');
          },
        ),
      );
    } catch (e) {
      debugPrint('Error in loadRewardedAd: $e');
      isRewardedAdReady = false;
    }
  }

  static void showRewardedAd({
    required Function(RewardItem reward) onUserEarnedReward,
  }) {
    debugPrint('Attempting to show rewarded ad');
    debugPrint('Is ad ready: $isRewardedAdReady');
    debugPrint('Rewarded ad null: ${_rewardedAd == null}');

    if (!isRewardedAdReady || _rewardedAd == null) {
      debugPrint('Rewarded ad not ready, loading new ad');
      loadRewardedAd();
      return;
    }

    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        debugPrint('Rewarded ad dismissed');
        ad.dispose();
        isRewardedAdReady = false;
        loadRewardedAd();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        debugPrint('Rewarded ad failed to show: $error');
        ad.dispose();
        isRewardedAdReady = false;
        loadRewardedAd();
      },
    );

    _rewardedAd!.show(
      onUserEarnedReward: (ad, reward) {
        debugPrint('User earned reward');
        onUserEarnedReward(reward);
      },
    );
  }

  static void disposeRewardedAd() {
    _rewardedAd?.dispose();
  }
}