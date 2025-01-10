import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:valo_zone/utils/AppColors.dart';
import 'package:valo_zone/utils/Assets_path.dart';

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

  @override
  void initState() {
    getUserPhoto();
    super.initState();
  }

  void getUserPhoto() async {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final String? photoUrl = user.photoURL;
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
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
        CircleAvatar(
          radius: 20,
          backgroundColor: Colors.grey,
          foregroundImage: widget.photoURL != null
              ? NetworkImage(user!.photoURL!)
              : const AssetImage(AssetPath.dummy_avatar) as ImageProvider,
        ),
        const SizedBox(width: 20),
      ],
    );
  }
}
