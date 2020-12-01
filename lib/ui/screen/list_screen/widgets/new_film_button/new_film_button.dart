import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewFilmButton extends StatelessWidget {
  final VoidCallback onPressed;

  NewFilmButton({@required this.onPressed});

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: onPressed,
      );
    }
    return Container(
      width: 128,
      decoration: BoxDecoration(
          color: Colors.grey.withAlpha(200),
          borderRadius: BorderRadius.all(
            Radius.circular(24),
          )),
      child: CupertinoButton(
        ///TODO стиль текста в теме
        child: Text(
          'add',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        onPressed: onPressed,
        borderRadius: BorderRadius.all(Radius.circular(18)),
      ),
    );
  }
}
