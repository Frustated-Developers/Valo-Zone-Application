import 'package:flutter/material.dart';
import 'package:valo_zone/utils/AppColors.dart';

class Customloginbutton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String buttonText; // Added onPressed parameter
  const Customloginbutton({
    super.key,
    this.onPressed,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const SizedBox(
          width: 150,
          child: Divider(
            thickness: 1,
            color: Colors.black,
          ),
        ),
        const Positioned(
          left: 10,
          child: SizedBox(
            height: 150,
            child: VerticalDivider(
              thickness: 1,
              color: Colors.black,
            ),
          ),
        ),
        const Positioned(
          right: 10,
          child: SizedBox(
            height: 150,
            child: VerticalDivider(
              thickness: 1,
              color: Colors.black,
            ),
          ),
        ),
        const Positioned(
          bottom: -1,
          child: SizedBox(
            width: 150,
            child: Divider(
              thickness: 1,
              color: Colors.black,
            ),
          ),
        ),
        const Positioned(
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
        const Positioned(
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
          child: GestureDetector(
            onTap: onPressed,
            child: Container(
              color: AppColors.SelectedIconColor,
              height: 50,
              width: 380,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
          child: SizedBox(
            height: 50,
            width: 380,
            child: Center(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: GestureDetector(
                    onTap: onPressed,
                    child: Text(
                      buttonText,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  )),
            ),
          ),
        ),
      ],
    );
  }
}
