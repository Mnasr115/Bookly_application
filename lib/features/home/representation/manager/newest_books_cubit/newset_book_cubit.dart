import 'package:bloc/bloc.dart';
import 'package:bookly_application/features/home/data/repos/home_repos.dart';
import 'package:meta/meta.dart';

import '../../../data/models/BookModel.dart';

part 'newset_book_state.dart';

class NewsetBookCubit extends Cubit<NewsetBookState> {
  NewsetBookCubit(this.homeRepos) : super(NewsetBookInitial());

  final HomeRepos homeRepos;

  Future<void> fetchNewestBooks() async {
    emit(NewsetBookLoading());
    var result = await homeRepos.fetchNewsBooks();

    result.fold(
      (failure) {
        emit(NewsetBookFailure(failure.errorMessage));
      },
      (books) {
        emit(NewsetBookSuccess(books));
      },
    );
  }
}
