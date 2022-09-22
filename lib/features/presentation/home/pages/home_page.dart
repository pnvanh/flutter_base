// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_base/features/presentation/home/blocs/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_base/features/presentation/home/home.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: BlocProvider<HomeBloc>(
    //     create: (context) => HomeBloc()
    //       ..add(
    //         MovieLoadDataRequested(),
    //       ),
    //     child: HomeBody(),
    //   ),
    // );
    return Scaffold(
      body: BlocProvider<HomeBloc>(
          create: (context) => HomeBloc()
            ..add(
              MovieLoadDataRequested(),
            ),
          child: HomeBody()),
    );
  }
}
