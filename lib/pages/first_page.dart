import 'package:flutter/material.dart';
import 'package:flutter_app3/models/note_database.dart';
import 'package:flutter_app3/pages/home_page.dart';
import 'package:flutter_app3/pages/profile_page.dart';
import 'package:flutter_app3/pages/setting_page.dart';
import 'package:provider/provider.dart';

import '../models/note.dart';

class FirstPage extends StatefulWidget{
  FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {

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
          title: Text("Update Note"),
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



  //ЭТО ТОЖЕ ЧЕТО ОТ НАВИГАЦИИ
  // int _selectedIndex = 0;
  // void _navigateBotttomBar(int index){
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }
  //
  // final List _pages = [
  //   //homepage
  //   HomePage(),
  //
  //   //profilepage
  //   ProfilePage(),
  //
  //   //settingpage
  //   SettingPage(),
  // ];

  @override
  Widget build(BuildContext context){

    final noteDatabase = context.watch<NoteDataBase>();

    List<Note> currentNotes =  noteDatabase.currentNotes;

    return Scaffold(
      appBar: AppBar(title: Text("RemindAll")),
      floatingActionButton: FloatingActionButton(
        onPressed: createNote,
        child: const Icon(Icons.add),
      ),
      body:
      ListView.builder(
        itemCount: currentNotes.length,
        itemBuilder: (context, index) {
            final note = currentNotes[index];
            return ListTile(
              title: Text(note.text),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //edit button
                  IconButton(onPressed: () => updateNote(note),
                      icon: const Icon(Icons.edit),
                  ),

                  //delete button
                  IconButton(onPressed: () => deleteNote(note.id),
                    icon: const Icon(Icons.delete),
                  ),
                ],),
            );
          },
      ),
      //ЭТО НАВИГАЦИЯ ПЕРЕНЕСТИ В ДРАВЕР
      // _pages[_selectedIndex],
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: _selectedIndex,
      //   onTap: _navigateBotttomBar,
      //   items: [
      //     //home
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //     ),
      //
      //     //profile
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person),
      //       label: 'Profile',
      //     ),
      //
      //     //settings
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.settings),
      //       label: 'Settings',
      //     ),
      //   ],
      // ),
    );
  }
}

