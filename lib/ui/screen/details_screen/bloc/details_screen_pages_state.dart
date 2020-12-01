import 'package:attract_group_test/data/model/film.dart';

class DetailsScreenPagesState {}

class DetailsScreenInitPagesState extends DetailsScreenPagesState {
  final int currentFilmIndex;
  final List<Film> filmsList;

  DetailsScreenInitPagesState(
    this.currentFilmIndex,
    this.filmsList,
  );
}

class DetailsScreenBackPagesState extends DetailsScreenPagesState {}

class DetailsEditFilmState extends DetailsScreenPagesState{
  final Film film;

  DetailsEditFilmState(this.film);

}
