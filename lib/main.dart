
import 'package:flutter/material.dart';
import 'package:flutter_app3/models/note_database.dart';
import 'package:flutter_app3/pages/first_page.dart';
import 'package:flutter_app3/pages/home_page.dart';
import 'package:flutter_app3/pages/profile_page.dart';
import 'package:flutter_app3/pages/setting_page.dart';
import 'package:flutter_app3/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app3/main.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDataBase.initialize();


  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => NoteDataBase()),
          ChangeNotifierProvider(create: (context) => ThemeProvider())
        ],
        child: const MyApp(),
    ), 
  );
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  MainPage(),
      theme: Provider.of<ThemeProvider>(context).themeData,
      routes: {
        '/firstpage': (context) => MainPage(),
        '/homepage': (context) => HomePage(),
        '/settingspage': (context) => SettingPage(),
        '/profilepage': (context) => ProfilePage(),
      },
        );
  }
}



