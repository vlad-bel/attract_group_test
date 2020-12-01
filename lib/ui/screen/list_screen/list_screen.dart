import 'dart:io';

import 'package:attract_group_test/main.dart';
import 'package:attract_group_test/ui/screen/list_screen/bloc/list_screen_bloc.dart';
import 'package:attract_group_test/ui/screen/list_screen/bloc/list_screen_event.dart';
import 'package:attract_group_test/ui/screen/list_screen/bloc/list_screen_state.dart';
import 'package:attract_group_test/ui/screen/list_screen/widgets/appbar/appbar.dart';
import 'package:attract_group_test/ui/screen/list_screen/widgets/film_list/film_list.dart';
import 'package:attract_group_test/ui/screen/list_screen/widgets/new_film_button/new_film_button.dart';
import 'package:attract_group_test/ui/screen/list_screen/widgets/refresher/refresher.dart';
import 'package:attract_group_test/ui/screen/routes/film_details_route.dart';
import 'package:attract_group_test/ui/util/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ListScreenState();
  }
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return ListScreenBloc(
          MyApp.filmInteractor,
        );
      },
      child: BlocConsumer<ListScreenBloc, ListScreenState>(
        builder: (BuildContext context, state) {
          return Platform.isIOS
              ? _buildIosUi(state, context)
              : _buildAndroidUi(state, context);
        },
        listener: (BuildContext context, state) async {
          if (state is DetailsRouteState) {
            await Navigator.of(context).push(filmDetailsRoute(state.filmId));
            context.bloc<ListScreenBloc>().add(RefreshEvent());
          }

          if (state is NewFilmRouteState) {
            await Navigator.of(context).push(newFilmRoute());
            context.bloc<ListScreenBloc>().add(RefreshEvent());
          }
        },
      ),
    );
  }

  Widget _buildAndroidUi(ListScreenState state, BuildContext context) {
    return Scaffold(
      body: Refresher(
        onRefresh: () async {
          context.bloc<ListScreenBloc>().add(InitEvent());
        },
        child: CustomScrollView(
          slivers: [
            Appbar(),
            if (state is ErrorState) _buildErrorState(),
            if (state is LoadingState) _buildLoadingState(),
            if (state is SuccesState) _buildSuccesState(state, context),
          ],
        ),
      ),
      floatingActionButton: NewFilmButton(
        onPressed: () {
          context.bloc<ListScreenBloc>().add(NewFilmRouteEvent());
        },
      ),
    );
  }

  Widget _buildIosUi(ListScreenState state, BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        slivers: [
          Appbar(),
          Refresher(
            onRefresh: () {
              context.bloc<ListScreenBloc>().add(InitEvent());
              return Future.value();
            },
          ),
          if (state is ErrorState) _buildErrorState(),
          if (state is LoadingState) _buildLoadingState(),
          if (state is SuccesState) _buildSuccesState(state, context),
        ],
      ),
      floatingActionButton: NewFilmButton(
        onPressed: () {
          context.bloc<ListScreenBloc>().add(NewFilmRouteEvent());
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
            Text(errorTitle),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccesState(SuccesState succes, BuildContext context) {
    return FilmList(
      filmList: succes.filmList,
      onTap: (filmId) {
        context.bloc<ListScreenBloc>().add(DetailsRouteEvent(filmId));
      },
      onDismissed: (index) {
        context.bloc<ListScreenBloc>().add(RemoveFilmEvent(index));
      },
    );
  }
}
