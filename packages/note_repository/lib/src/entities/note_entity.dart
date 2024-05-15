import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:note_repository/note_repository.dart';


class NoteEntity {
  String expenseId;
  RepositoryCategory category;
  DateTime date;
  // String nameNote;

  NoteEntity({
    required this.expenseId,
    required this.category,
    required this.date,
    // required this.nameNote,
  });

  Map<String, Object?> toDocument() {
    return {
      'expenseId': expenseId,
      'category': category.toEntity().toDocument(),
      'date': date,
      // 'nameNote': nameNote,
    };
  }

  static NoteEntity fromDocument(Map<String, dynamic> doc) {
    return NoteEntity(
      expenseId: doc['expenseId'],
      category: RepositoryCategory.fromEntity(CategoryEntity.fromDocument(doc['category'])),
      date: (doc['date'] as Timestamp).toDate(),
      // nameNote: doc['nameNote'],
    );
  }
}