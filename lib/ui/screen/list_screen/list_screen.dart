import 'dart:convert';
import 'dart:io';

import 'package:attract_group_test/data/interactor/film_interactor.dart';
import 'package:attract_group_test/data/model/film.dart';
import 'package:attract_group_test/data/repository/film_repository.dart';
import 'package:attract_group_test/ui/screen/list_screen/bloc/list_screen_bloc.dart';
import 'package:attract_group_test/ui/screen/list_screen/bloc/list_screen_state.dart';
import 'package:attract_group_test/ui/screen/list_screen/film_card/film_card.dart';
import 'package:attract_group_test/ui/util/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class ListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ListScreenState();
  }
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ListScreenBloc, ListScreenState>(
      builder: (BuildContext context, state) {
        return Platform.isIOS ? _buildIosUi() : _buildAndroidUi(state);
      },
      listener: (BuildContext context, state) {},
    );
  }

  Widget _buildAndroidUi(ListScreenState state) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          ///TODO СДЕЛАТЬ ОБНОВЛЕНИЕ
          return setState(() {});
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              ///TODO стиль текста в теме
              title: Text(
                "Film list",
              ),
            ),
            if (state is ListScreenLoading) _buildLoadingState(),
            if (state is ListScreenFail) _buildErrorState(),
            if (state is ListScreenSucces) _buildSuccesState(state),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }

  Widget _buildLoadingState() {
    return SliverFillRemaining(
      child: Center(
        child: Platform.isAndroid
            ? CircularProgressIndicator()
            : CupertinoActivityIndicator(),
      ),
    );
  }

  Widget _buildErrorState() {
    return SliverFillRemaining(
      child: Center(
        child: Column(
          children: [
            Icon(
              Icons.error_outline,
              color: Colors.red,
            ),
            Text("error! try refresh page"),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccesState(ListScreenSucces succes) {
    if (Platform.isAndroid) {
      return _buildFilmList(succes.filmList, 1.1);
    }

    return _buildFilmList(succes.filmList, 2);
  }

  Widget _buildIosUi() {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            CupertinoSliverNavigationBar(
              largeTitle: Text("List screen"),
            ),
          ];
        },
        body: CustomScrollView(
          physics: AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          slivers: [
            CupertinoSliverRefreshControl(
              onRefresh: () async {
                ///TODO СДЕЛАТЬ ОБНОВЛЕНИЕ
                return setState(() {});
              },
              refreshIndicatorExtent: 100,
              refreshTriggerPullDistance: 100,
            ),
            // _buildFilmList(2),
          ],
        ),
      ),
      floatingActionButton: Container(
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
          onPressed: () {},
          borderRadius: BorderRadius.all(Radius.circular(18)),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildFilmList(List<Film> filmList, double aspectRatio) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return isPortrait == true
        ? SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Dismissible(
                  key: UniqueKey(),
                  child: FilmCard(),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    setState(() {});
                  },
                );
              },
              childCount: filmList.length,
            ),
          )
        : SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Dismissible(
                  key: UniqueKey(),
                  child: FilmCard(),
                  direction: index.isEven
                      ? DismissDirection.endToStart
                      : DismissDirection.startToEnd,
                  onDismissed: (direction) {
                    setState(() {
                      filmList.removeAt(index);
                    });
                  },
                  behavior: HitTestBehavior.deferToChild,
                );
              },
              childCount: filmList.length,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: aspectRatio,
            ),
          );
  }
}
