import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:note_repository/note_repository.dart';

class FirebaseNoteRepo implements NoteRepository {
  final categoryCollection = FirebaseFirestore.instance.collection('categories');
  final noteCollection = FirebaseFirestore.instance.collection('notes');


  @override
  Future<void> createCategory(RepositoryCategory category) async {
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
  Future<List<RepositoryCategory>> getCategory() async {
    try {
      return await categoryCollection
          .get()
          .then((value) => value.docs.map((e) =>
          RepositoryCategory.fromEntity(CategoryEntity.fromDocument(e.data()))
      ).toList());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> createNote(Note note) async {
    try {
      await noteCollection
          .doc(note.expenseId)
          .set(note.toEntity().toDocument());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<Note>> getNote() async {
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

  @override
  Future<void> updateNote(String userId, String docID, String newNote) {
    return FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection('notes')
        .doc(docID)
        .update({
      'note': newNote,
      'timestamp': Timestamp.now(),
    });
  }

  @override
  Future<void> deleteNote(String docID, String userId) {
    return FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection('notes')
        .doc(docID)
        .delete();
  }

}