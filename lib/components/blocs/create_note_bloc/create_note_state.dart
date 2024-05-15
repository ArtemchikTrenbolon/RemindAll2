part of 'create_note_bloc.dart';

sealed class CreateNoteState extends Equatable {
  const CreateNoteState();

  @override
  List<Object> get props => [];
}

final class CreateNoteInitial extends CreateNoteState {}

final class CreateNoteFailure extends CreateNoteState {}
final class CreateNoteLoading extends CreateNoteState {}
final class CreateNoteSuccess extends CreateNoteState {}