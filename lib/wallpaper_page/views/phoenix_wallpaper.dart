import 'package:flutter/material.dart';
import 'package:valo_zone/utils/reusable_widgets/CustomButton.dart/CustomLoginButton.dart';
import 'package:valo_zone/utils/reusable_widgets/Custom_TextField.dart';

class PhoenixWallpaper extends StatelessWidget {
  const PhoenixWallpaper({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextfield(
            hintText: "User Name",
            icon: Icons.person_3_outlined,
          ),
          CustomTextfield(
            obscureText: true,
            hintText: "Password",
            icon: Icons.lock_open_outlined,
          ),
          Customloginbutton()
///////////////////////
        ],
      ),
    );
  }
}
