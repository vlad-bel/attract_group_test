import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Appbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return SliverAppBar(
        ///TODO стиль текста в теме
        title: Text(
          "Film list",
        ),
      );
    }
    return CupertinoSliverNavigationBar(
      largeTitle: Text("List screen"),
    );
  }
}
