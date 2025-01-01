import 'package:flutter/material.dart';
import 'package:valo_zone/utils/AppColors.dart';
import 'package:valo_zone/utils/Assets_path.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.homepageBackground,
      appBar: AppBar(
        backgroundColor: AppColors.homepageBackground,
        leading: Image.asset(width: 100, height: 100, AssetPath.ic_valo),
        actions: [
          CircleAvatar(
            radius: 20,
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              "Get Your \nFavourite Agent",
              style: TextStyle(
                  fontFamily: "Pennypacker",
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.whiteText),
            ),
          )
        ],
      ),
    );
  }
}
