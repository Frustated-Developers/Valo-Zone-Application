import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:valo_zone/utils/AppColors.dart';
import 'package:valo_zone/utils/Assets_path.dart';
import 'package:valo_zone/utils/reusable_widgets/CustomButton.dart/CustomButton.dart';
import 'package:valo_zone/utils/reusable_widgets/appBar.dart';

class WeaponsPage extends StatelessWidget {
  const WeaponsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.homepageBackground,
      appBar: appBar(
        showImage: true,
        title: "Weapons",
        fontSize: 20,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Image.asset(AssetPath.weapons_background),
            SizedBox(
              height: 20.h,
            ),
            _buildCollectionTitle("SIDE ARMS"),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildGunContainer(AssetPath.bg_container2, "SHORTY",
                    "assets/weapons/shorty.png", 230),
                _buildGunContainer(AssetPath.bg_container1, "CLASSIC",
                    "assets/weapons/classic.png", 200),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              _buildGunContainer(AssetPath.bg_container4, "GHOST",
                  "assets/weapons/ghost.png", 230),
              _buildGunContainer(AssetPath.bg_container1, "FRENZY",
                  "assets/weapons/frenzy.png", 200),
            ]),
            SizedBox(
              height: 20.h,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              _buildGunContainer(AssetPath.bg_container2, "SHERRIF",
                  "assets/weapons/sheriff.png", 230),
              _buildGunContainer(AssetPath.bg_container2, "KNIFE",
                  "assets/weapons/knife.png", 220),
            ]),
            SizedBox(
              height: 20.h,
            ),
            _buildCollectionTitle("RIFLES"),
            SizedBox(
              height: 20.h,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              _buildGunContainer(AssetPath.bg_container4, "PHANTOM",
                  "assets/weapons/phantom.png", 230),
              _buildGunContainer(AssetPath.bg_container1, "VANDAL",
                  "assets/weapons/vandal.png", 230),
            ]),
            SizedBox(
              height: 20.h,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              _buildGunContainer(AssetPath.bg_container3, "BULLDOG",
                  "assets/weapons/bulldog.png", 230),
              _buildGunContainer(AssetPath.bg_container2, "GUARDIAN",
                  "assets/weapons/guardian.png", 255),
            ]),
            SizedBox(
              height: 20.h,
            ),
            _buildCollectionTitle("SMGS"),
            SizedBox(
              height: 20.h,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              _buildGunContainer(AssetPath.bg_container3, "SPECTRE",
                  "assets/weapons/spectre.png", 230),
              _buildGunContainer(AssetPath.bg_container2, "STRINGER",
                  "assets/weapons/stringer.png", 235),
            ]),
            SizedBox(
              height: 20.h,
            ),
            _buildCollectionTitle("SHORT GUNS"),
            SizedBox(
              height: 20.h,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              _buildGunContainer(AssetPath.bg_container4, "BUCKY",
                  "assets/weapons/bucky.png", 230),
              _buildGunContainer(AssetPath.bg_container1, "JUDGE",
                  "assets/weapons/judge.png", 220),
            ]),
            SizedBox(
              height: 20.h,
            ),
            _buildCollectionTitle("MACHINE GUN"),
            SizedBox(
              height: 20.h,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              _buildGunContainer(AssetPath.bg_container3, "ARES",
                  "assets/weapons/ares.png", 230),
              _buildGunContainer(AssetPath.bg_container2, "ODIN",
                  "assets/weapons/odin.png", 235),
            ]),
            SizedBox(
              height: 20.h,
            ),
            _buildCollectionTitle("SNIPER RIFLES"),
            SizedBox(
              height: 20.h,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              _buildGunContainer(AssetPath.bg_container1, "OPERATOR",
                  "assets/weapons/operator.png", 230),
              _buildGunContainer(AssetPath.bg_container3, "MARSHAL",
                  "assets/weapons/marshal.png", 245),
            ]),
            SizedBox(
              height: 20.h,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              _buildGunContainer(AssetPath.bg_container3, "OUTLAW",
                  "assets/weapons/outlaw.png", 220),
              Container(
                height: 225.h,
                width: 160.w,
              ),
            ]),
            SizedBox(
              height: 20.h,
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildGunContainer(@required String ContainerImage,
    @required String GunName, @required String GunImage, double? GunHeight) {
  return Stack(
    children: [
      Container(
        height: 225.h,
        width: 160.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
                image: AssetImage(ContainerImage), fit: BoxFit.cover)),
        child: Stack(
          children: [
            RotatedBox(
                quarterTurns: 1,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    bottom: 10.0,
                  ),
                  child: Text(
                    GunName,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: AppColors.blackText,
                    ),
                  ),
                )),
          ],
        ),
      ),
      Positioned(
        bottom: 10,
        left: 10,
        child: Image.asset(
          GunImage,
          height: GunHeight ?? 200,
        ),
      ),
    ],
  );
}

Widget _buildCollectionTitle(String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: CustomButton(height: 45, width: double.infinity, text: title),
  );
}
