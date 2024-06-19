import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:RemindAll/screen/home/blocs/get_note_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_repository/note_repository.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'api/firebase_api.dart';
import 'components/add_notes.dart';
import 'firebase_options.dart';
import 'models/note_database.dart';
import 'pages/auth_page.dart';
import 'pages/event_page.dart';
import 'pages/profile_page.dart';
import 'pages/setting_page.dart';
import 'simple_bloc_observer.dart';
import 'theme/theme_provider.dart';
import 'services/notifi_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp();

  // Initialize notifications and time zones
  await NotificationService().initNotification();
  tz.initializeTimeZones();

  // Initialize Firebase with platform options
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  Bloc.observer = SimpleBlocObserver();
  // Request notification permission
  var notificationStatus = await Permission.notification.request();
  if (notificationStatus.isDenied || notificationStatus.isPermanentlyDenied) {
    // Handle the scenario where permission is denied
    // For example, show a dialog explaining why the permission is necessary
    // and provide an option for the user to go to app settings
  }

  // Run the app with MultiProvider
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NoteDataBase()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        // Add any other providers needed here
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => GetNoteBloc(FirebaseNoteRepo())..add(GetNote()),
        child: AuthPage(),
      ),
      theme: Provider.of<ThemeProvider>(context).themeData,
      routes: {
        '/eventpage': (context) => EventPage(),
        '/settingspage': (context) => SettingPage(),
        '/profilepage': (context) => ProfilePage(),
      },
    );
  }
}
