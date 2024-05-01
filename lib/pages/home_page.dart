import 'package:flutter/material.dart';
import 'package:flutter_app3/pages/profile_page.dart';
import 'package:flutter_app3/pages/setting_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../components/bottom_nav_bar.dart';
import '../models/note.dart';
import '../models/note_database.dart';
import 'home_page.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final textController = TextEditingController();

  @override
  void initState(){
    super.initState();

    readNotes();
  }
  //create a note
  void createNote() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textController,
        ),
        actions: [
          MaterialButton(
            onPressed: (){
              context.read<NoteDataBase>().addNote(textController.text);

              textController.clear();

              Navigator.pop(context);
            },
            child: const Text("Create"),
          )
        ],
      ),
    );
  }

  //read notes
  void readNotes() {
    context.read<NoteDataBase>().fetchNotes();
  }

  //update note
  void updateNote(Note note) {
    textController.text = note.text;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Update Note"),
        content: TextField(controller: textController),
        actions: [
          MaterialButton(
            onPressed: () {
              context
                  .read<NoteDataBase>()
                  .updateNote(note.id, textController.text);

              textController.clear();

              Navigator.pop(context);
            },
            child: const Text("Update"),
          )
        ],
      ),
    );
  }

  //delete a note
  void deleteNote(int id) {
    context.read<NoteDataBase>().deleteNote(id);
  }
  @override
  Widget build(BuildContext context){

    final noteDatabase = context.watch<NoteDataBase>();

    List<Note> currentNotes =  noteDatabase.currentNotes;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButton: FloatingActionButton(
        onPressed: createNote,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: Icon(Icons.add, color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
      body:
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 25.0),
            child: Text(
              'RemindAll',
              style: GoogleFonts.dmSerifText(
                fontSize:40,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: currentNotes.length,
              itemBuilder: (context, index) {
                final note = currentNotes[index];
                return ListTile(
                  title: Text(note.text,
                      style: GoogleFonts.dmSerifText(
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //edit button
                      IconButton(onPressed: () => updateNote(note),
                        icon: Icon(Icons.edit, color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),

                      //delete button
                      IconButton(onPressed: () => deleteNote(note.id),
                        icon: Icon(Icons.delete, color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}