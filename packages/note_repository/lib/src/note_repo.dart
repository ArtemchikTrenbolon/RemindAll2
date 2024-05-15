import 'package:note_repository/note_repository.dart';

abstract class NoteRepository {

  Future<void> createCategory(RepositoryCategory category);

  Future<List<RepositoryCategory>> getCategory();

  Future<void> createNote(Note note);

  Future<List<Note>> getNote();
}