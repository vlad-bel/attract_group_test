import 'package:attract_group_test/data/model/film.dart';

class ListScreenEvent {}

class InitEvent extends ListScreenEvent {}
class RemoveFilmEvent extends ListScreenEvent {
  final int index;

  RemoveFilmEvent(this.index);
}

class NewFilmRouteEvent extends ListScreenEvent {}

class DetailsRouteEvent extends ListScreenEvent {
  final int filmId;

  DetailsRouteEvent(this.filmId);
}
