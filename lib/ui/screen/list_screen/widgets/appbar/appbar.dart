import 'dart:io';

import 'package:attract_group_test/ui/util/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Appbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return SliverAppBar(
        title: Text(
          listScreenTitle,
        ),
      );
    }
    return CupertinoSliverNavigationBar(
      largeTitle: Text(listScreenTitle),
    );
  }
}
