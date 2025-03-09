part of 'auth_cubit.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthAuthenticatedState extends AuthState {}

final class AuthProcessingState extends AuthState {}

final class AuthFailedState extends AuthState {}
