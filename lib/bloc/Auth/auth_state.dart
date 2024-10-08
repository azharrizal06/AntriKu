part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

// kondisi awal
final class AuthStateInitial extends AuthState {}

//kondisi awal login
final class AuthStateLogin extends AuthState {}

//kondisi awal loading
final class AuthStateLoading extends AuthState {}

//kondisi awal logout
final class AuthStateLogout extends AuthState {
  final String token;
  AuthStateLogout({required this.token});
}

//kondisi awal error
final class AuthStateError extends AuthState {
  final String message;
  AuthStateError({required this.message});
}

//kondisi awal register
final class AuthStateRegister extends AuthState {}
