import 'package:note_repository/note_repository.dart';

abstract class NoteRepository {

  Future<void> createCategory(Category category);

  Future<List<Category>> getCategory();

  Future<void> createNotes(Note note);

  Future<List<Note>> getNote();
}