part of 'get_note_bloc.dart';

sealed class GetNoteState extends Equatable {
  const GetNoteState();

  @override
  List<Object> get props => [];
}

final class GetNoteInitial extends GetNoteState {}

final class GetNoteFailure extends GetNoteState {}
final class GetNoteLoading extends GetNoteState {}
final class GetNoteSuccess extends GetNoteState {
  final List<Note> note;

  GetNoteSuccess(this.note);

  @override
  List<Object> get props => [note];
}
