import 'package:flutter/material.dart';
import 'package:valo_zone/home/view/homepage.dart';
import 'package:valo_zone/login/view/loginPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,


      ),
      routes: {
        "/": (context) => loginPage(),
      },
    );
  }
}