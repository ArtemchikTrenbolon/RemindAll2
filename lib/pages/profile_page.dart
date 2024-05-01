import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget{
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _SettingPageState();
}

class _SettingPageState extends State<ProfilePage>{
  @override
  Widget build(BuildContext){
    return Center(
      child: Text('Profile',
        style: GoogleFonts.dmSerifText(
          fontSize:48,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
    );
  }
}