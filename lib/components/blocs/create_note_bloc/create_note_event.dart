part of 'create_note_bloc.dart';

abstract class CreateNoteEvent extends Equatable {
  const CreateNoteEvent();

  @override
  List<Object> get props => [];
}

class CreateNote extends CreateNoteEvent {
  final Note note;

  const CreateNote(this.note);

  @override
  List<Object> get props => [note];
}

class UpdateNote extends CreateNoteEvent {
  final Note note;

  const UpdateNote(this.note);

  @override
  List<Object> get props => [note];
}
