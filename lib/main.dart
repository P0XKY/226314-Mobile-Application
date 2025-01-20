import 'package:application/AQIPage.dart';
import 'package:application/Home.dart';
import 'package:application/Longin.dart';
import 'package:application/PhayaoAirPage.dart';
import 'package:application/contact.dart';
// import 'package:application/database.dart';
import 'package:application/history.dart';
import 'package:application/more.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState()  => _MyApp();
}

class _MyApp extends State<MyApp> {

  // final databaseapi _databaseapi = databaseapi.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => PhayaoAirPage(),
        '/history': (context) => const historyPage(),
        '/Login': (context) => const LoginPage(),
        '/more': (context) => AdditionalPage(),

      },
    );
  }
}

