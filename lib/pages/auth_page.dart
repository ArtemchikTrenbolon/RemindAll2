import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:RemindAll/pages/first_page.dart';
import 'package:RemindAll/pages/home_page.dart';
import 'package:RemindAll/pages/login_or_register_page.dart';
import 'package:RemindAll/pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:RemindAll/screen/home/views/home_screen.dart';
import 'package:RemindAll/screen/home/views/main_screen.dart';


class AuthPage extends StatelessWidget{
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData){
              return HomeScreen();
            }

            else {
              return LoginOrRegisterPage();
            }
        },
      ),
    );
  }
}