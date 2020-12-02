import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PopupButton extends StatelessWidget {
  final VoidCallback onPressed;

  PopupButton({@required this.onPressed});

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return PopupMenuButton(
        icon: Icon(
          Icons.more_vert,
          color: Colors.white,
        ),
        itemBuilder: (BuildContext context) {
          return [
            ///TODO стиль текста в теме
            PopupMenuItem(
              value: 'edit',
              child: Text('edit'),
            ),
          ];
        },
        onSelected: (value){
          if(value == 'edit'){
            onPressed();
          }
        },
      );
    }
    return IconButton(
      icon: Icon(
        Icons.more_horiz,
        color: Colors.white,
      ),
      onPressed: () {
        final act = CupertinoActionSheet(
          actions: <Widget>[
            CupertinoActionSheetAction(
              child: Text('edit'),
              onPressed:(){
                Navigator.pop(context);
                onPressed();
              } ,
            )
          ],
          cancelButton: CupertinoActionSheetAction(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        );
        showCupertinoModalPopup(
          context: context,
          builder: (BuildContext context) => act,
        );
      },
    );
  }
}
