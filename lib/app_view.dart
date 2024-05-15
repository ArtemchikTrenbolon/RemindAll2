import 'package:flutter/material.dart';
import 'package:flutter_app3/pages/first_page.dart';
import 'package:flutter_app3/screen/home/blocs/get_note_bloc.dart';
import 'package:flutter_app3/screen/home/views/home_screen.dart';
import 'package:flutter_app3/theme/theme_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_repository/note_repository.dart';
import 'package:provider/provider.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "RemindAll",
      theme: lightMode, // Используем светлую тему по умолчанию
      home: BlocProvider(
        create: (context) => GetNoteBloc(
          FirebaseNoteRepo()
        )..add(GetNote()),
        child: HomeScreen(),
      ),
    );
  }
}

// Тема светлого режима
ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
    background: Colors.grey.shade300,
    primary: Colors.grey.shade200,
    secondary: Colors.grey.shade400,
    onBackground: Colors.black,
    inversePrimary: Colors.grey.shade800,
  ),
);

// Тема темного режима
ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: Colors.grey.shade900,
    primary: Colors.grey.shade800,
    secondary: Colors.grey.shade700,
    onBackground: Colors.white,
    inversePrimary: Colors.grey.shade300,
  ),
);
