import 'dart:io';

enum ScreenType {
  edit,
  create,
}

class EditScreenState {
  final ScreenType type;

  EditScreenState(this.type);
}

class ValidForms extends EditScreenState {
  final File image;
  final String name;
  final String date;
  final String description;

  ValidForms({
    ScreenType type,
    this.image,
    this.name,
    this.date,
    this.description,
  }) : super(type);
}

class InvalidForms extends EditScreenState {
  InvalidForms(ScreenType type) : super(type);
}

class TypeNameState extends EditScreenState {
  String text;

  TypeNameState(
    ScreenType type,
    this.text,
  ) : super(type);
}

class TypeDateState extends EditScreenState {
  String dateText;

  TypeDateState(
    ScreenType type,
    this.dateText,
  ) : super(type);
}

class TypeDescriptionState extends EditScreenState {
  String text;

  TypeDescriptionState(
    ScreenType type,
    this.text,
  ) : super(type);
}

class NavigateBackState extends EditScreenState {
  NavigateBackState(ScreenType type) : super(type);
}
