// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// // Метод для добавления заметки в Firestore
// Future<void> addNote(String text) async {
//   String? userId = FirebaseAuth.instance.currentUser?.uid;
//   if (userId != null) {
//     await FirebaseFirestore.instance
//         .collection('notes')
//         .doc(userId)
//         .collection('user_notes')
//         .add({'text': text});
//   }
// }
//
// // Метод для получения списка заметок из Firestore
// Stream<List<Note>> getNotes() {
//   String? userId = FirebaseAuth.instance.currentUser?.uid;
//   if (userId != null) {
//     return FirebaseFirestore.instance
//         .collection('notes')
//         .doc(userId)
//         .collection('user_notes')
//         .snapshots()
//         .map((snapshot) => snapshot.docs
//         .map((doc) => Note.fromFirestore(doc.data()))
//         .toList());
//   } else {
//     // Если пользователь не аутентифицирован, возвращаем пустой список
//     return Stream.value([]);
//   }
// }
//
// // Модель заметки
// class Note {
//   final String text;
//
//   Note({required this.text});
//
//   // Создаем заметку из данных Firestore
//   factory Note.fromFirestore(Map<String, dynamic> data) {
//     return Note(text: data['text']);
//   }
// }
