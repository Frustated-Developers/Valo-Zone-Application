import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:valo_zone/utils/Assets_path.dart';
import 'package:valo_zone/utils/reusable_widgets/CustomButton.dart/CustomButton.dart';

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<loginPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/login_background.png'),
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
                  child: Image.asset('assets/Icons/ic_valo.png'),
                ),
              ),
              Positioned(
                  bottom: MediaQuery.of(context).size.height* -1.23,
                  right: MediaQuery.of(context).size.width* -1.93,
                  child:
                  Image.asset('assets/characters/sage1x.png')),

              Positioned(
                top: 104,
                right: 18,
                child: Text(
                  "You are given 13 rounds to attack and \ndefend your side with fierce \nmarksman skills and tactical abilities",
                  maxLines: 3,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: Text("We are Valo Zone",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,),),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: CustomButton(
                        text: "LOGIN"),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
