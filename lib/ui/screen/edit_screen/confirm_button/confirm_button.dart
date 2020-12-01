import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConfirmButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;

  const ConfirmButton({
    Key key,
    @required this.onPressed,
    @required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return Container(
        height: 48,
        width: double.infinity,
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          onPressed: onPressed,
          child: Text(label),
        ),
      );
    }

    return Container(
      width: double.infinity,
      child: CupertinoButton.filled(
        onPressed: onPressed,
        child: Text(
          label,
        ),
      ),
    );
  }
}
