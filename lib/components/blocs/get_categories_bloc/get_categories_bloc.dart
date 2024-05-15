import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:note_repository/note_repository.dart';

part 'get_categories_event.dart';
part 'get_categories_state.dart';

class GetCategoriesBloc extends Bloc<GetCategoriesEvent, GetCategoriesState> {
  NoteRepository noteRepository;
  GetCategoriesBloc(this.noteRepository) : super(GetCategoriesInitial()) {
    on<GetCategories>((event, emit) async {
      emit(GetCategoriesLoading());
      try {
        List<RepositoryCategory> categories =  await noteRepository.getCategory();
        emit(GetCategoriesSuccess(categories));
      } catch (e) {
        emit(GetCategoriesFailure());
      }
    });
  }
}