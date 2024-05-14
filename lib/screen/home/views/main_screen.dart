import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lottie/lottie.dart';

import '../../../models/firestore.dart';
import '../../../pages/profile_page.dart';
import '../../../pages/setting_page.dart';


class MainScreen extends StatefulWidget{
  const MainScreen({Key? key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController textController = TextEditingController();
  final FirestoreService firestoreService = FirestoreService();
  late final AnimationController _controller = AnimationController(vsync: this);

  @override
  void initState() {
    super.initState();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.repeat();
      }
    });
  }

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
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector( // Добавляем GestureDetector для навигации на страницу профиля
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilePage()),
                    );
                  },
                  child: Row(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.yellow[700],
                            ),
                          ),
                          Icon(
                            CupertinoIcons.person_fill,
                            color: Colors.yellow[800],
                          ),
                        ],
                      ),
                      const SizedBox(width: 8,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome!",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.inversePrimary,
                            ),
                          ),
                          Text(
                            "Danil",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.inversePrimary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingPage()),
                  );
                },
                    icon: const Icon(CupertinoIcons.settings)),
              ],
            ),

            SizedBox(height: 30),
            Row(
              children: [
                Text(
                  "Ваши напоминания",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            SizedBox(height: 15),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _auth.currentUser != null
                    ? firestoreService.getNotesStream(_auth.currentUser!.uid)
                    : null,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List notesList = snapshot.data!.docs;
                    return ListView.builder(
                      itemExtent: 75,
                      itemCount: notesList.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot document = notesList[index];
                        String docID = document.id;

                        Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;
                        String noteText = data['note'];

                        return Slidable(
                          endActionPane: ActionPane(
                            motion: const StretchMotion(),
                            children: [
                              SlidableAction(
                                borderRadius: BorderRadius.circular(8),
                                onPressed: (context) => openNoteBox(
                                    docID: docID, initialText: noteText),
                                icon: Icons.edit,
                                backgroundColor: Colors.green,
                              ),
                              SlidableAction(
                                borderRadius: BorderRadius.circular(8),
                                onPressed: (context) => firestoreService
                                    .deleteNote(docID, _auth.currentUser!.uid),
                                icon: Icons.delete,
                                backgroundColor: Colors.red,
                              ),
                            ],
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            margin: EdgeInsets.only(
                            ),
                            child: ListTile(
                              title: Text(
                                noteText,
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                ),
                              ),
                              trailing: SizedBox(
                                width: 50,
                                height: 50,
                                child: _controller != null
                                    ? Lottie.network(
                                  "https://lottie.host/ce63bd6d-8a18-4018-bba7-ab874fa7ea23/YnNHhvo830.json",
                                  controller: _controller,
                                  onLoaded: (composition) {
                                    _controller
                                      ..duration =
                                          composition.duration
                                      ..forward();
                                  },
                                )
                                    : Container(),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Text("No notes...");
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
