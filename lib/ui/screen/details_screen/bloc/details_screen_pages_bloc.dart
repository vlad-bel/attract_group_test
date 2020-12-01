import 'package:attract_group_test/data/interactor/film_interactor.dart';
import 'package:attract_group_test/ui/screen/details_screen/bloc/details_screen_pages_event.dart';
import 'package:attract_group_test/ui/screen/details_screen/bloc/details_screen_pages_state.dart';
import 'package:bloc/bloc.dart';

class DetailsScreenPagesCubit extends Cubit<DetailsScreenPagesState> {
  final int currentFilmIndex;
  final FilmInteractor filmInteractor;

  DetailsScreenPagesCubit(
    this.currentFilmIndex,
    this.filmInteractor,
  ) : super(DetailsScreenInitPagesState(
          currentFilmIndex,
          filmInteractor.cachedFilms,
        ));

  void back(){
    emit(DetailsScreenBackPagesState());
  }
}
