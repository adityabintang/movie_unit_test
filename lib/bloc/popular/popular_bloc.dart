import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_unit_test/data/model/movie_model.dart';
import 'package:movie_unit_test/data/services/api.dart';

part 'popular_event.dart';

part 'popular_state.dart';

class PopularMovieBloc extends Bloc<ListPopularEvent, PopularMovieState> {
  final Api api;

  PopularMovieBloc({required this.api}) : super(ListPopularEmpty()) {
    on<ListPopularFetch>((event, emit) async {
      emit(ListPopularLoading());
      final result = await api.getPopularMovies();
      emit(ListPopularLoaded(result));
    });
  }
}
