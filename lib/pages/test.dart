// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_app3/pages/profile_page.dart';
// import 'package:flutter_app3/pages/setting_page.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
//
// import '../components/bottom_nav_bar.dart';
// import '../components/my_list_tile.dart';
// import '../models/note.dart';
// import '../models/note_database.dart';
// import 'home_page.dart';
//
// class TestPage extends StatefulWidget{
//   const TestPage({super.key});
//
//   @override
//   State<TestPage> createState() => _TestPageState();
// }
//
// class _TestPageState extends State<TestPage> {
//   TextEditingController textController = TextEditingController();
//
//   @override
//   void initState() {
//     Provider.of<NoteDataBase>(context, listen: false).fetchNotes();
//
//     super.initState();
//   }
//
//   void openNewBox() {
//     showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text("New Note"),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 controller: textController,
//                 decoration: InputDecoration(hintText: "Note"),
//               ),
//             ],
//           ),
//           actions: [
//             cancelButton(),
//             createNewButton(),
//           ],
//         ),
//     );
//   }
//
//   void openEditBox(Note note) {
//
//     String existingNote = note.text;
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text("Edit Note"),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(
//               controller: textController,
//               decoration: InputDecoration(hintText: existingNote),
//             ),
//           ],
//         ),
//         actions: [
//           cancelButton(),
//
//           editNoteButton(note),
//         ],
//       ),
//     );
//   }
//
//   void openDeleteBox(Note note) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text("Delete Note?"),
//
//         actions: [
//           cancelButton(),
//
//           deleteNoteButton(note.id),
//         ],
//       ),
//     );
//   }
//   @override
//   Widget build(BuildContext context){
//     return Consumer<NoteDataBase>(builder: (context, value, child) => Scaffold(
//       floatingActionButton: FloatingActionButton(
//         onPressed: openNewBox,
//         child: Icon(Icons.add),
//         ),
//       body: ListView.builder(
//           itemBuilder: (context, index) {
//             Note individualNote = value.allNotes[index];
//
//             return MyListTile(
//               title: individualNote.text,
//                 onEditPressed: (context) => openEditBox(individualNote),
//                 onDeletePressed: (context) => openDeleteBox(individualNote),
//               );
//             },
//             ),
//       ),
//       );
//   }
//
//   Widget cancelButton() {
//     return MaterialButton(
//         onPressed: () async{
//           Navigator.pop(context);
//           textController.clear();
//         },
//       child: Text("Cancel"),
//     );
//   }
//
//   Widget createNewButton() {
//     return MaterialButton(
//       onPressed: () async {
//         if(textController.text.isNotEmpty)
//           {
//             Navigator.pop(context);
//
//             Note newNote = Note(
//                 text: textController.text);
//
//             await context.read<NoteDataBase>().addNote(newNote);
//
//             textController.clear();
//           }
//       },
//       child: Text("Save"),
//     );
//   }
//
//   Widget editNoteButton(Note note) {
//     return MaterialButton(
//         onPressed: () async {
//           if(textController.text.isNotEmpty){
//             Navigator.pop(context);
//
//             Note updatedNote = Note(
//                 text: textController.text.isNotEmpty
//                     ? textController.text
//                     : textController.text,
//             );
//
//           int existingId = note.id;
//
//           await context
//           .read<NoteDataBase>()
//           .updateNote(existingId, updatedNote);
//           }
//         },
//       child: Text("Save"),
//         );
//   }
//
//   Widget deleteNoteButton(int id) {
//     return MaterialButton(
//       onPressed: () async {
//           Navigator.pop(context);
//           await context
//               .read<NoteDataBase>()
//               .deleteNote(id);
//         },
//     );
//   }
// }