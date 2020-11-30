import 'dart:io';

import 'package:attract_group_test/ui/util/colors.dart';
import 'package:attract_group_test/ui/util/res.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FilmCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 2,
      ),
      child: _buildIosCard(),
      // child: Platform.isAndroid ? _buildAndroidCard() : _buildIosCard(),
    );
  }

  Widget _buildAndroidCard() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///build photo
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.0),
              topRight: Radius.circular(8.0),
            ),
            child: Container(
              height: 200,
              width: double.infinity,
              child: FadeInImage.assetNetwork(
                placeholder: filmPlaceholderPath,
                image:
                    'https://i.insider.com/5b5247a87708e946971b98b3?8width=750&format=jpeg&auto=webp',
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          ///build body
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///TODO стиль текста в теме
                Text(
                  "film_name",
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
                  "01-march-2018 10:10",
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
    );
  }

  Widget _buildIosCard() {
    return Container(
      height: 200,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            ///build photo
            child: Container(
              height: 200,
              width: double.infinity,
              child: FadeInImage.assetNetwork(
                placeholder: filmPlaceholderPath,
                image:
                    'https://i.insider.com/5b5247a87708e946971b98b3?8width=750&format=jpeg&auto=webp',
                fit: BoxFit.fitWidth,
              ),
            ),
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
                  "film_name",
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
                  "01-march-2018 10:10",
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
    );
  }
}
