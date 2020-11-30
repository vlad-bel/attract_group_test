import 'package:attract_group_test/data/model/film.dart';
import 'package:attract_group_test/ui/util/mocks.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  final Film film;

  DetailsScreen(this.film);

  @override
  State<StatefulWidget> createState() {
    return _DetailsScreenState();
  }
}

class _DetailsScreenState extends State<DetailsScreen> {
  var isAndroid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return CustomScrollView(
      physics: isAndroid
          ? ClampingScrollPhysics()
          : AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
      slivers: [
        _buildAppbar(),
        _buildDescription(),
      ],
    );
  }

  Widget _buildAppbar() {
    return SliverAppBar(
      expandedHeight: 350.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        ///TODO стиль текста в теме
        title: Text(widget.film.name),
        collapseMode: CollapseMode.parallax,
        background: Image.network(
          widget.film.image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildDescription() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Date',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              widget.film.time.toUtc().toString(),
              style: Theme.of(context).textTheme.bodyText2,
            ),
            SizedBox(height: 8),
            Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey.withAlpha(50),
            ),
            SizedBox(height: 8),
            Text(
              'Description',
              style: Theme.of(context).textTheme.headline4,
            ),
            SizedBox(height: 8),
            Text(
              widget.film.description,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ],
        ),
      ),
    );
  }
}
