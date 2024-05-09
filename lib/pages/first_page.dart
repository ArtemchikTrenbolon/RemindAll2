import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app3/pages/event_page.dart';
import 'package:flutter_app3/pages/home_page.dart';
import 'package:flutter_app3/pages/login_page.dart';
import 'package:flutter_app3/pages/profile_page.dart';
import 'package:flutter_app3/pages/setting_page.dart';

import '../components/add_notes.dart';
import '../models/firestore.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController textController = TextEditingController();
  final FirestoreService firestoreService = FirestoreService();

  int index = 0;
  late Color selectedItem;
  late Color unselectedItem;

  @override
  void initState() {
    super.initState();
  }

  @override
  void openNoteBox({String? docID, String? initialText}) {
    String buttonText = docID == null ? "Создать" : "Изменить";
    String dialogTitle = docID == null ? "Создать заметку" : "Изменить заметку";
    textController.text = initialText ?? '';
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          dialogTitle,
          style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
        content: TextField(
          controller: textController,
          style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
              textController.clear();
            },
            child: const Text("Закрыть"),
          ),
          MaterialButton(
            onPressed: () async {
              final user = _auth.currentUser;
              if (user != null) {
                if (initialText == null) {
                  await firestoreService.addNote(user.uid, textController.text);
                } else {
                  await firestoreService.updateNote(user.uid, docID!, textController.text);
                }
                textController.clear();
                Navigator.pop(context);
              }
            },
            child: Text(buttonText),
          )
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    selectedItem = Colors.white;
    unselectedItem = Colors.grey;
    return Scaffold(
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
        child: SizedBox(
          height: 80,
          child: Theme(
            data: Theme.of(context).copyWith(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              onTap: (value) {
                setState(() {
                  index = value;
                });
              },
              backgroundColor: Colors.black,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    CupertinoIcons.home,
                    color: index == 0 ? selectedItem : unselectedItem,
                  ),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    CupertinoIcons.graph_square_fill,
                    color: index == 1 ? selectedItem : unselectedItem,
                  ),
                  label: "Events",
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: openNoteBox,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.secondary,
              ],
              transform: GradientRotation(pi / 4),
            ),
          ),
          child: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
      body: index == 0 ? HomePage() : EventPage(),
    );
  }
}