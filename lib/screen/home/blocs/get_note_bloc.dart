import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:note_repository/note_repository.dart';

part 'get_note_event.dart';
part 'get_note_state.dart';

class GetNoteBloc extends Bloc<GetNoteEvent, GetNoteState> {
  NoteRepository noteRepository;
  GetNoteBloc(this.noteRepository) : super(GetNoteInitial()) {
    on<GetNote>((event, emit) async {
      emit(GetNoteLoading());
      try {
        List<Note> note =  await noteRepository.getNote();
        emit(GetNoteSuccess(note));
      } catch (e) {
        emit(GetNoteFailure());
      }
    });
  }
}