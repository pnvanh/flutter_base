// ignore_for_file: depend_on_referenced_packages

import 'package:equatable/equatable.dart';
import 'package:flutter_base/features/domain/entities/movie_entity.dart';

class HomeState extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class HomeInitial extends HomeState {}

class HomeLoadMoviesDataSuccess extends HomeState {
  final List<MovieEntity> movies;

  HomeLoadMoviesDataSuccess({required this.movies});

  @override
  List<Object?> get props => [movies];
}

class HomeLoadMoviesDataFailure extends HomeState {
  String message;

  HomeLoadMoviesDataFailure({required this.message});
  @override
  List<Object?> get props => [message];
}
