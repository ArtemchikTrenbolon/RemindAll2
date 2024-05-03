import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app3/components/text_box.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget{
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _SettingPageState();
}

class _SettingPageState extends State<ProfilePage>{

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }
  final user = FirebaseAuth.instance.currentUser!;

  Future<void> editProfile(String field) async{

  }

  @override
  Widget build(BuildContext){
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: signUserOut, icon: Icon(Icons.logout))],
        title: Text("Страница пользователя"),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        children: [
          SizedBox(height: 50),

          Image.asset(
            'lib/images/personal.png',

            width: 100,
            height: 100,
          ),

          Text(
            user.email!,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[700]),
          ),

          SizedBox(height: 50),

          Padding(
              padding: EdgeInsets.only(left: 25.0),
              child: Text(
                'Подробности',
                style: TextStyle(color: Colors.grey[600])
              ),
          ),
          MyTextBox(
              text: 'Danil',
              sectionName: 'username',
              onPressed: () => editProfile('username'),
          ),

        ],

      ),

      );
  }
}