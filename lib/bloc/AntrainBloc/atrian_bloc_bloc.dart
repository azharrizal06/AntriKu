import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import '../../Model/antriansekarang.dart';
import '../../Model/listantrianmodel.dart';
import '../../help/help.dart';
import '../../help/localData.dart';

part 'atrian_bloc_event.dart';
part 'atrian_bloc_state.dart';

class AtrianBlocBloc extends Bloc<AtrianBlocEvent, AtrianBlocState> {
  AtrianBlocBloc() : super(AtrianStateBlocInitial()) {
    //get list antrian admin
    on<AtrianEventBlocGetlist>((event, emit) async {
      emit(AtrianstateBlocLoading());
      var token;
      await LocalData().GetDataAuth().then((value) {
        token = value?.token;
      });
      await http.get(Uri.parse("$bashUrl/api/antrian"), headers: {
        'Authorization': 'Bearer ${token}',
        'Content-Type': 'application/json',
      }).then((value) {
        print("status code list antrian ${value.statusCode}");
        var response = json.decode(value.body);

        if (value.statusCode == 200) {
          print(token);
          AwaitingAntrian antrianData = AwaitingAntrian.fromMap(response);

          emit(AtrianstateBlocStateListantrian(
              listantrian: antrianData.data ?? []));
        } else {
          emit(AtrianstateBlocStateFailed(message: response['message']));
        }
      });
    });
    //ongoing
    on<AtrianEventBlocStatus>((event, emit) async {
      emit(AtrianstateBlocLoading());
      var token;
      var id = event.id;
      await LocalData().GetDataAuth().then((value) {
        token = value?.token;
      });
      await http.patch(Uri.parse("$bashUrl/api/antrian/$id/select"), headers: {
        'Authorization': 'Bearer ${token}',
        'accept': 'application/json',
      }).then((value) {
        print("respon ubh status ${value.statusCode}");
        print(value.body);
        var response = json.decode(value.body);

        if (value.statusCode == 200) {
          print(token);
          AntrianSekarang antrianData = AntrianSekarang.fromMap(response);

          add(AtrianEventBlocGetlist());
          emit(AtrianstateBlocStateantrinow(antrian: antrianData.antrian));
        } else {
          add(AtrianEventBlocGetlist());
          emit(AtrianstateBlocStateFailed(message: response['message']));
        }
      });
    });
  }
}
