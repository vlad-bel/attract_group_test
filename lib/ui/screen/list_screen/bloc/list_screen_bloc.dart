import 'package:attract_group_test/data/interactor/film_interactor.dart';
import 'package:attract_group_test/ui/screen/list_screen/bloc/list_screen_event.dart';
import 'package:attract_group_test/ui/screen/list_screen/bloc/list_screen_state.dart';
import 'package:attract_group_test/ui/screen/routes/film_details_route.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class ListScreenBloc extends Bloc<ListScreenEvent, ListScreenState> {
  final FilmInteractor filmInteractor;

  // final GlobalKey<NavigatorState> navigatorKey;

  ListScreenBloc(
    this.filmInteractor,
    // this.navigatorKey,
  ) : super(ListScreenState()) {
    add(ListScreenInitEvent());
  }

  @override
  Stream<ListScreenState> mapEventToState(event) async* {
    if (event is ListScreenInitEvent) {
      yield ListScreenLoading();
      yield await loadFilmList();
    }
  }

  Future<ListScreenState> loadFilmList() async {
    try {
      filmInteractor.cachedFilms = await filmInteractor.getFilms();
      return ListScreenSucces(filmInteractor.cachedFilms);
    } catch (e) {
      return ListScreenFail(exception: e);
    }
  }

  void openFilmDetails() {
    // navigatorKey.currentState.push(filmDetailsRoute(0));
  }
}
