import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:movie/data/models/api1_result_model.dart';
import 'package:movie/data/repositories/movie_repository.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {

  MovieRepository repository;

  MovieBloc({@required this.repository});

  @override
  MovieState get initialState => MovieInitial();

  @override
  Stream<MovieState> mapEventToState(
    MovieEvent event,
  ) async* {
    if (event is FetchMoviesEvent) {
      yield MovieLoading();
      try {
        List<Results> movies = await repository.getMovies();
        yield MovieLoaded(movies: movies);
      } catch (e) {
        yield MovieError(message: e.toString());
      }
    }
  }
}
