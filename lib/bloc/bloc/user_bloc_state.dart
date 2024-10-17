part of 'user_bloc_bloc.dart';

@immutable
sealed class UserBlocState {}

final class UserBlocInitial extends UserBlocState {}

final class UserBlocSuccess extends UserBlocState {
  final GetantriUser? data;
  final DataAntrianSekarang? datanow;
  UserBlocSuccess({this.data, this.datanow});
}

final class UserBlocFailed extends UserBlocState {
  final String message;
  UserBlocFailed({required this.message});
}

final class UserBlocLoading extends UserBlocState {}
