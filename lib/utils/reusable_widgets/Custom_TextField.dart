import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextfield extends StatelessWidget {
  final Color backgroundColor;
  final String hintText;
  final IconData icon;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final focusNode;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  const CustomTextfield({
    super.key,
    this.backgroundColor = const Color(0xFFFB4453),
    this.hintText = 'User Name',
    this.icon = Icons.person_3_outlined,
    this.focusNode,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: 150.w,
          child: Divider(
            thickness: 1,
            color: Colors.black,
          ),
        ),
        Positioned(
          left: 10.w,
          child: SizedBox(
            height: 150.w,
            child: VerticalDivider(
              thickness: 1,
              color: Colors.black,
            ),
          ),
        ),
        Positioned(
          right: 10.w,
          child: SizedBox(
            height: 150.w,
            child: VerticalDivider(
              thickness: 1,
              color: Colors.black,
            ),
          ),
        ),
        Positioned(
          bottom: -1.h,
          child: SizedBox(
            width: 150.w,
            child: Divider(
              thickness: 1,
              color: Colors.black,
            ),
          ),
        ),
        Positioned(
          top: -1.h,
          right: 1.h,
          child: SizedBox(
            width: 150.w,
            child: Divider(
              thickness: 1,
              color: Colors.black,
            ),
          ),
        ),
        Positioned(
          bottom: -1.h,
          right: 1,
          child: SizedBox(
            width: 150,
            child: Divider(
              thickness: 1,
              color: Colors.black,
            ),
          ),
        ),
        Opacity(
          opacity: 0.8,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0.w, vertical: 15.h),
            child: Container(
              color: const Color(0XFFC8C8C8),
              height: 50.h,
              width: 380.w,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0.w, vertical: 15.h),
          child: Container(
            height: 50.h,
            width: 380.w,
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                child: TextFormField(
                  style: TextStyle(fontWeight: FontWeight.bold),
                  focusNode: focusNode,
                  obscureText: obscureText,
                  keyboardType: keyboardType,
                  onChanged: onChanged,
                  validator: validator,
                  controller: controller,
                  decoration: InputDecoration(
                    icon: Icon(
                      icon,
                      size: 20.spMin,
                    ),
                    hintText: hintText,
                    hintStyle: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.normal),
                    iconColor: Colors.white,
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
