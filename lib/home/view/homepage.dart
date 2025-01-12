import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:valo_zone/featured/view/featured_home.dart';
import 'package:valo_zone/settings/view/setting_page.dart';
import 'package:valo_zone/utils/AppColors.dart';
import 'package:valo_zone/utils/Assets_path.dart';
import 'package:valo_zone/utils/navigation.dart';
import 'package:valo_zone/utils/reusable_widgets/CustomSilverAppBar.dart';
import 'package:valo_zone/utils/reusable_widgets/Search_box.dart';
import 'package:valo_zone/wallpaper_page/views/astra_wallpaper.dart';
import 'package:valo_zone/wallpaper_page/views/breach_wallpaper.dart';
import 'package:valo_zone/wallpaper_page/views/brimstone_wallpaper.dart';
import 'package:valo_zone/wallpaper_page/views/chamber_wallpaper.dart';
import 'package:valo_zone/wallpaper_page/views/clove_wallpaper.dart';
import 'package:valo_zone/wallpaper_page/views/cypher_wallpaper.dart';
import 'package:valo_zone/wallpaper_page/views/deadlock_wallpaper.dart';
import 'package:valo_zone/wallpaper_page/views/fade_wallpaper.dart';
import 'package:valo_zone/wallpaper_page/views/gekko_wallpaper.dart';
import 'package:valo_zone/wallpaper_page/views/jett_wallpaper.dart';
import 'package:valo_zone/wallpaper_page/views/kayo_wallpaper.dart';
import 'package:valo_zone/wallpaper_page/views/killjoy.dart';
import 'package:valo_zone/wallpaper_page/views/neon_wallpaper.dart';
import 'package:valo_zone/wallpaper_page/views/omen_wallpaper.dart';
import 'package:valo_zone/wallpaper_page/views/phoenix_wallpaper.dart';
import 'package:valo_zone/wallpaper_page/views/raja_wallpaper.dart';
import 'package:valo_zone/wallpaper_page/views/raze_wallpaper.dart';
import 'package:valo_zone/wallpaper_page/views/reyna_wallpaper.dart';
import 'package:valo_zone/wallpaper_page/views/sage_wallpaper.dart';
import 'package:valo_zone/wallpaper_page/views/skye_wallpaper.dart';
import 'package:valo_zone/wallpaper_page/views/sova_wallpaper.dart';
import 'package:valo_zone/wallpaper_page/views/viper_wallpaper.dart';
import 'package:valo_zone/wallpaper_page/views/vyse_wallpaper.dart';
import 'package:valo_zone/wallpaper_page/views/yoru_wallpaper.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String searchText = "";
  int _selectedIndex = 0;
  final User? user = FirebaseAuth.instance.currentUser;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
    getAgentsList().forEach((agent) {});
  }

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
    if (index == 3) {
      _scaffoldKey.currentState?.openEndDrawer();
    }
  }

  List<Map<String, String>> getAgentsList() {
    return [
      {'image': AssetPath.pheonix_card, 'name': "Phoenix"},
      {'image': AssetPath.sage_card, 'name': "Sage"},
      {'image': AssetPath.jett_card, 'name': "Jett"},
      {'image': AssetPath.sova_card, 'name': "Sova"},
      {'image': AssetPath.raze_card, 'name': "Raze"},
      {'image': AssetPath.reyna_card, 'name': "Reyna"},
      {'image': AssetPath.clove_card, 'name': "Clove"},
      {'image': AssetPath.cypher_card, 'name': "Cypher"},
      {'image': AssetPath.gekko_card, 'name': "Gekko"},
      {'image': AssetPath.kayo_card, 'name': "KAY/O"},
      {'image': AssetPath.killjoy_card, 'name': "Killjoy"},
      {'image': AssetPath.neon_card, 'name': "Neon"},
      {'image': AssetPath.skye_card, 'name': "Skye"},
      {'image': AssetPath.yoru_card, 'name': "Yoru"},
      {'image': AssetPath.omen_card, 'name': "Omen"},
      {'image': AssetPath.raja_card, 'name': "Raja"},
      {'image': AssetPath.astra_card, 'name': "Astra"},
      {'image': AssetPath.breach_card, 'name': "Breach"},
      {'image': AssetPath.brimston_card, 'name': "Brimstone"},
      {'image': AssetPath.chamber_card, 'name': "Chamber"},
      {'image': AssetPath.deadlock_card, 'name': "Deadlock"},
      {'image': AssetPath.fade_card, 'name': "Fade"},
      {'image': AssetPath.viper_card, 'name': "Viper"},
      {'image': AssetPath.vyse_card, 'name': "Vyse"},
    ];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: _scaffoldKey,
        endDrawer: SettingsDrawer(),
        onEndDrawerChanged: (isOpened) {
          if (!isOpened) {
            // if drawer is closed
            setState(() {
              _selectedIndex = 0;
            });
          }
        },
        extendBody: true,
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.homepageBackground,
        body: CustomScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            CustomSliverAppBar(
              showTitle: false,
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Get Your \nFavourite Agent",
                      style: TextStyle(
                        fontFamily: "Pennypacker",
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.whiteText,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SearchBox(
                      width: double.infinity,
                      onChanged: (value) {
                        setState(() {
                          searchText = value.toLowerCase();
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(
                left: 15.0,
                right: 15.0,
                bottom: 80.0,
              ),
              sliver: buildAgentCardsSliver(),
            ),
          ],
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
      ),
    );
  }

  Widget buildAgentCardsSliver() {
    List<Map<String, String>> agents = getAgentsList();
    List<Map<String, String>> filteredAgents = agents
        .where((agent) => agent['name']!.toLowerCase().contains(searchText))
        .toList();

    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.65,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) => agentCard(
          filteredAgents[index]['image']!,
          filteredAgents[index]['name']!,
        ),
        childCount: filteredAgents.length,
      ),
    );
  }

  Widget agentCard(String imagePath, String agentName) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        if (agentName == "Phoenix") {
          navigateToAgentWallpaper(context, const PhoenixWallpaper());
        }
        if (agentName == "Sage") {
          navigateToAgentWallpaper(context, const SageWallpaper());
        }
        if (agentName == "Jett") {
          navigateToAgentWallpaper(context, const JettWallpaper());
        }
        if (agentName == "Sova") {
          navigateToAgentWallpaper(context, const SovaWallpaper());
        }
        if (agentName == "Raze") {
          navigateToAgentWallpaper(context, const RazeWallpaper());
        }
        if (agentName == "Reyna") {
          navigateToAgentWallpaper(context, const ReynaWallpaper());
        }
        if (agentName == "Clove") {
          navigateToAgentWallpaper(context, const CloveWallpaper());
        }
        if (agentName == "Cypher") {
          navigateToAgentWallpaper(context, const CypherWallpaper());
        }
        if (agentName == "Gekko") {
          navigateToAgentWallpaper(context, const GekkoWallpaper());
        }
        if (agentName == "KAY/O") {
          navigateToAgentWallpaper(context, const KayoWallpaper());
        }
        if (agentName == "Killjoy") {
          navigateToAgentWallpaper(context, const KilljoyWallpaper());
        }
        if (agentName == "Neon") {
          navigateToAgentWallpaper(context, const NeonWallpaper());
        }
        if (agentName == "Skye") {
          navigateToAgentWallpaper(context, const SkyeWallpaper());
        }
        if (agentName == "Yoru") {
          navigateToAgentWallpaper(context, const YoruWallpaper());
        }
        if (agentName == "Omen") {
          navigateToAgentWallpaper(context, const OmenWallpaper());
        }
        if (agentName == "Raja") {
          navigateToAgentWallpaper(context, const RajaWallpaper());
        }
        if (agentName == "Astra") {
          navigateToAgentWallpaper(context, const AstraWallpaper());
        }
        if (agentName == "Breach") {
          navigateToAgentWallpaper(context, const BreachWallpaper());
        }
        if (agentName == "Brimstone") {
          navigateToAgentWallpaper(context, const BrimstoneWallpaper());
        }
        if (agentName == "Chamber") {
          navigateToAgentWallpaper(context, const ChamberWallpaper());
        }
        if (agentName == "Deadlock") {
          navigateToAgentWallpaper(context, const DeadlockWallpaper());
        }
        if (agentName == "Fade") {
          navigateToAgentWallpaper(context, const FadeWallpaper());
        }
        if (agentName == "Viper") {
          navigateToAgentWallpaper(context, const ViperWallpaper());
        }
        if (agentName == "Vyse") {
          navigateToAgentWallpaper(context, const VyseWallpaper());
        }
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          imagePath,
          width: MediaQuery.of(context).size.width * 0.45,
          height: 300,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class NavigationItem {
  final IconData icon;
  final String? svgPath;
  final String? selectedSvgPath;
  final String label;

  NavigationItem({
    required this.icon,
    this.svgPath,
    this.selectedSvgPath,
    required this.label,
  });
}
