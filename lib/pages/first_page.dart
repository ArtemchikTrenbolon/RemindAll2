import 'package:flutter/material.dart';
import 'package:flutter_app3/pages/event_page.dart';
import 'package:flutter_app3/pages/login_page.dart';
import 'package:flutter_app3/pages/profile_page.dart';
import 'package:flutter_app3/pages/setting_page.dart';

import '../components/bottom_nav_bar.dart';
import 'home_page.dart';

class MainPage extends StatefulWidget{
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  void navigateBottomBar(int newIndex) {
    setState(() {
      _selectedIndex = newIndex;
    });
  }

  final List<Widget> _pages = [
    HomePage(),

    EventPage(),

    ProfilePage(),

    SettingPage(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MyBottomNavBar(
        onTabChange: (index) => navigateBottomBar(index),
      ),
        body: _pages[_selectedIndex],
    );
  }
}