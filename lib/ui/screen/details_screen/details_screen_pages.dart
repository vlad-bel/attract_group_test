import 'dart:io';

import 'package:attract_group_test/data/interactor/film_interactor.dart';
import 'package:attract_group_test/main.dart';
import 'package:attract_group_test/ui/screen/details_screen/bloc/details_screen_pages_bloc.dart';
import 'package:attract_group_test/ui/screen/details_screen/bloc/details_screen_pages_state.dart';
import 'package:attract_group_test/ui/screen/details_screen/details_screen.dart';
import 'package:attract_group_test/ui/screen/details_screen/widget/popup_button.dart';
import 'package:attract_group_test/ui/screen/routes/film_details_route.dart';
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
        return DetailsScreenPagesBloc(
          widget.filmIndex,
          getIt<FilmInteractor>(),
        );
      },
      child: Scaffold(
        body: Stack(
          children: [
            BlocConsumer<DetailsScreenPagesBloc, DetailsScreenPagesState>(
              listener: (context, state) async {
                if (state is DetailsEditFilmState) {
                  await Navigator.of(context).push(editFilmRoute(
                    state.film,
                    widget.filmIndex,
                  ));
                  context.bloc<DetailsScreenPagesBloc>().refresh();
                }
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
      child: BlocConsumer<DetailsScreenPagesBloc, DetailsScreenPagesState>(
        listener: (context, state) async {
          if (state is DetailsScreenBackPagesState) {
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          return Row(
            children: [
              IconButton(
                icon: Icon(
                  Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                onPressed: () {
                  context.bloc<DetailsScreenPagesBloc>().back();
                },
              ),
              Spacer(),
              PopupButton(
                onPressed: () {
                  context.bloc<DetailsScreenPagesBloc>().openEditScreen();
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
