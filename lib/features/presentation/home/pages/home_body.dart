// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_base/features/domain/entities/movie_entity.dart';
import 'package:flutter_base/features/presentation/home/blocs/home_blocs.dart';
import 'package:flutter_base/features/presentation/home/blocs/home_state.dart';
import 'package:flutter_base/features/presentation/home/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<HomeBloc, HomeState>(
          buildWhen: (previous, current) => true,
          builder: (context, state) {
            List<MovieEntity>? movies;
            if (state is HomeLoadMoviesDataSuccess) {
              movies = state.movies;
              return MovieCard(
                movies: movies,
              );
            } else {
              return Container();
            }
          }),
    );
  }
}
