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
  Future<void> deleteNote(String expenseId) async {
    try {
      await noteCollection.doc(expenseId).delete();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> updateNote(Note note) async {
    try {
      await noteCollection
          .doc(note.expenseId)
          .update(note.toEntity().toDocument());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Stream<List<Note>> getNoteStream() {
    return noteCollection.snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Note.fromEntity(NoteEntity.fromDocument(doc.data()))).toList()
    );
  }
}