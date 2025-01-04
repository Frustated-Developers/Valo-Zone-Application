import 'package:flutter/material.dart';

void navigateToAgentWallpaper(BuildContext context, page) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => page),
  );
}
