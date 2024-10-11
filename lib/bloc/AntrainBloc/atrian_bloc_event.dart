part of 'atrian_bloc_bloc.dart';

@immutable
sealed class AtrianBlocEvent {}

class AtrianEventBlocInitial extends AtrianBlocEvent {}

class AtrianEventBlocLoading extends AtrianBlocEvent {}

class AtrianEventBlocPending extends AtrianBlocEvent {}

class AtrianEventBlocGetlist extends AtrianBlocEvent {
  String? status;

  AtrianEventBlocGetlist({this.status});
}

class AtrianEventBlocStateantrinext extends AtrianBlocEvent {}

class AtrianEventBlocStatus extends AtrianBlocEvent {
  final String id;

  AtrianEventBlocStatus({required this.id});
}
