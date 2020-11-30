import 'package:attract_group_test/ui/screen/details_screen/details_screen.dart';
import 'package:attract_group_test/ui/screen/details_screen/details_screen_pages.dart';
import 'package:attract_group_test/ui/screen/edit_screen/edit_screen.dart';
import 'package:attract_group_test/ui/screen/list_screen/list_screen.dart';
import 'package:attract_group_test/ui/util/mocks.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: EditScreen(film: mockFilm,),
    );
  }
}



