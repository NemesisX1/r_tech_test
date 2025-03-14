import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

class EventsFetchFailure extends Failure {}

class RegisterUserForEventFailure extends Failure {}
