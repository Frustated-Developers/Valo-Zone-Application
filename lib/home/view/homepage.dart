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
            CustomButton(
              text: "LEARN THE GAMES",
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: SvgPicture.asset("assets/images/Rectangle 1.svg"),
            )
          ],
        ),
      ),
    );
  }
}
