import 'package:firebase_auth/firebase_auth.dart';
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
            builder: (context) {
              final User? user = FirebaseAuth.instance.currentUser;
              final String? userPhotoURL = user?.photoURL;

              return Material(
                child: Container(
                  color: AppColors.homepageBackground,
                  child: SafeArea(
                    child: Container(
                      height: kToolbarHeight,
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Image.asset(
                              AssetPath.ic_valo,
                              width: 60,
                              height: 60,
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                title,
                                style: TextStyle(
                                  fontFamily: "Pennypacker",
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: fontSize ?? 20,
                                ),
                              ),
                            ),
                          ),
                          if (showImage) ...[
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: userPhotoURL != null
                                  ? NetworkImage(userPhotoURL)
                                  : const AssetImage(AssetPath.dummy_avatar)
                                      as ImageProvider,
                            ),
                            const SizedBox(width: 20),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
}
