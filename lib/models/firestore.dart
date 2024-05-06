import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference usersCollection =
  FirebaseFirestore.instance.collection('Users');

  Future<void> addNote(String userId, String note) {
    return usersCollection
        .doc(userId)
        .collection('notes')
        .add({
      'note': note,
      'timestamp': Timestamp.now(),
    });
  }

  Stream<QuerySnapshot> getNotesStream(String userId) {
    final notesStream = usersCollection
        .doc(userId)
        .collection('notes')
        .orderBy('timestamp', descending: true)
        .snapshots();

    return notesStream;
  }

  Future<void> updateNote(String userId, String noteId, String newNote) {
    return usersCollection
        .doc(userId)
        .collection('notes')
        .doc(noteId)
        .update({
      'note': newNote,
      'timestamp': Timestamp.now(),
    });
  }

  Future<void> deleteNote(String userId, String noteId) {
    return usersCollection
        .doc(userId)
        .collection('notes')
        .doc(noteId)
        .delete();
  }
}
