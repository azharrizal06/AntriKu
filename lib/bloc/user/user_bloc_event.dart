part of 'user_bloc_bloc.dart';

@immutable
sealed class UserBlocEvent {}

final class UserBlocEventGetAntriUser extends UserBlocEvent {}

final class UserBlocEventGetAntriNow extends UserBlocEvent {}

final class UserBlocEventCreateAntri extends UserBlocEvent {}
