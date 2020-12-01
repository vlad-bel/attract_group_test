import 'dart:io';

class EditScreenEvent {}

class ImagePickEvent extends EditScreenEvent {
  final File file;

  ImagePickEvent(this.file);
}

class TypeNameEvent extends EditScreenEvent {
  final String text;

  TypeNameEvent(this.text);
}

class PickDateEvent extends EditScreenEvent {
  final String dateString;

  PickDateEvent(this.dateString);
}

class TypeDescriptionEvent extends EditScreenEvent {
  final String text;

  TypeDescriptionEvent(this.text);
}

class AddNewFilmEvent extends EditScreenEvent {}

class ChangeExistFilmEvent extends EditScreenEvent {
  final File image;
  final String name;
  final String date;
  final String description;

  ChangeExistFilmEvent({
    this.image,
    this.name,
    this.date,
    this.description,
  });
}
