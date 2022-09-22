// ignore_for_file: depend_on_referenced_packages, unused_import

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_base/core/error/error.dart';
import 'package:flutter_base/core/usecase/usecase.dart';
import 'package:flutter_base/features/domain/entities/movie_entity.dart';
import 'package:flutter_base/features/domain/repositoties/movie_repository.dart';

class Params extends Equatable {
  @override
  List<Object> get props => [];
}

class MoviesDataUseCase extends UseCase<List<MovieEntity>, Params> {
  final MovieRepository movieRepository;

  MoviesDataUseCase({required this.movieRepository});

  @override
  Future<Either<Failure, List<MovieEntity>>> call(Params params) async {
    return await movieRepository.fetchMoviesList();
  }
}
