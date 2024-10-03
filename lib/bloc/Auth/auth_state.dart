part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

// kondisi awal

//kondisi awal login
final class AuthStateLogin extends AuthState {}

//kondisi awal loading
final class AuthStateLoading extends AuthState {}

//kondisi awal logout
final class AuthStateLogout extends AuthState {}

//kondisi awal error
final class AuthStateError extends AuthState {}

//kondisi awal register
final class AuthStateRegister extends AuthState {}
