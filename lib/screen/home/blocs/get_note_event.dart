part of 'get_note_bloc.dart';

sealed class GetNoteEvent extends Equatable {
  const GetNoteEvent();

  @override
  List<Object> get props => [];
}
class GetNote extends GetNoteEvent{}
