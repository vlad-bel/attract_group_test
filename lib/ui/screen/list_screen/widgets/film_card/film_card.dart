import 'dart:io';

import 'package:attract_group_test/data/model/film.dart';
import 'package:attract_group_test/ui/util/res.dart';
import 'package:attract_group_test/ui/util/time_formatter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FilmCard extends StatelessWidget {
  final Film film;
  final Function() onTap;

  const FilmCard({
    Key key,
    @required this.film,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 2,
      ),
      child: Platform.isAndroid ? _buildAndroidCard() : _buildIosCard(),
    );
  }

  Widget _buildAndroidCard() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
              child: _buildPhoto(),
            ),

            ///build body
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///TODO стиль текста в теме
                  Text(
                    film.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),

                  ///TODO стиль текста в теме
                  Text(
                    getStringFromDateTime(film.time),
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhoto() {
    bool validURL = Uri.parse(film.image).isAbsolute;
    if (validURL) {
      return CachedNetworkImage(
        imageUrl: film.image,
        placeholder: (context, url) {
          return Image.asset(
            filmPlaceholderPath,
            fit: BoxFit.fitWidth,
            height: 200,
            width: double.infinity,
          );
        },
        fit: BoxFit.fitWidth,
        height: 200,
        width: double.infinity,
      );
    }

    return FadeInImage(
      image: FileImage(
        File(film.image),
      ),
      fit: BoxFit.fitWidth,
      height: 200,
      width: double.infinity,
      placeholder: AssetImage(filmPlaceholderPath),
    );
  }

  Widget _buildIosCard() {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 200,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
              child: _buildPhoto(),
            ),

            ///build body
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ///TODO стиль текста в теме
                  Text(
                    film.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),

                  ///TODO стиль текста в теме
                  Text(
                    getStringFromDateTime(film.time),
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
