import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../models/note_database.dart';
import 'package:flutter_app3/components/text_box.dart';
import 'package:flutter_app3/theme/theme_provider.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  final user = FirebaseAuth.instance.currentUser!;
  final userCollection = FirebaseFirestore.instance.collection("Users");

  Future<void> editProfile(String field) async {
    String newValue = "";
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          "Edit $field",
          style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
        ),
        content: TextField(
          autofocus: true,
          style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
          decoration: InputDecoration(
            hintText: "Enter new $field",
            hintStyle: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
          ),
          onChanged: (value) {
            newValue = value;
          },
        ),
        actions: [
          TextButton(
            child: Text(
              'Закрыть',
              style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
            ),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: Text(
              'Сохранить',
              style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
            ),
            onPressed: () => Navigator.of(context).pop(newValue),
          ),
        ],
      ),
    );

    if (newValue.trim().length > 0) {
      await userCollection.doc(user.email).update({field: newValue});
    }
  }

  @override
  Widget build(BuildContext) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Настройки"),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection("Users").doc(user.email).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final userData = snapshot.data!.data() as Map<String, dynamic>;

            return ListView(
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
                  style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
                ),
                SizedBox(height: 50),
                Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: Text(
                    'Подробности',
                    style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                ),
                MyTextBox(
                  text: userData['username'],
                  sectionName: 'Ваше имя',
                  onPressed: () => editProfile('username'),
                ),
                // SizedBox(height: 20),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                //   child: Container(
                //     decoration: BoxDecoration(
                //       color: Theme.of(context).colorScheme.primary,
                //       borderRadius: BorderRadius.circular(12),
                //     ),
                //     padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                //     margin: EdgeInsets.only(top: 10),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         Text(
                //           "Dark Mode",
                //           style: TextStyle(
                //             fontWeight: FontWeight.bold,
                //             fontSize: 18,
                //             color: Theme.of(context).colorScheme.inversePrimary,
                //           ),
                //         ),
                //         CupertinoSwitch(
                //           value: Provider.of<ThemeProvider>(context, listen: false).isDarkMode,
                //           onChanged: (value) => Provider.of<ThemeProvider>(context, listen: false).toggleTheme(),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                SizedBox(height: 350),
                Center(
                  child: TextButton(
                    onPressed: signUserOut,
                    child: Text(
                      'Выйти из аккаунта',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
