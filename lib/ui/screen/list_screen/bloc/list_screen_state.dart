import 'package:attract_group_test/data/model/film.dart';
import 'package:flutter/material.dart';

class ListScreenState {}

class LoadingState extends ListScreenState {}

class ErrorState extends ListScreenState {
  final StateError exception;

  ErrorState({@required this.exception});
}

class SuccesState extends ListScreenState {
  final List<Film> filmList;

  SuccesState(this.filmList);
}

class RemoveFilmState extends SuccesState {
  RemoveFilmState(List<Film> filmList) : super(filmList);
}

class DetailsRouteState extends ListScreenState {
  final int filmId;

  DetailsRouteState(
    this.filmId,
  );
}

class NewFilmRouteState extends SuccesState {
  NewFilmRouteState(List<Film> filmList) : super(filmList);
}
