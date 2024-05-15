import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app3/firebase_options.dart';
import 'package:flutter_app3/models/note_database.dart';
import 'package:flutter_app3/pages/auth_page.dart';
import 'package:flutter_app3/pages/event_page.dart';
import 'package:flutter_app3/pages/first_page.dart';
import 'package:flutter_app3/pages/home_page.dart';
import 'package:flutter_app3/pages/login_or_register_page.dart';
import 'package:flutter_app3/pages/profile_page.dart';
import 'package:flutter_app3/pages/setting_page.dart';
import 'package:flutter_app3/simple_bloc_observer.dart';
import 'package:flutter_app3/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app3/main.dart';

import 'api/firebase_api.dart';
import 'components/add_notes.dart';
//
//
// void main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//   await NoteDataBase.initialize();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   await FirebaseApi().initNotification();
//
//
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (context) => NoteDataBase()),
//         ChangeNotifierProvider(create: (context) => ThemeProvider())
//       ],
//       child: const MyApp(),
//     ),
//   );
// }
//
// class MyApp extends StatelessWidget{
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context){
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home:  AuthPage(),
//       theme: Provider.of<ThemeProvider>(context).themeData,
//       routes: {
//         // '/firstpage': (context) => MainPage(),
//         // '/homepage': (context) => MainPage(),
//         '/eventpage': (context) => EventPage(),
//         '/settingspage': (context) => SettingPage(),
//         '/profilepage': (context) => ProfilePage(),
//       },
//     );
//   }
// }

import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'api/firebase_api.dart';
import 'app.dart';
import 'components/user_profile.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotification();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NoteDataBase()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => UserProfile()),
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
      home:  AuthPage(),
      theme: Provider.of<ThemeProvider>(context).themeData,
      routes: {
        // '/firstpage': (context) => MainPage(),
        // '/homepage': (context) => MainPage(),
        '/eventpage': (context) => EventPage(),
        '/settingspage': (context) => SettingPage(),
        '/profilepage': (context) => ProfilePage(),
      },
    );
  }
}