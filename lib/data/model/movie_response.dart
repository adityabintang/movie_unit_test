import 'package:movie_unit_test/data/model/movie_model.dart';

class MovieResponse {
  final List<MovieModel> movieList;

  const MovieResponse({required this.movieList});

  factory MovieResponse.fromJson(Map<String, dynamic> json) => MovieResponse(
    movieList: List<MovieModel>.from((json["results"] as List)
        .map((x) => MovieModel.fromJson(x))
        .where((element) => element.posterPath != null)),
  );

  Map<String, dynamic> toJson() => {
    "results": List<dynamic>.from(movieList.map((x) => x.toJson())),
  };
}