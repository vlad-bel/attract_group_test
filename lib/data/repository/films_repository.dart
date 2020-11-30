import 'dart:convert';

import 'package:attract_group_test/data/model/film.dart';
import 'package:attract_group_test/data/repository/film_parser.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Repository {
  final Client client;

  final baseUrl = 'http://test.php-cd.attractgroup.com/test.json';

  Repository({@required this.client});

  Future<List<Film>> getFilms() async {
    var response = await client.get(baseUrl);

    var formattedBody = response.body.replaceAll('\n', '');
    var decodedData = jsonDecode(formattedBody) as List;

    return decodedData.map((filmJson) => FilmParser(filmJson).film).toList();
  }
}
