import 'package:flutter/cupertino.dart';

class Film {
  final int id;
  final String name;
  final String image;
  final String description;
  final DateTime time;

  const Film({
    @required this.id,
    @required this.name,
    @required this.image,
    @required this.description,
    @required this.time,
  });

  @override
  String toString() {
    return 'Film{id: $id,'
        ' name: $name,'
        ' image: $image,'
        ' description: $description,'
        ' time: $time}';
  }
}
