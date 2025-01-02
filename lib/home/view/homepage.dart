import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:valo_zone/utils/AppColors.dart';
import 'package:valo_zone/utils/Assets_path.dart';
import 'package:valo_zone/utils/reusable_widgets/Search_box.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String searchText = "";
  int _selectedIndex = 0;
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.homepageBackground,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            backgroundColor: AppColors.homepageBackground,
            expandedHeight: 60,
            leading: Image.asset(width: 100, height: 100, AssetPath.ic_valo),
            actions: [CircleAvatar(radius: 20), SizedBox(width: 20)],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Get Your \nFavourite Agent",
                    style: TextStyle(
                      fontFamily: "Pennypacker",
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.whiteText,
                    ),
                  ),
                  SizedBox(height: 20),
                  SearchBox(
                    width: double.infinity,
                    onChanged: (value) {
                      setState(() {
                        searchText = value.toLowerCase();
                      });
                    },
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(
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
          shape: CircleBorder(),
          child: Image.asset(
            AssetPath.ic_valo,
            width: 60,
            height: 60,
          ),
          onPressed: () {},
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
              SizedBox(
                height: 20,
              ),
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

        // activeColor: AppColors.SelectedIconColor,
        // inactiveColor: Colors.white,
        backgroundColor: AppColors.buttonBlue,
        onTap: _onItemTapped,
        height: 65,
        // iconSize: 30,
        shadow: Shadow(
          color: Colors.black.withOpacity(0.2),
          offset: Offset(0, -3),
          blurRadius: 6,
        ),
      ),
    );
  }

  Widget buildAgentCardsSliver() {
    List<Map<String, String>> agents = [
      {'image': AssetPath.pheonix_card, 'name': "Phoenix"},
      {'image': AssetPath.sage_card, 'name': "Sage"},
      {'image': AssetPath.jett_card, 'name': "Jett"},
      {'image': AssetPath.sova_card, 'name': "Sova"},
      {'image': AssetPath.astra_card, 'name': "Astra"},
      {'image': AssetPath.breach_card, 'name': "Breach"},
      {'image': AssetPath.brimston_card, 'name': "Brimstone"},
      {'image': AssetPath.chamber_card, 'name': "Chamber"},
      {'image': AssetPath.clove_card, 'name': "Clove"},
      {'image': AssetPath.cypher_card, 'name': "Cypher"},
      {'image': AssetPath.deadlock_card, 'name': "Deadlock"},
      {'image': AssetPath.fade_card, 'name': "Fade"},
      {'image': AssetPath.gekko_card, 'name': "Gekko"},
      {'image': AssetPath.kayo_card, 'name': "KAY/O"},
      {'image': AssetPath.killjoy_card, 'name': "Killjoy"},
      {'image': AssetPath.neon_card, 'name': "Neon"},
      {'image': AssetPath.omen_card, 'name': "Omen"},
      {'image': AssetPath.raja_card, 'name': "Raja"},
      {'image': AssetPath.raze_card, 'name': "Raze"},
      {'image': AssetPath.reyna_card, 'name': "Reyna"},
      {'image': AssetPath.skye_card, 'name': "Skye"},
      {'image': AssetPath.viper_card, 'name': "Viper"},
      {'image': AssetPath.vyse_card, 'name': "Vyse"},
      {'image': AssetPath.yoru_card, 'name': "Yoru"},
    ];

    List<Map<String, String>> filteredAgents = agents
        .where((agent) => agent['name']!.toLowerCase().contains(searchText))
        .toList();

    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
    return Container(
      key: ValueKey(agentName),
      child: Image.asset(
        imagePath,
        width: MediaQuery.of(context).size.width * 0.45,
        height: 300,
        fit: BoxFit.cover,
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
