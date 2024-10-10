part of 'atrian_bloc_bloc.dart';

@immutable
sealed class AtrianBlocState {}

final class AtrianStateBlocInitial extends AtrianBlocState {}

final class AtrianstateBlocLoading extends AtrianBlocState {}

final class AtrianstateBlocStateFailed extends AtrianBlocState {
  final String message;
  AtrianstateBlocStateFailed({
    required this.message,
  });
}

final class AtrianstateBlocStateListantrian extends AtrianBlocState {
  final List<Antrian>? listantrian;
  // final AntrainNow;
  AtrianstateBlocStateListantrian({
    this.listantrian,
  });
}

final class AtrianstateBlocStateantrinow extends AtrianBlocState {
  final DataAntrianSekarang? antrian;
  AtrianstateBlocStateantrinow({
    this.antrian,
  });
}
