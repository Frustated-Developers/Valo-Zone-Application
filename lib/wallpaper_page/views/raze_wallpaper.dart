import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:valo_zone/utils/AppColors.dart';
import 'package:valo_zone/utils/Assets_path.dart';
import 'package:valo_zone/utils/reusable_widgets/appBar.dart';
import 'package:valo_zone/wallpaper_page/widget/full_image_page.dart';

class RazeWallpaper extends StatefulWidget {
  const RazeWallpaper({super.key});

  @override
  State<RazeWallpaper> createState() => _RazeWallpaperState();
}

class _RazeWallpaperState extends State<RazeWallpaper> {
  Future<List<String>> fetchImages() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('raze').get();

    final List<String> imageUrls =
        snapshot.docs.map((doc) => doc.get('wallpaper') as String).toList();

    return imageUrls;
  }

  Widget buildShimmerContainer(
      {required double height, required double width}) {
    return Shimmer.fromColors(
      baseColor: AppColors.dullWhiteText.withOpacity(0.3),
      highlightColor: AppColors.whiteText.withOpacity(0.1),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.homepageBackground,
      appBar: appBar(
        showImage: true,
        title: "Raze",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top featured wallpaper
            Padding(
              padding: EdgeInsets.all(10.w),
              child: FutureBuilder<List<String>>(
                future: fetchImages(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return buildShimmerContainer(
                      height: 200,
                      width: double.infinity,
                    );
                  }

                  return Container(
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(AssetPath.raze_wallpaper),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  );
                },
              ),
            ),

            // Grid of wallpapers
            FutureBuilder<List<String>>(
              future: fetchImages(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Column(
                    children: List.generate(4, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            buildShimmerContainer(
                              height: MediaQuery.of(context).size.height * 0.35,
                              width: MediaQuery.of(context).size.width * 0.46,
                            ),
                            buildShimmerContainer(
                              height: MediaQuery.of(context).size.height * 0.35,
                              width: MediaQuery.of(context).size.width * 0.46,
                            ),
                          ],
                        ),
                      );
                    }),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  final List<String> imageUrls = snapshot.data!;
                  final int itemCount = (imageUrls.length / 2).ceil();

                  return Column(
                    children: List.generate(itemCount, (index) {
                      final int startIndex = index * 2;
                      final int endIndex = startIndex + 1;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            buildContainer(imageUrls, startIndex),
                            buildContainer(imageUrls, endIndex),
                          ],
                        ),
                      );
                    }),
                  );
                } else {
                  return const Center(child: Text('No wallpapers available'));
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildContainer(List<String> imageUrls, int index) {
    if (index < imageUrls.length) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FullImagePage(imageUrl: imageUrls[index]),
            ),
          );
        },
        child: Container(
          height: MediaQuery.of(context).size.height * 0.35,
          width: MediaQuery.of(context).size.width * 0.46,
          decoration: BoxDecoration(
            color: AppColors.buttonBlue.withOpacity(0.3),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imageUrls[index],
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return buildShimmerContainer(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: MediaQuery.of(context).size.width * 0.46,
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: AppColors.buttonBlue.withOpacity(0.3),
                  child: const Center(
                    child: Icon(
                      Icons.error_outline,
                      color: Colors.white,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
