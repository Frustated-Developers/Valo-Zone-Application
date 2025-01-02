import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Login_background.png'),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Horizontal dividers
              Container(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 60),
                    Divider(
                      color: Colors.white,
                      thickness: 1,
                    ),
                    SizedBox(height: 60),
                    Divider(
                      color: Colors.white,
                      thickness: 1,
                    ),
                  ],
                ),
              ),

              // Vertical dividers
              Container(
                height: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 10),
                    Container(
                      height: double.infinity,
                      child: VerticalDivider(
                        color: Colors.white,
                        thickness: 1,
                      ),
                    ),
                    SizedBox(width: 60),
                    Container(
                      height: double.infinity,
                      child: VerticalDivider(
                        color: Colors.white,
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 50,
                left: 10,
                child: SizedBox(
                  width: 100, // Adjust size as needed
                  height: 100, // Adjust size as needed
                  child: Image.asset('assets/icons/Valo.png'),
                ),
              ),
              Positioned(
                  bottom: -760,
                  left: -300,
                  child: Image.asset('assets/characters/sage.png')),

              Positioned(
                top: 112,
                right: 20,
                child: Text(
                  "You are given 13 rounds to attack and \ndefend your side with fierce \nmarksman skills and tactical abilities",
                  maxLines: 3,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
