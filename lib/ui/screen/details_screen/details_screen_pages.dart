import 'package:attract_group_test/ui/screen/details_screen/details_screen.dart';
import 'package:attract_group_test/ui/util/mocks.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailsScreenPages extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DetailsScreenPagesState();
  }
}

class _DetailsScreenPagesState extends State<DetailsScreenPages> {
  var isAndroid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            itemBuilder: (context, index) {
              return DetailsScreen(mockFilms[index]);
            },
            itemCount: mockFilms.length,
          ),
          _buildAppbar(),
        ],
      ),
    );
  }

  Widget _buildAppbar() {
    return Padding(
      padding: const EdgeInsets.only(top: 32.0),
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              isAndroid ? Icons.arrow_back : Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
          Spacer(),
          isAndroid
              ? PopupMenuButton(
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                  itemBuilder: (BuildContext context) {
                    return [
                      ///TODO стиль текста в теме
                      PopupMenuItem(
                        child: Text('edit'),
                      ),
                    ];
                  },
                )
              : IconButton(
                  icon: Icon(
                    Icons.more_horiz,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    final act = CupertinoActionSheet(
                      actions: <Widget>[
                        CupertinoActionSheetAction(
                          child: Text('edit'),
                          onPressed: () {
                            print('pressed');
                          },
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
                ),
        ],
      ),
    );
  }
}
