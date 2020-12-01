import 'dart:io';

import 'package:attract_group_test/data/model/film.dart';
import 'package:attract_group_test/ui/screen/list_screen/widgets/film_card/film_card.dart';
import 'package:flutter/cupertino.dart';

class FilmList extends StatelessWidget {
  final List<Film> filmList;
  final Function(int index) onDismissed;
  final Function(int film) onTap;

  const FilmList({
    Key key,
    @required this.filmList,
    @required this.onDismissed,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    if (isPortrait) {
      return _buildVerticalList();
    }

    return _buildHorizontalList();
  }

  Widget _buildVerticalList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Dismissible(
            key: UniqueKey(),
            child: FilmCard(
              film: filmList[index],
              onTap: () {
                onTap(index);
              },
            ),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              onDismissed(index);
            },
          );
        },
        childCount: filmList.length,
      ),
    );
  }

  Widget _buildHorizontalList() {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Dismissible(
            key: UniqueKey(),
            child: FilmCard(
              film: filmList[index],
              onTap: () {
                onTap(index);
              },
            ),
            direction: index.isEven
                ? DismissDirection.endToStart
                : DismissDirection.startToEnd,
            onDismissed: (direction) {
              onDismissed(index);
            },
            behavior: HitTestBehavior.deferToChild,
          );
        },
        childCount: filmList.length,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: Platform.isAndroid ? 1.1 : 2,
      ),
    );
  }
}
