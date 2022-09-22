import 'package:flutter_base/core/error/exception.dart';
import 'package:flutter_base/core/error/failure.dart';
import 'package:flutter_base/datasource/services/api/app/api_url.dart';
import 'package:flutter_base/datasource/services/api/core/core.dart';
import 'package:flutter_base/features/data/model/movie_model.dart';

extension APIMovie on APIService {
  Future<FetchMoviesOutput> fetchMovieData(FetchMoviesInput input) async {
    try {
      final output = await APIService.shared.requestGet(input);
      return FetchMoviesOutput(output.json);
    } on ServerException catch (error) {
      throw ServerFailure(error.message);
    }
  }
}

class FetchMoviesInput extends APIBaseInput {
  FetchMoviesInput()
      : super(
          url: APIURL.popular,
        );
}

class FetchMoviesOutput extends APIBaseOutput {
  FetchMoviesOutput(Map<String, dynamic> json) : super(json);

  List<MovieModel>? movies;

  @override
  mapping(Map<String, dynamic> json) {
    super.mapping(json);

    if ((json['results'] as List).isNotEmpty) {
      movies = (json['results'] as List)
          .map((json) => MovieModel.fromJson(json))
          .toList();
    }
  }
}
