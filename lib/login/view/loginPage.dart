import 'package:flutter/material.dart';
import 'package:valo_zone/utils/Assets_path.dart';

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(AssetPath.ic_valo)),
        ),
      ),
    );
  }
}
