import 'package:flutter/material.dart';
import 'package:flutter_app3/models/note_database.dart';
import 'package:flutter_app3/pages/first_page.dart';
import 'package:flutter_app3/pages/home_page.dart';
import 'package:flutter_app3/pages/profile_page.dart';
import 'package:flutter_app3/pages/setting_page.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDataBase.initialize();


  runApp(
    ChangeNotifierProvider(
      create: (context) => NoteDataBase(),
      child: const MyApp(),
    )
  );
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



