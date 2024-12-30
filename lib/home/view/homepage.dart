import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:valo_zone/utils/reusable_widgets/CustomButton.dart/CustomButton.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("data"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Stack(
                children: [
                  SvgPicture.asset(
                    "assets/images/Rectangle 1.svg",
                    height: 250,
                    width: 100,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "S A G E",
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.05),
                            fontSize: 50,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "S A G E",
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.05),
                            fontSize: 50,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "S A G E",
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.05),
                            fontSize: 50,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "S A G E",
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.05),
                            fontSize: 50,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "S A G E",
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.05),
                            fontSize: 50,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
