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
    onAdLoaded: (ad) => print('Ad loaded: ${ad.responseInfo}'),
    onAdFailedToLoad: (ad, error) {
      ad.dispose();
      print('Ad failed to load: $error');
    },
    onAdOpened: (ad) => print('Ad opened'),
    onAdClosed: (ad) => print('Ad closed'),
  );

  static InterstitialAd? interstitialAd;
  static bool isInterstitialAdReady = false;

  static RewardedAd? rewardedAd;
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
        },
        onAdFailedToLoad: (error) {
          isInterstitialAdReady = false;
        },
      ),
    );
  }

  static void showInterstitialAd() {
    if (isInterstitialAdReady && interstitialAd != null) {
      interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          isInterstitialAdReady = false;
          loadInterstitialAd();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          isInterstitialAdReady = false;
          loadInterstitialAd();
        },
      );
      interstitialAd!.show();
    } else {
      loadInterstitialAd();
    }
  }

  static void loadRewardedAd() {
    RewardedAd.load(
      adUnitId: rewardedAdUnitId!,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          rewardedAd = ad;
          isRewardedAdReady = true;
        },
        onAdFailedToLoad: (error) {
          isRewardedAdReady = false;
        },
      ),
    );
  }

  static void showRewardedAd({
    required Function(RewardItem reward) onUserEarnedReward,
  }) {
    if (isRewardedAdReady && rewardedAd != null) {
      rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          isRewardedAdReady = false;
          loadRewardedAd();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          isRewardedAdReady = false;
          loadRewardedAd();
        },
      );

      rewardedAd!.show(
        onUserEarnedReward: (ad, reward) {
          onUserEarnedReward(reward);
        },
      );
    } else {
      loadRewardedAd();
    }
  }

  static void disposeInterstitialAd() {
    interstitialAd?.dispose();
  }

  static void disposeRewardedAd() {
    rewardedAd?.dispose();
  }
}
