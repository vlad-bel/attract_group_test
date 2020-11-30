import 'package:attract_group_test/data/model/film.dart';
import 'package:flutter/material.dart';

class ListScreenState {}

class ListScreenLoading extends ListScreenState {}

class ListScreenSucces extends ListScreenState {
  final List<Film> filmList;

  ListScreenSucces(this.filmList);
}

class ListScreenFail extends ListScreenState {
  final Exception exception;

  ListScreenFail({@required this.exception});
}
