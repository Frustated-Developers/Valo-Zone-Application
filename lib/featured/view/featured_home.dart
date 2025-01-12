
import 'package:flutter/material.dart';
import 'package:valo_zone/utils/Assets_path.dart';

class FeaturedHome extends StatelessWidget {
  const FeaturedHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage(AssetPath.featureBackground,),fit: BoxFit.fitWidth)
        ),
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

                    ),
                  ),
                  const CircleAvatar(radius: 20),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
