part of 'atrian_bloc_bloc.dart';

@immutable
sealed class AtrianBlocEvent {}

class AtrianEventBlocInitial extends AtrianBlocEvent {}

class AtrianEventBlocLoading extends AtrianBlocEvent {}

class AtrianEventBlocGetlist extends AtrianBlocEvent {}

class AtrianEventBlocGetAntrianNow extends AtrianBlocEvent {}

class AtrianEventBlocStatus extends AtrianBlocEvent {
  final String id;

  AtrianEventBlocStatus({required this.id});
}
