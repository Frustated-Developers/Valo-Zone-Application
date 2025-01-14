import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:valo_zone/utils/AppColors.dart';
import 'package:valo_zone/utils/Assets_path.dart';
import 'package:valo_zone/utils/reusable_widgets/CustomButton.dart/CustomButton.dart';
import 'package:valo_zone/utils/reusable_widgets/appBar.dart';
import 'package:valo_zone/weapons/widget/aresDialog.dart';
import 'package:valo_zone/weapons/widget/buckyDialog.dart';
import 'package:valo_zone/weapons/widget/bulldogDialog.dart';
import 'package:valo_zone/weapons/widget/classicDialog.dart';
import 'package:valo_zone/weapons/widget/frenzyDialog.dart';
import 'package:valo_zone/weapons/widget/ghostDialog.dart';
import 'package:valo_zone/weapons/widget/guardianDialog.dart';
import 'package:valo_zone/weapons/widget/judgeDialog.dart';
import 'package:valo_zone/weapons/widget/knifeDialog.dart';
import 'package:valo_zone/weapons/widget/marshalDialog.dart';
import 'package:valo_zone/weapons/widget/odinDialog.dart';
import 'package:valo_zone/weapons/widget/operatorDialog.dart';
import 'package:valo_zone/weapons/widget/outlawDialog.dart';
import 'package:valo_zone/weapons/widget/phantomDialog.dart';
import 'package:valo_zone/weapons/widget/sherrifDialog.dart';
import 'package:valo_zone/weapons/widget/shortyDialog.dart';
import 'package:valo_zone/weapons/widget/spectreDialog.dart';
import 'package:valo_zone/weapons/widget/stringerDialog.dart';
import 'package:valo_zone/weapons/widget/vandalDialog.dart';

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
            SizedBox(height: 20.h),
            _buildCollectionTitle("SIDE ARMS"),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildGunContainer(
                    AssetPath.bg_container2, "SHORTY", AssetPath.shorty, 230.h,
                    () {
                  _buildGunInfo(context, "SHORTY");
                }),
                _buildGunContainer(AssetPath.bg_container1, "CLASSIC",
                    AssetPath.classic, 200.h, () {
                  _buildGunInfo(context, "CLASSIC");
                }),
              ],
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildGunContainer(
                    AssetPath.bg_container4, "GHOST", AssetPath.ghost, 230.h,
                    () {
                  _buildGunInfo(context, "GHOST");
                }),
                _buildGunContainer(
                    AssetPath.bg_container3, "FRENZY", AssetPath.frenzy, 180.h,
                    () {
                  _buildGunInfo(context, "FRENZY");
                }),
              ],
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildGunContainer(AssetPath.bg_container2, "SHERIFF",
                    AssetPath.sheriff, 210.h, () {
                  _buildGunInfo(
                    context,
                    "SHERIFF",
                  );
                }),
                _buildGunContainer(
                    AssetPath.bg_container1, "KNIFE", AssetPath.knife, 200.h,
                    () {
                  _buildGunInfo(context, "KNIFE");
                }),
              ],
            ),
            SizedBox(height: 20.h),
            _buildCollectionTitle("RIFLES"),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildGunContainer(AssetPath.bg_container4, "PHANTOM",
                    AssetPath.phantom, 230.h, () {
                  _buildGunInfo(context, "PHANTOM");
                }),
                _buildGunContainer(
                    AssetPath.bg_container1, "VANDAL", AssetPath.vandal, 230.h,
                    () {
                  _buildGunInfo(context, "VANDAL");
                }),
              ],
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildGunContainer(AssetPath.bg_container3, "BULLDOG",
                    AssetPath.bulldog, 210.h, () {
                  _buildGunInfo(context, "BULLDOG");
                }),
                _buildGunContainer(AssetPath.bg_container2, "GUARDIAN",
                    AssetPath.guardian, 245.h, () {
                  _buildGunInfo(context, "GUARDIAN");
                }),
              ],
            ),
            SizedBox(height: 20.h),
            _buildCollectionTitle("SMGS"),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildGunContainer(AssetPath.bg_container3, "SPECTRE",
                    AssetPath.spectre, 230.h, () {
                  _buildGunInfo(context, "SPECTRE");
                }),
                _buildGunContainer(AssetPath.bg_container2, "STINGER",
                    AssetPath.stringer, 220.h, () {
                  _buildGunInfo(context, "STINGER");
                }),
              ],
            ),
            SizedBox(height: 20.h),
            _buildCollectionTitle("SHORT GUNS"),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildGunContainer(
                    AssetPath.bg_container4, "BUCKY", AssetPath.bucky, 230.h,
                    () {
                  _buildGunInfo(context, "BUCKY");
                }),
                _buildGunContainer(
                    AssetPath.bg_container1, "JUDGE", AssetPath.judge, 220.h,
                    () {
                  _buildGunInfo(context, "JUDGE");
                }),
              ],
            ),
            SizedBox(height: 20.h),
            _buildCollectionTitle("MACHINE GUN"),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildGunContainer(
                    AssetPath.bg_container3, "ARES", AssetPath.ares, 230.h, () {
                  _buildGunInfo(context, "ARES");
                }),
                _buildGunContainer(
                    AssetPath.bg_container2, "ODIN", AssetPath.odin, 235.h, () {
                  _buildGunInfo(context, "ODIN");
                }),
              ],
            ),
            SizedBox(height: 20.h),
            _buildCollectionTitle("SNIPER RIFLES"),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildGunContainer(AssetPath.bg_container1, "OPERATOR",
                    AssetPath.operator, 230.h, () {
                  _buildGunInfo(context, "OPERATOR");
                }),
                _buildGunContainer(AssetPath.bg_container3, "MARSHAL",
                    AssetPath.marshal, 240.h, () {
                  _buildGunInfo(context, "MARSHAL");
                }),
              ],
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildGunContainer(
                    AssetPath.bg_container3, "OUTLAW", AssetPath.outlaw, 220.h,
                    () {
                  _buildGunInfo(context, "OUTLAW");
                }),
                Container(
                  height: 225.h,
                  width: 160.w,
                ),
              ],
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}

Widget _buildGunContainer(
    @required String ContainerImage,
    @required String GunName,
    @required String GunImage,
    double? GunHeight,
    VoidCallback onPressed) {
  return GestureDetector(
    onTap: onPressed,
    child: Stack(
      children: [
        Container(
          height: 225.h,
          width: 160.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            image: DecorationImage(
              image: AssetImage(ContainerImage),
              fit: BoxFit.cover,
            ),
          ),
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
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w900,
                      color: AppColors.blackText,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 5.h,
          left: 10.h,
          child: Image.asset(
            GunImage,
            height: GunHeight ?? 200.h,
          ),
        ),
      ],
    ),
  );
}

Future _buildGunInfo(BuildContext context, String gunName) {
  return showDialog(
    context: context,
    builder: (ctxt) {
      if (gunName == "SHORTY") {
        return ShortyDialog();
      }
      if (gunName == "CLASSIC") {
        return ClassicDialog();
      }
      if (gunName == "GHOST") {
        return GhostDialog();
      }
      if (gunName == "FRENZY") {
        return FrenzyDialog();
      }
      if (gunName == "SHERIFF") {
        return SherrifDialog();
      }
      if (gunName == "KNIFE") {
        return KnifeDialog();
      }
      if (gunName == "PHANTOM") {
        return PhantomDialog();
      }
      if (gunName == "VANDAL") {
        return VandalDialog();
      }
      if (gunName == "BULLDOG") {
        return BulldogDialog();
      }
      if (gunName == "GUARDIAN") {
        return GuardianDialog();
      }
      if (gunName == "SPECTRE") {
        return SpectreDialog();
      }
      if (gunName == "STINGER") {
        return StringerDialog();
      }
      if (gunName == "BUCKY") {
        return BuckyDialog();
      }
      if (gunName == "JUDGE") {
        return JudgeDialog();
      }
      if (gunName == "ARES") {
        return AresDialog();
      }
      if (gunName == "ODIN") {
        return OdinDialog();
      }
      if (gunName == "OPERATOR") {
        return OperatorDialog();
      }
      if (gunName == "MARSHAL") {
        return MarshalDialog();
      }
      if (gunName == "OUTLAW") {
        return OutlawDialog();
      } else {
        return AlertDialog(
          title: Text("Unknown Gun"),
          content: Text("Information for this gun is not available."),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(ctxt).pop(),
              child: Text('Close'),
            ),
          ],
        );
      }
    },
  );
}

Widget _buildCollectionTitle(String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: CustomButton(height: 45, width: double.infinity, text: title),
  );
}
