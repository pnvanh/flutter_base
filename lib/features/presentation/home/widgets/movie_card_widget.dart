// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_base/constants/app_colors.dart';
import 'package:flutter_base/datasource/services/api/app/api_url.dart';
import 'package:flutter_base/features/domain/entities/movie_entity.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({Key? key, required this.movies}) : super(key: key);
  final List<MovieEntity> movies;

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/genre.json');
    final data = await jsonDecode(response);
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    readJson();
    return ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: Container(
              width: double.infinity,
              height: 125,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                // ignore: prefer_const_literals_to_create_immutables
                boxShadow: [
                  BoxShadow(
                    color: AppColors.pattensBlue,
                    blurRadius: 4,
                    offset: Offset(4.0, 5.0), // Shadow position
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 9.0,
                    decoration: const BoxDecoration(
                      color: AppColors.dodgerBlue,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        bottomLeft: Radius.circular(10.0),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                          IMAGE_PATH.mediaPath + movies[index].posterPath),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 8.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            movies[index].title,
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                          Text(
                            "Release: ${movies[index].releaseDate}",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.star,
                                color: AppColors.lightningYellow,
                                size: 24.0,
                              ),
                              SizedBox(
                                width: 2.0,
                              ),
                              Text(
                                "${movies[index].voteAverage} /10 IMDb",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
