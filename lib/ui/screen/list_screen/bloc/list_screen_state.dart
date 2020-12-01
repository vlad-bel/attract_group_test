import 'package:attract_group_test/data/model/film.dart';
import 'package:flutter/material.dart';

class ListScreenState {}

class LoadingState extends ListScreenState {}

class ErrorState extends ListScreenState {
  final Exception exception;

  ErrorState({@required this.exception});
}

class SuccesState extends ListScreenState {
  final List<Film> filmList;

  SuccesState(this.filmList);
}

class RemoveFilmState extends SuccesState {
  RemoveFilmState(List<Film> filmList) : super(filmList);
}

class DetailsRouteState extends SuccesState {
  final int filmId;

  DetailsRouteState(
    this.filmId,
    List<Film> filmList,
  ) : super(filmList);
}

class NewFilmRouteState extends SuccesState {
  NewFilmRouteState(List<Film> filmList) : super(filmList);
}
