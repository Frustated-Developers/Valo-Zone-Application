import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final Color backgroundColor;
  final String hintText;
  final IconData icon;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  const CustomTextfield({
    super.key,
    this.backgroundColor = const Color(0xFFFB4453),
    this.hintText = 'User Name',
    this.icon = Icons.person_3_outlined,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.validator,
    this.onChanged,
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
        Opacity(
          opacity: 0.8,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
            child: Container(
              color: const Color(0XFFC8C8C8),
              height: 50,
              width: 380,
            ),
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
                child: TextFormField(
                  obscureText: obscureText,
                  keyboardType: keyboardType,
                  onChanged: onChanged,
                  validator: validator,
                  controller: controller,
                  decoration: InputDecoration(
                    icon: Icon(
                      icon,
                      size: 20,
                    ),
                    hintText: hintText,
                    hintStyle: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.normal),
                    iconColor: Colors.white,
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
