import 'package:flutter/cupertino.dart';
import 'package:flutter_app3/models/note.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class NoteDataBase extends ChangeNotifier{
  static late Isar isar;
  // Initialize database
  static Future<void> initialize() async{
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [NoteSchema],
      directory: dir.path,
    );
  }

  final List<Note> currentNotes = [];

  //Create
  Future<void> addNote(String textFromUser) async {
    final newNote = Note()..text = textFromUser;


    await isar.writeTxn(() => isar.notes.put(newNote));

    await fetchNotes();
  }
  //Read
  Future<void> fetchNotes() async{
    List<Note> fetchedNotes = await isar.notes.where().findAll();
    currentNotes.clear();
    currentNotes.addAll(fetchedNotes);
    notifyListeners();
  }
  //Update
  Future<void> updateNote(int id, String newText) async{
    final existingNote = await isar.notes.get(id);
    if (existingNote != null){
      existingNote.text = newText;
      await isar.writeTxn(() => isar.notes.put(existingNote));
      await fetchNotes();
    }
  }

  //Delete
  Future<void> deleteNote(int id) async{
    await isar.writeTxn(() => isar.notes.delete(id));
    await fetchNotes();
  }
}