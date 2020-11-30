import 'package:attract_group_test/ui/screen/details_screen/details_screen.dart';
import 'package:attract_group_test/ui/screen/details_screen/details_screen_pages.dart';
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
      home: DetailsScreenPages(),
    );
  }
}



