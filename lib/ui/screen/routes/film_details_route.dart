import 'dart:io';

import 'package:attract_group_test/ui/screen/details_screen/details_screen_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

PageRoute _adaptiveRoute(Widget page) {
  if (Platform.isAndroid) {
    return MaterialPageRoute(builder: (BuildContext context) => page);
  }

  return CupertinoPageRoute(builder: (BuildContext context) => page);
}

PageRoute filmDetailsRoute(int filmIndex) {
  return _adaptiveRoute(DetailsScreenPages(filmIndex));
}
