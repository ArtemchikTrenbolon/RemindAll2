import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app3/components/user_profile.dart';
import 'package:intl/intl.dart';
import 'package:note_repository/note_repository.dart';
import '../../../models/firestore.dart';
import '../../../pages/profile_page.dart';
import '../../../pages/setting_page.dart';

class MainScreen extends StatelessWidget {
  // final UserProfile userProfile;
  final List<Note> note;

  const MainScreen(this.note, {Key? key}) : super(key: key);

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
                child: ListView.builder(
                  itemCount: note.length,
                  itemBuilder: (context, int i) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(12)
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
                                            color: Color(note[i].category.color),
                                            shape: BoxShape.circle
                                        ),
                                      ),
                                      Image.asset(
                                        "icons/${note[i].category.icon}.png",
                                        scale: 2,
                                        color: Colors.white,
                                      )
                                    ],
                                  ),
                                  SizedBox(width: 12),
                                  Text(
                                      note[i].category.name,
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Theme.of(context).colorScheme.inversePrimary,
                                          fontWeight: FontWeight.w500
                                      )
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                      note[i].category.name,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Theme.of(context).colorScheme.secondary,
                                          fontWeight: FontWeight.w400
                                      )
                                  ),
                                  Text(
                                      DateFormat("dd/MM/yyyy").format(note[i].date),
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Theme.of(context).colorScheme.secondary,
                                          fontWeight: FontWeight.w400
                                      )
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )
            ),

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
          ],
        ),
      ),
    );
  }
}
