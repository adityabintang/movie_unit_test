
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_unit_test/data/model/movie_response.dart';
import 'package:movie_unit_test/data/services/api.dart';
import 'package:http/http.dart' as http;
import 'package:movie_unit_test/data/services/exception.dart';
import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  const String apiKey = 'api_key=c2de34c85692bf92c16ed8f453906988';
  const String baseUrl = 'https://api.themoviedb.org/3';

  late MockHttpClient mockHttpClient;
  late Api api;

  setUp(() {
    mockHttpClient = MockHttpClient();
    api = Api(client: mockHttpClient);
  });

  group('Get Popular Movies', () {
    final tMovieList =
        MovieResponse.fromJson(json.decode(readJson('dummy_data/popular.json')))
            .movieList;

    test('should return list of movies when response is success (200)',
            () async {
          // arrange
          when(mockHttpClient.get(Uri.parse('$baseUrl/movie/popular?$apiKey')))
              .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/popular.json'), 200));
          // act
          final result = await api.getPopularMovies();
          // assert

          // Convert the MovieModel instances to JSON
          final resultJsonList = result.map((movie) => movie.toJson()).toList();
          final tMovieListJson = tMovieList.map((movie) => movie.toJson()).toList();

          expect(resultJsonList, tMovieListJson);
        });

    test(
        'should throw a ServerException when the response code is 404 or other',
            () async {
          // arrange
          when(mockHttpClient.get(Uri.parse('$baseUrl/movie/popular?$apiKey')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = api.getPopularMovies();
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });
}
