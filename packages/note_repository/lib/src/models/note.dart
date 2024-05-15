import 'package:note_repository/note_repository.dart';


class Note {
  String expenseId;
  RepositoryCategory category;
  DateTime date;
  // String nameNote;

  Note({
    required this.expenseId,
    required this.category,
    required this.date,
    // required this.nameNote,
  });

  static final empty = Note(
    expenseId: '',
    category: RepositoryCategory.empty,
    date: DateTime.now(),
    // nameNote: '',
  );

  NoteEntity toEntity() {
    return NoteEntity(
      expenseId: expenseId,
      category: category,
      date: date,
      // nameNote: nameNote,
    );
  }

  static Note fromEntity(NoteEntity entity) {
    return Note(
      expenseId: entity.expenseId,
      category: entity.category,
      date: entity.date,
      // nameNote: entity.nameNote,
    );
  }
}