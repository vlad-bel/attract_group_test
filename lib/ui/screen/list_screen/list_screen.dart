import 'dart:convert';
import 'dart:io';

import 'package:attract_group_test/ui/screen/list_screen/film_card/film_card.dart';
import 'package:attract_group_test/ui/util/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ListScreenState();
  }
}

class ListScreenState extends State<ListScreen> {
  var filmList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  @override
  Widget build(BuildContext context) {
    // return _buildIosUi();
    return Platform.isIOS ? _buildIosUi() : _buildAndroidUi();
  }

  Widget _buildAndroidUi() {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          return setState(() {
            filmList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
          });
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              ///TODO стиль текста в теме
              title: Text(
                "Film list",
              ),
            ),
            _buildFilmList(1.1),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
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
                return setState(() {
                  filmList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
                });
              },
              refreshIndicatorExtent: 100,
              refreshTriggerPullDistance: 100,
            ),
            _buildFilmList(2),
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

  Widget _buildFilmList(double aspectRatio) {
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
                    setState(() {
                      filmList.removeAt(index);
                    });
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
