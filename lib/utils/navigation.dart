import 'package:flutter/material.dart';

void navigateToAgentWallpaper(BuildContext context, page) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => page),
  );
}

Future<void> navigateTo(BuildContext context, path) async {
  await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => path),
  );
}
