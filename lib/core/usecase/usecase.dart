// ignore_for_file: depend_on_referenced_packages

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../error/error.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
