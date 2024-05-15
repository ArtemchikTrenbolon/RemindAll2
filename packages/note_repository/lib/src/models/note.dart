import 'package:note_repository/note_repository.dart';


class Note {
  String expenseId;
  RepositoryCategory category;
  DateTime date;

  Note({
    required this.expenseId,
    required this.category,
    required this.date,
  });

  static final empty = Note(
    expenseId: '',
    category: RepositoryCategory.empty,
    date: DateTime.now(),
  );

  NoteEntity toEntity() {
    return NoteEntity(
      expenseId: expenseId,
      category: category,
      date: date,
    );
  }

  static Note fromEntity(NoteEntity entity) {
    return Note(
      expenseId: entity.expenseId,
      category: entity.category,
      date: entity.date,
    );
  }
}