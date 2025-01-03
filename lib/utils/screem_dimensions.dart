import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenDimensions {
  static const double averageSmallPhoneWidth = 360;
  static const double averageSmallPhoneHeight = 640;
  static const double averageBigPhoneWidth = 414;
  static const double averageBigPhoneHeight = 896;

  static bool isSmallPhone(BuildContext context) {
    return MediaQuery.of(context).size.width < averageSmallPhoneWidth.w ||
        MediaQuery.of(context).size.height < averageSmallPhoneHeight.h;
  }

  static bool isBigPhone(BuildContext context) {
    return MediaQuery.of(context).size.width >= averageBigPhoneWidth.w &&
        MediaQuery.of(context).size.height >= averageBigPhoneHeight.h;
  }
}
