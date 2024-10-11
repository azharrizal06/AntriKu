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
  final DataAntrianSekarang? antrian;
  // final AntrainNow;
  AtrianstateBlocStateListantrian({
    this.antrian,
    this.listantrian,
  });
}

final class AtrianstateBlocStateantrinext extends AtrianBlocState {
  final DataAntrianSekarang? antrian;
  AtrianstateBlocStateantrinext({
    this.antrian,
  });
}
