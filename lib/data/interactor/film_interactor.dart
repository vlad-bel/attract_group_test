import 'package:attract_group_test/data/model/film.dart';
import 'package:attract_group_test/data/repository/film_repository.dart';
import 'package:flutter/cupertino.dart';

class FilmInteractor {
  final FilmRepository repository;

  var cachedFilms = <Film>[];

  FilmInteractor({
    @required this.repository,
  });

  Future<List<Film>> getFilms() async {
    return repository.getFilms();
  }

  void addFilm(Film film) {
    cachedFilms.add(film);
  }

  void editFilm(int filmId, Film newFilm) {
    final newList = <Film>[];
    newList.add(newFilm);
    
    cachedFilms.replaceRange(filmId, filmId + 1, newList);
  }
}
