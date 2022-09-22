// ignore_for_file: import_of_legacy_library_into_null_safe, unused_import, depend_on_referenced_packages

import 'package:flutter_base/core/platform/network_info.dart';
import 'package:flutter_base/datasource/remote/movie_remote_datasoucre.dart';
import 'package:flutter_base/features/data/repositories/movie_repository_implement.dart';
import 'package:flutter_base/features/domain/repositoties/movie_repository.dart';
import 'package:flutter_base/features/domain/usecase/movie_usercase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_base/features/presentation/home/blocs/home_event.dart';
import 'package:flutter_base/features/presentation/home/blocs/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial());

  final MoviesDataUseCase moviesDataUseCase = MoviesDataUseCase(
      movieRepository: MovieRepositoryImplement(
    movieRemoteDatasource: MovieRemoteDatasourceImplement(),
    networkInfo: NetworkInfoImplement(),
  ));

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is MovieLoadDataRequested) {
      yield* mapLoadDataToState(event);
    }
  }

  Stream<HomeState> mapLoadDataToState(MovieLoadDataRequested event) async* {
    try {
      final movies = await moviesDataUseCase.call(Params());
      yield* movies.fold((l) async* {
        yield HomeLoadMoviesDataFailure(message: 'Load Movies data failture');
      }, (r) async* {
        yield HomeLoadMoviesDataSuccess(movies: r);
      });
    } on FetchMovieFailure catch (error) {
      yield HomeLoadMoviesDataFailure(message: error.message);
    }
  }
}
