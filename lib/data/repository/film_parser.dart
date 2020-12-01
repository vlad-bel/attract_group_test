import 'package:attract_group_test/data/model/film.dart';

class FilmParser {
  final Film film;

  FilmParser(Map<String, dynamic> json)
      : film = Film(
          id: int.parse(json['itemId']),
          name: json['name'],
          image: json['image'],
          description: json['description'],
          time: DateTime.fromMicrosecondsSinceEpoch(
            int.parse(json['time']),
          ),
        );
}
