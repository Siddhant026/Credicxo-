import 'package:movie/data/models/api1_result_model.dart';
import 'package:http/http.dart' as http;
import 'package:movie/res/strings.dart';
import 'dart:convert';

abstract class MovieRepository {

  Future<List<Results>> getMovies();

}

class MovieRepositoryImpl implements MovieRepository {

  @override
  Future<List<Results>> getMovies() async {

    var response = await http.get(AppStrings.api1);
    if (response.statusCode == 200) {

      var data = json.decode(response.body);
      List<Results> movies = Api1ResultModel.fromJson(data).results;
      return movies;

    } else {
      throw Exception();
    }

  }

}