import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app3/pages/profile_page.dart';
import 'package:flutter_app3/pages/setting_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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

  void SignIn() {
    readNotes();
  }

  void SignOut() {
    readNotes();
  }
  //create a note
  void createNote() {
    TextEditingController textController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Create Note",
          style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary
          ),
        ),
        content: TextField(
          controller: textController,
          style: TextStyle(
              color: Theme.of(context).colorScheme.inversePrimary
          ),
        ),
        actions: [
          MaterialButton(
            onPressed: (){
              Navigator.pop(context);
              textController.clear();
            },
            child: const Text("Закрыть"),
          ),
          MaterialButton(
            onPressed: (){
              if (textController.text.isNotEmpty){
                context.read<NoteDataBase>().addNote(textController.text);

                textController.clear();

                Navigator.pop(context);
              }
            },
            child: Text("Создать"),
          ),
        ],
      ),
    );
  }

  //read notes
  void readNotes() {
    context.read<NoteDataBase>().fetchNotes();
  }

  //update note
  void updateNote(BuildContext context, Note note) {
    textController.text = note.text;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Update Note",
          style: TextStyle(
              color: Theme.of(context).colorScheme.inversePrimary
          ),
        ),
        content: TextField(
            controller: textController,
          style: TextStyle(
              color: Theme.of(context).colorScheme.inversePrimary
          ),
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              context
                  .read<NoteDataBase>()
                  .updateNote(note.id, textController.text);

              textController.clear();

              Navigator.pop(context);
            },
            child: const Text("Изменить"),
          )
        ],
      ),
    );
  }

  //delete a note
  void deleteNote(BuildContext context, int id) {
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
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Slidable(
                    endActionPane: ActionPane(
                      motion: const StretchMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) => updateNote(context, note),
                          icon: Icons.edit,
                          backgroundColor: Colors.green,
                        ),
                        SlidableAction(
                          onPressed: (context) => deleteNote(context, note.id),
                          icon: Icons.delete,
                          backgroundColor: Colors.red,
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        ListTile(
                          title: Text(
                            note.text,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.inversePrimary,
                            ),
                          ),
                          trailing: SizedBox(), // Пустой SizedBox для выравнивания текста
                        ),
                        Positioned(
                          right: 0, // Выравниваем анимацию справа
                          child: Lottie.network(
                            "https://lottie.host/ce63bd6d-8a18-4018-bba7-ab874fa7ea23/YnNHhvo830.json",
                            width: 50,
                            height: 50,
                          ),
                        ),
                      ],
                    ),
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