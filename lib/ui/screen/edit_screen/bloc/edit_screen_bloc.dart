import 'dart:io';
import 'dart:math';

import 'package:attract_group_test/data/interactor/film_interactor.dart';
import 'package:attract_group_test/data/model/film.dart';
import 'package:attract_group_test/ui/screen/edit_screen/bloc/edit_screen_event.dart';
import 'package:attract_group_test/ui/screen/edit_screen/bloc/edit_screen_state.dart';
import 'package:attract_group_test/ui/util/time_formatter.dart';
import 'package:bloc/bloc.dart';

class EditScreenBloc extends Bloc<EditScreenEvent, EditScreenState> {
  final Film film;
  final FilmInteractor interactor;
  final int filmIndex;

  File image;
  String name;
  String date;
  String description;

  EditScreenBloc(
    this.film,
    this.interactor,
    this.filmIndex,
  ) : super(EditScreenState(
            film != null ? ScreenType.edit : ScreenType.create));

  @override
  Stream<EditScreenState> mapEventToState(EditScreenEvent event) async* {
    if (event is ImagePickEvent) {
      image = event.file;
    }

    print(event);
    if (event is TypeNameEvent) {
      name = event.text;
      yield TypeNameState(state.type, name);
    }

    if (event is TypeDescriptionEvent) {
      description = event.text;
      yield TypeDescriptionState(state.type, description);
    }

    if (event is PickDateEvent) {
      date = event.dateString;
      yield TypeDateState(state.type, date);
    }

    if (event is AddNewFilmEvent) {
      yield _addNewFilm();
    }
    if (event is ChangeExistFilmEvent) {
      yield _editExistFilm(
        event.name,
        event.image,
        event.date,
        event.description,
        event.date,
      );
    }

    yield _validateFields();
  }

  EditScreenState _validateFields() {
    if (state.type == ScreenType.create) {
      return _validateCreateFields();
    }

    return _validateEditFields();
  }

  _validateCreateFields() {
    if ((name == null || name.isEmpty) ||
        (date == null || date.isEmpty) ||
        (description == null || description.isEmpty) ||
        image == null) {
      return InvalidForms(state.type);
    } else {
      return ValidForms(
        type: state.type,
        image: image,
        name: name,
        date: date,
        description: description,
      );
    }
  }

  _validateEditFields() {
    if (name != film.name ||
        date != film.time.toString() ||
        description != film.description ||
        image.path != film.image) {
      return ValidForms(
        type: state.type,
        image: image,
        name: name,
        date: date,
        description: description,
      );
    } else {
      return InvalidForms(state.type);
    }
  }

  NavigateBackState _addNewFilm() {
    interactor.addFilm(
      Film(
        id: Random().nextInt(1000),
        name: name,
        image: image.path,
        description: description,
        time: getDateTimeFromString(date),
      ),
    );

    return NavigateBackState(state.type);
  }

  NavigateBackState _editExistFilm(
    String name,
    File image,
    String date,
    String description,
    String time,
  ) {
    interactor.editFilm(
      filmIndex,
      Film(
        id: film.id,
        name: name,
        image: image.path,
        description: description,
        time: getDateTimeFromString(date),
      ),
    );

    return NavigateBackState(state.type);
  }
}
