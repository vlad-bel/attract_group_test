import 'dart:io';

import 'package:attract_group_test/main.dart';
import 'package:attract_group_test/ui/screen/details_screen/bloc/details_screen_pages_bloc.dart';
import 'package:attract_group_test/ui/screen/details_screen/bloc/details_screen_pages_state.dart';
import 'package:attract_group_test/ui/screen/details_screen/details_screen.dart';
import 'package:attract_group_test/ui/util/mocks.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsScreenPages extends StatefulWidget {
  final int filmIndex;

  DetailsScreenPages(this.filmIndex);

  @override
  State<StatefulWidget> createState() {
    return _DetailsScreenPagesState();
  }
}

class _DetailsScreenPagesState extends State<DetailsScreenPages> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return DetailsScreenPagesCubit(
          widget.filmIndex,
          MyApp.filmInteractor,
        );
      },
      child: Scaffold(
        body: Stack(
          children: [
            BlocConsumer<DetailsScreenPagesCubit, DetailsScreenPagesState>(
              listener: (context, state) {

              },
              builder: (context, state) {
                if (state is DetailsScreenInitPagesState) {
                  return PageView.builder(
                    itemBuilder: (context, index) {
                      return DetailsScreen(state.filmsList[index]);
                    },
                    controller: PageController(
                      initialPage: state.currentFilmIndex,
                    ),
                    itemCount: state.filmsList.length,
                  );
                }
                return Container();
              },
            ),
            _buildAppbar(),
          ],
        ),
      ),
    );
  }

  Widget _buildAppbar() {
    return Padding(
      padding: const EdgeInsets.only(top: 32.0),
      child: Row(
        children: [
          BlocConsumer<DetailsScreenPagesCubit, DetailsScreenPagesState>(
            listener: (context, state) {
              if (state is DetailsScreenBackPagesState) {
                Navigator.of(context).pop();
              }
            },
            builder: (context, state) {
              return IconButton(
                icon: Icon(
                  Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                onPressed: () {
                  context.bloc<DetailsScreenPagesCubit>().back();
                },
              );
            },
          ),
          Spacer(),
          Platform.isAndroid
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
