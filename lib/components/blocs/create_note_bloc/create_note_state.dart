part of 'create_note_bloc.dart';

abstract class CreateNoteState extends Equatable {
  const CreateNoteState();

  @override
  List<Object> get props => [];
}

class CreateNoteInitial extends CreateNoteState {}

class CreateNoteLoading extends CreateNoteState {}

class CreateNoteSuccess extends CreateNoteState {}

class CreateNoteFailure extends CreateNoteState {}
