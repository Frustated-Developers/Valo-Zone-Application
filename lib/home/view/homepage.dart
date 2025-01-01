import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0F1923),
      appBar: AppBar(
        title: Text("ValoZone"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Stack(
                children: [
                  SvgPicture.asset(
                    "assets/images/Rectangle 1.svg", // Your SVG file path
                    fit: BoxFit.fill,
                    color: Color(0xFFE5F6F6),
                  ),
                  Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Text(
                              "S A G E",
                              style: TextStyle(
                                  color: Colors.grey[200],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 75),
                            ),
                            Text(
                              "S A G E",
                              style: TextStyle(
                                  color: Colors.grey[200],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 75),
                            ),
                            Text(
                              "S A G E",
                              style: TextStyle(
                                  color: Colors.grey[200],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 75),
                            ),
                            Text(
                              "S A G E",
                              style: TextStyle(
                                  color: Colors.grey[200],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 75),
                            ),
                          ],
                        ),
                      ),
                      Align(
                          alignment: Alignment.topCenter,
                          child: Image.asset("assets/characters/sage.png"))
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
