import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:repat_event/core/errors/use_case_failure.dart';

abstract class UseCase<Type, Params> {
  String get identifier;
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
