// ignore_for_file: unnecessary_import, depend_on_referenced_packages, prefer_const_constructors_in_immutables

import 'package:dartz/dartz.dart';
import 'package:flutter_base/core/error/error.dart';
import 'package:flutter_base/core/error/failure.dart';
import 'package:flutter_base/core/platform/network_info.dart';
import 'package:flutter_base/datasource/remote/movie_remote_datasoucre.dart';
import 'package:flutter_base/features/domain/entities/movie_entity.dart';
import 'package:flutter_base/features/domain/repositoties/movie_repository.dart';

class FetchMovieFailure extends Failure {
  final String message;
  FetchMovieFailure(this.message);
}

class MovieRepositoryImplement implements MovieRepository {
  final MovieRemoteDatasource movieRemoteDatasource;
  final NetworkInfo networkInfo;

  MovieRepositoryImplement({
    required this.movieRemoteDatasource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<MovieEntity>>> fetchMoviesList() async {
    if (await networkInfo.isConnected) {
      try {
        final movies = await movieRemoteDatasource.fetchMoviesList();
        return Right(movies);
      } on ServerException catch (error) {
        return Left(FetchMovieFailure(error.message));
      }
    } else {
      throw NetworkFailure();
    }
  }
}
