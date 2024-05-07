import 'package:flutter/material.dart';
import 'package:flutter_app3/components/drawer_tile.dart';
import 'package:flutter_app3/pages/profile_page.dart';
import 'package:flutter_app3/pages/setting_page.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MyDrawer extends StatelessWidget{
  MyDrawer({super.key});

  @override
  Widget build(BuildContext context){
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          DrawerHeader(
              child: Icon(
                  Icons.event,
                  color: Theme.of(context).colorScheme.inversePrimary
              )
          ),

          DrawerTitle(
            title: "Домой",
            leading: Icon(
                Icons.home,
                color: Theme.of(context).colorScheme.inversePrimary),
            onTap: () => Navigator.pop(context),
          ),

          DrawerTitle(
            title: "Профиль",
            leading: Icon(
              Icons.person,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProfilePage(),
                  ),
              );
            },
          ),

          DrawerTitle(
            title: "Настройки",
            leading: Icon(
                Icons.settings,
                color: Theme.of(context).colorScheme.inversePrimary
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
