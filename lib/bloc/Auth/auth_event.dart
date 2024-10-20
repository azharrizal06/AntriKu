part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

//aksi

//aksi login
final class AuthEventLogin extends AuthEvent {
  final String email;
  final String password;
  AuthEventLogin({required this.email, required this.password});
}

//aksi logout
final class AuthEventLogout extends AuthEvent {}

//aksi register
final class AuthEventRegister extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final String role;
  AuthEventRegister(
      {required this.name,
      required this.email,
      required this.password,
      required this.role});
}
