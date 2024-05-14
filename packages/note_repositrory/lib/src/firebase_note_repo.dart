import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:note_repository/note_repository.dart';

class FirebaseNoteRepo implements NoteRepository {
  final categoryCollection = FirebaseFirestore.instance.collection('categories');
  final noteCollection = FirebaseFirestore.instance.collection('notes');


  @override
  Future<void> createCategory(Category category) async {
    try {
      await categoryCollection
          .doc(category.categoryId)
          .set(category.toEntity().toDocument());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<Category>> getCategory() async {
    try {
      return await categoryCollection
          .get()
          .then((value) => value.docs.map((e) =>
          Category.fromEntity(CategoryEntity.fromDocument(e.data()))
      ).toList());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> createNote(Note note) async {
    try {
      await NoteCollection
          .doc(note.noteId)
          .set(note.toEntity().toDocument());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<Note>> getNotes() async {
    try {
      return await noteCollection
          .get()
          .then((value) => value.docs.map((e) =>
          Note.fromEntity(NoteEntity.fromDocument(e.data()))
      ).toList());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

}