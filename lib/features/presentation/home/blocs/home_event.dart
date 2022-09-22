// ignore_for_file: depend_on_referenced_packages

import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class MovieLoadDataRequested extends HomeEvent {}
