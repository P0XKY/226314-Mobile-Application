import 'package:application/AQIPage.dart';
import 'package:application/Home.dart';
import 'package:application/Longin.dart';
import 'package:application/PhayaoAirPage.dart';
import 'package:application/contact.dart';
import 'package:application/more.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const PhayaoAirPage(),
        '/Login': (context) => const LoginPage(),
        '/more': (context) => AdditionalPage(),

      },
    );
  }
}


