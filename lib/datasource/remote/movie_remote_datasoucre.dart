import 'package:flutter_base/core/error/error.dart';
import 'package:flutter_base/datasource/services/api/app/api_movie.dart';
import 'package:flutter_base/datasource/services/api/core/api_service.dart';
import 'package:flutter_base/features/data/model/movie_model.dart';

abstract class MovieRemoteDatasource {
  Future<List<MovieModel>> fetchMoviesList();
}

class MovieRemoteDatasourceImplement implements MovieRemoteDatasource {
  @override
  Future<List<MovieModel>> fetchMoviesList() async {
    try {
      final input = FetchMoviesInput();
      final output = await APIService.shared.fetchMovieData(input);
      final movies = output.movies;
      if (movies != null) {
        return movies;
      }
      throw ServerException('Get movie faiture!');
    } on ServerException catch (error) {
      throw ServerFailure(error.message);
    }
  }
}
