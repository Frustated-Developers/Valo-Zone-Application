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
            SizedBox(height: 20.h),
            _buildCollectionTitle("SIDE ARMS"),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildGunContainer(
                    AssetPath.bg_container2, "SHORTY", AssetPath.shorty, 230.h),
                _buildGunContainer(AssetPath.bg_container1, "CLASSIC",
                    AssetPath.classic, 200.h),
              ],
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildGunContainer(
                    AssetPath.bg_container4, "GHOST", AssetPath.ghost, 230.h),
                _buildGunContainer(
                    AssetPath.bg_container3, "FRENZY", AssetPath.frenzy, 180.h),
              ],
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildGunContainer(AssetPath.bg_container2, "SHERRIF",
                    AssetPath.sheriff, 210.h),
                _buildGunContainer(
                    AssetPath.bg_container1, "KNIFE", AssetPath.knife, 200.h),
              ],
            ),
            SizedBox(height: 20.h),
            _buildCollectionTitle("RIFLES"),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildGunContainer(AssetPath.bg_container4, "PHANTOM",
                    AssetPath.phantom, 230.h),
                _buildGunContainer(
                    AssetPath.bg_container1, "VANDAL", AssetPath.vandal, 230.h),
              ],
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildGunContainer(AssetPath.bg_container3, "BULLDOG",
                    AssetPath.bulldog, 210.h),
                _buildGunContainer(AssetPath.bg_container2, "GUARDIAN",
                    AssetPath.guardian, 245.h),
              ],
            ),
            SizedBox(height: 20.h),
            _buildCollectionTitle("SMGS"),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildGunContainer(AssetPath.bg_container3, "SPECTRE",
                    AssetPath.spectre, 230.h),
                _buildGunContainer(AssetPath.bg_container2, "STRINGER",
                    AssetPath.stringer, 220.h),
              ],
            ),
            SizedBox(height: 20.h),
            _buildCollectionTitle("SHORT GUNS"),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildGunContainer(
                    AssetPath.bg_container4, "BUCKY", AssetPath.bucky, 230.h),
                _buildGunContainer(
                    AssetPath.bg_container1, "JUDGE", AssetPath.judge, 220.h),
              ],
            ),
            SizedBox(height: 20.h),
            _buildCollectionTitle("MACHINE GUN"),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildGunContainer(
                    AssetPath.bg_container3, "ARES", AssetPath.ares, 230.h),
                _buildGunContainer(
                    AssetPath.bg_container2, "ODIN", AssetPath.odin, 235.h),
              ],
            ),
            SizedBox(height: 20.h),
            _buildCollectionTitle("SNIPER RIFLES"),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildGunContainer(AssetPath.bg_container1, "OPERATOR",
                    AssetPath.operator, 230.h),
                _buildGunContainer(AssetPath.bg_container3, "MARSHAL",
                    AssetPath.marshal, 240.h),
              ],
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildGunContainer(
                    AssetPath.bg_container3, "OUTLAW", AssetPath.outlaw, 220.h),
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

Widget _buildGunContainer(@required String ContainerImage,
    @required String GunName, @required String GunImage, double? GunHeight) {
  return Stack(
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
  );
}

Widget _buildCollectionTitle(String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: CustomButton(height: 45, width: double.infinity, text: title),
  );
}
