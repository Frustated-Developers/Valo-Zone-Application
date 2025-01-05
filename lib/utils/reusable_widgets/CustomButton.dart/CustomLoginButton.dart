import 'package:flutter/material.dart';
import 'package:valo_zone/utils/AppColors.dart';

class Customloginbutton extends StatelessWidget {
  final VoidCallback? onPressed; // Added onPressed parameter
  const Customloginbutton({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: 150,
          child: Divider(
            thickness: 1,
            color: Colors.black,
          ),
        ),
        Positioned(
          left: 10,
          child: SizedBox(
            height: 150,
            child: VerticalDivider(
              thickness: 1,
              color: Colors.black,
            ),
          ),
        ),
        Positioned(
          right: 10,
          child: SizedBox(
            height: 150,
            child: VerticalDivider(
              thickness: 1,
              color: Colors.black,
            ),
          ),
        ),
        Positioned(
          bottom: -1,
          child: SizedBox(
            width: 150,
            child: Divider(
              thickness: 1,
              color: Colors.black,
            ),
          ),
        ),
        Positioned(
          top: -1,
          right: 1,
          child: SizedBox(
            width: 150,
            child: Divider(
              thickness: 1,
              color: Colors.black,
            ),
          ),
        ),
        Positioned(
          bottom: -1,
          right: 1,
          child: SizedBox(
            width: 150,
            child: Divider(
              thickness: 1,
              color: Colors.black,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
          child: Container(
            color: AppColors.SelectedIconColor,
            height: 50,
            width: 380,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
          child: Container(
            height: 50,
            width: 380,
            child: Center(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    'LOGIN',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  )),
            ),
          ),
        ),
      ],
    );
  }
}
