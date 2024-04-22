import 'package:flutter/material.dart';
import 'package:flutter_app3/pages/first_page.dart';
import 'package:flutter_app3/pages/home_page.dart';
import 'package:flutter_app3/pages/profile_page.dart';
import 'package:flutter_app3/pages/second_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirstPage(),
      routes: {
        '/firstpage': (context) => FirstPage(),
        '/homepage': (context) => HomePage(),
        '/settingspage': (context) => SettingPage(),
        '/profilepage': (context) => ProfilePage(),
      },
        );
  }
}



