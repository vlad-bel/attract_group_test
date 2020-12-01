import 'package:attract_group_test/data/interactor/film_interactor.dart';
import 'package:attract_group_test/ui/screen/list_screen/bloc/list_screen_event.dart';
import 'package:attract_group_test/ui/screen/list_screen/bloc/list_screen_state.dart';
import 'package:attract_group_test/ui/screen/routes/film_details_route.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class ListScreenBloc extends Bloc<ListScreenEvent, ListScreenState> {
  final FilmInteractor filmInteractor;

  ListScreenBloc(
    this.filmInteractor,
  ) : super(ListScreenState()) {
    add(InitEvent());
  }

  @override
  Stream<ListScreenState> mapEventToState(event) async* {
    if (event is InitEvent) {
      yield LoadingState();
      yield await loadFilmList();
    }

    if (event is DetailsRouteEvent) {
      yield DetailsRouteState(
        event.filmId,
        filmInteractor.cachedFilms,
      );
    }

    if (event is NewFilmRouteEvent) {
      yield NewFilmRouteState(filmInteractor.cachedFilms);
    }

    if (event is RemoveFilmEvent) {
      filmInteractor.cachedFilms.removeAt(event.index);
      yield RemoveFilmState(filmInteractor.cachedFilms);
    }
  }

  Future<ListScreenState> loadFilmList() async {
    try {
      filmInteractor.cachedFilms = await filmInteractor.getFilms();
      return SuccesState(filmInteractor.cachedFilms);
    } catch (e) {
      return ErrorState(exception: e);
    }
  }
}
