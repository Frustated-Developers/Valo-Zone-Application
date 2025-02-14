import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:valo_zone/edit_profile/view/edit_profile.dart';
import 'package:valo_zone/utils/AppColors.dart';
import 'package:valo_zone/utils/Assets_path.dart';
import 'package:valo_zone/utils/navigation.dart';

class CustomSliverAppBar extends StatefulWidget {
  final String? photoURL;
  final Color backgroundColor;
  final double expandedHeight;
  final bool showTitle;
  final String? title;

  const CustomSliverAppBar({
    super.key,
    this.title,
    this.photoURL,
    this.showTitle = false,
    this.backgroundColor = Colors.white,
    this.expandedHeight = 60.0,
  });

  @override
  State<CustomSliverAppBar> createState() => _CustomSliverAppBarState();
}

class _CustomSliverAppBarState extends State<CustomSliverAppBar> {
  final User? user = FirebaseAuth.instance.currentUser;
  String? userPhotoURL;

  @override
  void initState() {
    super.initState();
    getUserPhoto();
  }

  void getUserPhoto() {
    if (user != null && user!.photoURL != null) {
      setState(() {
        userPhotoURL = user!.photoURL;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      pinned: true,
      floating: true,
      backgroundColor: AppColors.homepageBackground,
      expandedHeight: 60,
      leading: Image.asset(
        AssetPath.ic_valo,
        width: 100,
        height: 100,
      ),
      title: widget.showTitle
          ? Text(widget.title ?? "",
              style: const TextStyle(
                  fontFamily: "Pennypacker", color: Colors.white))
          : null,
      actions: [
        GestureDetector(
          onTap: () {
            navigateTo(context, EditProfile());
          },
          child: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey,
            foregroundImage: userPhotoURL != null
                ? NetworkImage(userPhotoURL!)
                : const AssetImage(AssetPath.dummy_avatar) as ImageProvider,
          ),
        ),
        const SizedBox(width: 20),
      ],
    );
  }
}
