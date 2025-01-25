import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:valo_zone/utils/AppColors.dart';

class Customloginbutton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String buttonText;
  final bool isLoader;
  const Customloginbutton({
    super.key,
    this.onPressed,
    this.isLoader = false,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const SizedBox(
          width: 150,
          child: Divider(
            thickness: 1,
            color: Colors.black,
          ),
        ),
        const Positioned(
          left: 10,
          child: SizedBox(
            height: 150,
            child: VerticalDivider(
              thickness: 1,
              color: Colors.black,
            ),
          ),
        ),
        const Positioned(
          right: 10,
          child: SizedBox(
            height: 150,
            child: VerticalDivider(
              thickness: 1,
              color: Colors.black,
            ),
          ),
        ),
        Positioned(
          bottom: -1,
          child: SizedBox(
            width: 150.w,
            child: Divider(
              thickness: 1,
              color: Colors.black,
            ),
          ),
        ),
        Positioned(
          top: -1,
          right: 1,
          child: SizedBox(
            width: 150.w,
            child: Divider(
              thickness: 1,
              color: Colors.black,
            ),
          ),
        ),
        Positioned(
          bottom: -1,
          right: 1,
          child: SizedBox(
            width: 150.w,
            child: Divider(
              thickness: 1,
              color: Colors.black,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0.w, vertical: 15.h),
          child: GestureDetector(
            onTap: onPressed,
            child: Container(
              color: AppColors.SelectedIconColor,
              height: 50.h,
              width: 380.w,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0.w, vertical: 15.h),
          child: SizedBox(
            height: 50.h,
            width: 380.w,
            child: Center(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                  child: GestureDetector(
                    onTap: onPressed,
                    child: Stack(
                      children: [
                        if (isLoader)
                          LoadingAnimationWidget.threeArchedCircle(
                            size: 40,
                            color: Colors.white,
                          ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          buttonText,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          ),
        ),
      ],
    );
  }
}
