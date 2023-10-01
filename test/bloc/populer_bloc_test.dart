import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_unit_test/bloc/popular/popular_bloc.dart';
import 'package:movie_unit_test/data/model/movie_model.dart';
import 'package:movie_unit_test/data/services/api.dart';

import 'populer_bloc_test.mocks.dart';

@GenerateMocks([Api])
void main() {
  late PopularMovieBloc popularMovieBloc;
  late MockApi mockApi;

  setUp(() {
    mockApi = MockApi();
    popularMovieBloc = PopularMovieBloc(api: mockApi);
  });

  const tMovie = MovieModel(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );

  final tMovieList = <MovieModel>[tMovie];

  test(
    'initial state should be empty',
    () {
      expect(popularMovieBloc.state, ListPopularEmpty());
    },
  );

  blocTest<PopularMovieBloc, PopularMovieState>(
    'should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockApi.getPopularMovies())
          .thenAnswer((_) async => tMovieList);
      return popularMovieBloc;
    },
    act: (bloc) => bloc.add(ListPopularFetch()),
    expect: () => [
      ListPopularLoading(),
      ListPopularLoaded(tMovieList),
    ],
      verify: (bloc) {
        verify(mockApi.getPopularMovies());
      }
  );
}
