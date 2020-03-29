part of 'movie_bloc.dart';

abstract class MovieState extends Equatable {
  const MovieState();
}

class MovieInitial extends MovieState {
  @override
  List<Object> get props => [];
}

class MovieLoading extends MovieState {
  @override
  // TODO: implement props
  List<Object> get props => [];
  
}

class MovieLoaded extends MovieState {

  List<Results> movies;

  MovieLoaded({@required this.movies});

  @override
  // TODO: implement props
  List<Object> get props => null;
  
}

class MovieError extends MovieState {

  String message; 

  MovieError({@required this.message});

  @override
  // TODO: implement props
  List<Object> get props => null;
  
}
