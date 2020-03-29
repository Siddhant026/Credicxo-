import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/bloc/movie_bloc.dart';
import 'package:movie/ui/pages/home_page.dart';
import './data/repositories/movie_repository.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (BuildContext context) {
          MovieBloc(repository: MovieRepositoryImpl());
        },
        child: HomePage(),
      ),
    );
  }
}
