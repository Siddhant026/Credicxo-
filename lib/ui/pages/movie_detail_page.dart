import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:movie/data/models/api2_result_model.dart';

class MovieDetailPage extends StatelessWidget {
  String id;

  MovieDetailPage({this.id});

  var url = "http://api.themoviedb.org/3/movie/" +
      id +
      "/videos?api_key=802b2c4b88ea1183e50e6b285a27696e";

  Future<List<Results>> getMovies() async {
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<Results> movies2 = Api2ResultModel.fromJson(data).results;
      return movies2;
    } else {
      throw Exception();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Movie"),
        ),
        body: FutureBuilder(
            future: getMovies(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return Container(
                alignment: Alignment.center,
                child: Text(snapshot.data.name),
              );
            }));
  }
}
