import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/bloc/movie_bloc.dart';
import 'package:movie/data/models/api1_result_model.dart';
import 'package:movie/data/repositories/movie_repository.dart';

import 'movie_detail_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MovieBloc movieBloc = MovieBloc(repository: MovieRepositoryImpl());

  @override
  void initState() {
    super.initState();
    //movieBloc = BlocProvider.of<MovieBloc>(context);
    //movieBloc.add(FetchMoviesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (context) {
          return Material(
            child: Scaffold(
              appBar: AppBar(
                title: Text("Cricket"),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: () {
                      movieBloc.add(FetchMoviesEvent());
                    },
                  ),
                ],
              ),
              body: Container(
                child: BlocListener<MovieBloc, MovieState>(
                  listener: (BuildContext context, MovieState state) {
                    if (state is MovieError) {
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                        ),
                      );
                    }
                  },
                  child: BlocBuilder(
                    bloc: movieBloc,
                    builder: (BuildContext context, MovieState state) {
                      if (state is MovieInitial) {
                        return buildLoading();
                      } else if (state is MovieLoading) {
                        return buildLoading();
                      } else if (state is MovieLoaded) {
                        return buildMovieList(state.movies);
                      } else if (state is MovieError) {
                        return buildErrorUi(state.message);
                      }
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildErrorUi(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          message,
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  Widget buildMovieList(List<Results> movies) {
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (ctx, pos) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(movies[pos].posterPath),
              ),
              title: Text(movies[pos].title),
              subtitle: Text(movies[pos].originalTitle),
            ),
            onTap: () {
              navigateToMovieDetailPage(context, movies[pos].id.toString());
            },
          ),
        );
      },
    );
  }

  void navigateToMovieDetailPage(BuildContext context, String id) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return MovieDetailPage(
        id: id,
      );
    }));
  }

}