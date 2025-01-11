import 'package:flutter/material.dart';
import 'package:valo_zone/utils/AppColors.dart';
import 'package:valo_zone/utils/Assets_path.dart';

class appBar extends PreferredSize {
  final bool showImage;
  final String title;
  final double? fontSize;

  appBar({
    super.key,
    required this.showImage,
    required this.title,
    this.fontSize,
  }) : super(
    preferredSize: const Size.fromHeight(kToolbarHeight),
    child: Builder(
      builder: (context) => AppBar(
        backgroundColor: AppColors.homepageBackground,
        centerTitle: true,
        title: Text(
          title,
          style: TextStyle(
            fontFamily: "Pennypacker",
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: fontSize,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Image.asset(
            width: 100,
            height: 100,
            AssetPath.ic_valo,
          ),
        ),
        actions: showImage
            ? [
          const CircleAvatar(radius: 20),
          const SizedBox(width: 20),
        ]
            : [],
      ),
    ),
  );
}