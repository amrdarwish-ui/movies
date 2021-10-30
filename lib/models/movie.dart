import 'package:flutter/material.dart';

class Movie {
  int id;
  num vote_average;
  String title;
  String overview;
  String poster_path;
  Movie({
    @required this.id,
    @required this.vote_average,
    @required this.title,
    @required this.overview,
    @required this.poster_path,
  });
}
