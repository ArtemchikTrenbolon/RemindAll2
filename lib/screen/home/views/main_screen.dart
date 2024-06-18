import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:RemindAll/components/user_profile.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:note_repository/note_repository.dart';
import '../../../components/edit_notes.dart';
import '../../../models/firestore.dart';
import '../../../pages/profile_page.dart';
import '../../../pages/setting_page.dart';
final FirebaseNoteRepo firebaseNoteRepo = FirebaseNoteRepo();
class MainScreen extends StatelessWidget {
  final List<Note> note;


  const MainScreen(this.note, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    note.sort((a, b) => b.date.compareTo(a.date));
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
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
                    icon:  Icon(CupertinoIcons.settings,
                    color: Theme.of(context).colorScheme.inversePrimary,
                    )
                ),
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
            const SizedBox(height: 20),
            Expanded(
              child: StreamBuilder<List<Note>>(
                stream: firebaseNoteRepo.getNoteStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else {
                    final notes = snapshot.data ?? [];
                    return ListView.builder(
                      itemCount: notes.length,
                      itemBuilder: (context, int i) {
                        return Slidable(
                          endActionPane: ActionPane(
                            motion: const StretchMotion(),
                            extentRatio: 0.3,
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 16.0),
                                  child: SlidableAction(
                                    borderRadius: BorderRadius.circular(8),
                                    onPressed: (context) async {
                                      try {
                                        await firebaseNoteRepo.deleteNote(notes[i].expenseId);
                                      } catch (e) {
                                        print('Error deleting note: $e');
                                      }
                                    },
                                    icon: Icons.delete,
                                    backgroundColor: Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditPage(note: notes[i]),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Container(
                                                width: 50,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color:  Color(notes[i].category.color)
                                                       // Use white color if icon is null or empty
                                                ),
                                                child: notes[i].category.icon != null && notes[i].category.icon.isNotEmpty
                                                    ? Image.asset(
                                                  "icons/${notes[i].category.icon}.png",
                                                  scale: 4,
                                                  color: Colors.white,
                                                )
                                                    : Container(
                                                  width: 35,
                                                  height: 35,
                                                  child: Center(
                                                    child: Icon(
                                                      Icons.notifications,
                                                      color: Colors.white,
                                                      size: 30,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(width: 12),
                                          Text(
                                            notes[i].nameNote,
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Theme.of(context).colorScheme.inversePrimary,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            notes[i].category.name,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Theme.of(context).colorScheme.secondary,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          Text(
                                            DateFormat("dd/MM/yyyy").format(notes[i].date),
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Theme.of(context).colorScheme.secondary,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          Text(
                                            DateFormat("HH:mm").format(notes[i].date),
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Theme.of(context).colorScheme.secondary,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
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

            // SizedBox(height: 15),
            // Expanded(
            //   child: StreamBuilder<QuerySnapshot>(
            //     stream: _auth.currentUser != null
            //         ? firestoreService.getNotesStream(_auth.currentUser!.uid)
            //         : null,
            //     builder: (context, snapshot) {
            //       if (snapshot.hasData) {
            //         List notesList = snapshot.data!.docs;
            //         return ListView.builder(
            //           itemExtent: 75,
            //           itemCount: notesList.length,
            //           itemBuilder: (context, index) {
            //             DocumentSnapshot document = notesList[index];
            //             String docID = document.id;
            //
            //             Map<String, dynamic> data =
            //             document.data() as Map<String, dynamic>;
            //             String noteText = data['note'];
            //
            //             return Slidable(
            //               endActionPane: ActionPane(
            //                 motion: const StretchMotion(),
            //                 children: [
            //                   SlidableAction(
            //                     borderRadius: BorderRadius.circular(8),
            //                     onPressed: (context) => openNoteBox(
            //                         docID: docID, initialText: noteText),
            //                     icon: Icons.edit,
            //                     backgroundColor: Colors.green,
            //                   ),
            //                   SlidableAction(
            //                     borderRadius: BorderRadius.circular(8),
            //                     onPressed: (context) => firestoreService
            //                         .deleteNote(docID, _auth.currentUser!.uid),
            //                     icon: Icons.delete,
            //                     backgroundColor: Colors.red,
            //                   ),
            //                 ],
            //               ),
            //               child: Container(
            //                 decoration: BoxDecoration(
            //                   color: Theme.of(context).colorScheme.primary,
            //                   borderRadius: BorderRadius.circular(8),
            //                 ),
            //                 margin: EdgeInsets.only(
            //                 ),
            //                 child: ListTile(
            //                   title: Text(
            //                     noteText,
            //                     style: TextStyle(
            //                       color: Theme.of(context)
            //                           .colorScheme
            //                           .inversePrimary,
            //                     ),
            //                   ),
            //                   trailing: SizedBox(
            //                     width: 50,
            //                     height: 50,
            //                     child: _controller != null
            //                         ? Lottie.network(
            //                       "https://lottie.host/ce63bd6d-8a18-4018-bba7-ab874fa7ea23/YnNHhvo830.json",
            //                       controller: _controller,
            //                       onLoaded: (composition) {
            //                         _controller
            //                           ..duration =
            //                               composition.duration
            //                           ..forward();
            //                       },
            //                     )
            //                         : Container(),
            //                   ),
            //                 ),
            //               ),
            //             );
            //           },
            //         );
            //       } else {
            //         return const Text("No notes...");
            //       }
            //     },
            //   ),
            // ),

