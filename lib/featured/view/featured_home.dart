import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:valo_zone/home/view/homepage.dart';
import 'package:valo_zone/settings/view/setting_page.dart';
import 'package:valo_zone/utils/AppColors.dart';
import 'package:valo_zone/utils/Assets_path.dart';
import 'package:valo_zone/utils/navigation.dart';
import 'package:valo_zone/wallpaper_page/views/chamber_wallpaper.dart';
import 'package:valo_zone/weapons/view/weapons.dart';

class FeaturedHome extends StatefulWidget {
  const FeaturedHome({super.key});

  @override
  State<FeaturedHome> createState() => _FeaturedHomeState();
}

class _FeaturedHomeState extends State<FeaturedHome> {
  final User? user = FirebaseAuth.instance.currentUser;
  String? userPhotoURL;
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    getUserPhoto();
  }

  void getUserPhoto() {
    if (user != null && user!.photoURL != null) {
      setState(() {
        _selectedIndex = -1;
        userPhotoURL = user!.photoURL;
      });
    }
  }

  final List<NavigationItem> navigationItems = [
    NavigationItem(
      icon: Icons.home,
      svgPath: AssetPath.ic_home,
      selectedSvgPath: AssetPath.ic_home_red,
      label: 'Home',
    ),
    NavigationItem(
      icon: Icons.search,
      svgPath: AssetPath.ic_wall,
      selectedSvgPath: AssetPath.ic_wall_red,
      label: 'Wallpaper',
    ),
    NavigationItem(
      icon: Icons.query_stats_rounded,
      label: 'Weapon',
    ),
    NavigationItem(
      icon: Icons.settings,
      label: 'Setting',
    ),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ChamberWallpaper(),
        ),
      ).then((_) {
        setState(() {
          _selectedIndex = 0;
        });
      });
    }
    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const WeaponsPage(),
        ),
      ).then((_) {
        setState(() {
          _selectedIndex = 0;
        });
      });
    }
    if (index == 3) {
      _scaffoldKey.currentState?.openEndDrawer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBody: true,
      endDrawer: SettingsDrawer(),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  AssetPath.featureBackground,
                ),
                fit: BoxFit.fitWidth)),
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      width: 60,
                      height: 60,
                      AssetPath.ic_valo,
                    ),
                  ),
                  // SizedBox(width: 50,),
                  const Text(
                    "Featured",
                    style: TextStyle(
                        fontFamily: "Pennypacker",
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20),
                  ),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey,
                    foregroundImage: userPhotoURL != null
                        ? NetworkImage(userPhotoURL!)
                        : const AssetImage(AssetPath.dummy_avatar)
                            as ImageProvider,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildContainer(AssetPath.posters, "Posters"),
                _buildContainer(AssetPath.tshirts, "T shirts"),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildContainer(AssetPath.hoodies, "Hoodies"),
                _buildContainer(AssetPath.mugs, "Mugs"),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: 65,
        height: 65,
        child: FloatingActionButton(
          backgroundColor: AppColors.SelectedIconColor,
          shape: const CircleBorder(),
          child: Image.asset(
            AssetPath.ic_valo,
            width: 60,
            height: 60,
          ),
          onPressed: () {
            navigateTo(context, FeaturedHome());
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: navigationItems.length,
        notchMargin: 15,
        notchSmoothness: NotchSmoothness.defaultEdge,
        tabBuilder: (int index, bool isActive) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              navigationItems[index].svgPath != null
                  ? SvgPicture.asset(
                      isActive
                          ? navigationItems[index].selectedSvgPath!
                          : navigationItems[index].svgPath!,
                      height: 24,
                      width: 24,
                      color:
                          isActive ? AppColors.SelectedIconColor : Colors.white,
                    )
                  : Icon(
                      navigationItems[index].icon,
                      color:
                          isActive ? AppColors.SelectedIconColor : Colors.white,
                    ),
              const SizedBox(height: 4),
              Text(
                navigationItems[index].label,
                style: TextStyle(
                  color: isActive ? AppColors.SelectedIconColor : Colors.white,
                  fontSize: 12,
                ),
              ),
            ],
          );
        },
        activeIndex: _selectedIndex,
        gapLocation: GapLocation.center,
        backgroundColor: AppColors.buttonBlue,
        onTap: _onItemTapped,
        height: 65,
        shadow: Shadow(
          color: Colors.black.withOpacity(0.2),
          offset: const Offset(0, -3),
          blurRadius: 6,
        ),
      ),
    );
  }
}

Widget _buildContainer(String image, String title) {
  return Container(
    child: Column(
      children: [
        Stack(
          children: [
            Container(
              child: Opacity(
                  opacity: 0.3,
                  child: Container(
                    color: Colors.white,
                  )),
              height: 250.h,
              width: 160.w,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(image), fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(10),
              ),
              // child: Image.asset(AssetPath.posters,height: 100,),
            ),
            Positioned(
                bottom: 120,
                left: 30,
                child: Text(
                  "Coming soon",
                  style: TextStyle(
                      color: AppColors.whiteText, fontWeight: FontWeight.bold),
                ))
          ],
        ),
        Text(
          title,
          style: TextStyle(
              fontSize: 16,
              color: AppColors.whiteText,
              fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}
