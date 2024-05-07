import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app3/pages/profile_page.dart';
import 'package:flutter_app3/pages/setting_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../components/bottom_nav_bar.dart';
import '../models/firestore.dart';
import '../models/note.dart';
import '../models/note_database.dart';
import 'home_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButton: FloatingActionButton(
        onPressed: openNoteBox,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 25.0),
            child: Text(
              'RemindAll',
              style: GoogleFonts.dmSerifText(
                fontSize: 40,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _auth.currentUser != null
                  ? firestoreService.getNotesStream(_auth.currentUser!.uid)
                  : null,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List notesList = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: notesList.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot document = notesList[index];
                      String docID = document.id;

                      Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                      String noteText = data['note'];

                      return Slidable(// Используем контроллер Slidable
                        endActionPane: ActionPane(
                          motion: const StretchMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) =>
                                  openNoteBox(docID: docID, initialText: noteText),
                              icon: Icons.edit,
                              backgroundColor: Colors.green,
                            ),
                            SlidableAction(
                              onPressed: (context) =>
                                  firestoreService.deleteNote(docID, _auth.currentUser!.uid),
                              icon: Icons.delete,
                              backgroundColor: Colors.red,
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            ListTile(
                              title: Text(
                                noteText,
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                ),
                              ),
                              trailing: SizedBox(),
                            ),
                            Positioned(
                              right: 0,
                              child: _controller != null ? Lottie.network(
                                "https://lottie.host/ce63bd6d-8a18-4018-bba7-ab874fa7ea23/YnNHhvo830.json",
                                width: 50,
                                height: 50,
                                controller: _controller,
                                onLoaded: (composition) {
                                  _controller
                                    ..duration = composition.duration
                                    ..forward();
                                },
                              ) : Container(),
                            ),
                          ],
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
    );
  }
}