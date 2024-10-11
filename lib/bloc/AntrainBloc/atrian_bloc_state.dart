part of 'atrian_bloc_bloc.dart';

@immutable
sealed class AtrianBlocState {}

final class AtrianStateBlocInitial extends AtrianBlocState {}

final class AtrianstateBlocLoading extends AtrianBlocState {}

final class AtrianstateBlocPending extends AtrianBlocState {
  List<Antrian>? antrian;

  AtrianstateBlocPending({this.antrian});
}

final class AtrianstateBlocStateFailed extends AtrianBlocState {
  final String message;
  AtrianstateBlocStateFailed({
    required this.message,
  });
}

final class AtrianstateBlocStateListantrian extends AtrianBlocState {
  final List<Antrian>? listantrian;
  final DataAntrianSekarang? antrian;
  List<Datapending>? pendingdata;
  // final AntrainNow;
  AtrianstateBlocStateListantrian({
    this.antrian,
    this.listantrian,
    this.pendingdata,
  });
}

final class AtrianstateBlocStateantrinext extends AtrianBlocState {
  final DataAntrianSekarang? antrian;
  AtrianstateBlocStateantrinext({
    this.antrian,
  });
}
