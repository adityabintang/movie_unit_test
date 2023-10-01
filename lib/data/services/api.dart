import 'dart:convert';

import 'package:http/io_client.dart';
import 'package:movie_unit_test/utils/constants.dart';
import 'package:movie_unit_test/data/services/exception.dart';
import 'package:movie_unit_test/data/model/movie_model.dart';
import 'package:movie_unit_test/data/model/movie_response.dart';

class Api {
  final IOClient client;

  Api({required this.client});

  Future<List<MovieModel>> getPopularMovies() async {
    final response =
    await client.get(Uri.parse('$baseUrl/movie/popular?$apiKey'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }
}