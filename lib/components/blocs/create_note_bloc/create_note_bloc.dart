import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:note_repository/note_repository.dart';

part 'create_note_state.dart';
part 'create_note_event.dart';

class CreateNoteBloc extends Bloc<CreateNoteEvent, CreateNoteState> {
  final NoteRepository noteRepository;

  CreateNoteBloc(this.noteRepository) : super(CreateNoteInitial()) {
    on<CreateNote>((event, emit) async {
      emit(CreateNoteLoading());
      try {
        await noteRepository.createNote(event.note);
        emit(CreateNoteSuccess());
      } catch (e) {
        emit(CreateNoteFailure());
      }
    });

    on<UpdateNote>((event, emit) async {
      emit(CreateNoteLoading());
      try {
        await noteRepository.updateNote(event.note);
        emit(CreateNoteSuccess());
      } catch (e) {
        emit(CreateNoteFailure());
      }
    });
  }
}
