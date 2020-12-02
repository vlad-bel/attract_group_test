import 'package:attract_group_test/data/interactor/film_interactor.dart';
import 'package:attract_group_test/data/repository/film_repository.dart';
import 'package:attract_group_test/ui/screen/details_screen/details_screen.dart';
import 'package:attract_group_test/ui/screen/details_screen/details_screen_pages.dart';
import 'package:attract_group_test/ui/screen/edit_screen/edit_screen.dart';
import 'package:attract_group_test/ui/screen/list_screen/bloc/list_screen_bloc.dart';
import 'package:attract_group_test/ui/screen/list_screen/list_screen.dart';
import 'package:attract_group_test/ui/util/mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

final getIt = GetIt.instance;

class MyApp extends StatelessWidget {

  MyApp() {
    getIt.registerSingleton<FilmInteractor>(FilmInteractor(
      repository: FilmRepository(
        client: http.Client(),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Attract group test app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ListScreen(),
    );
  }
}
