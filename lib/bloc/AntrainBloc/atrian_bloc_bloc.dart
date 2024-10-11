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

      // Fetch list antrian
      final listAntrianResponse =
          await http.get(Uri.parse("$bashUrl/api/antrian"), headers: {
        'Authorization': 'Bearer ${token}',
        'Content-Type': 'application/json',
      });

      // Fetch antrian saat ini
      final antrianNowResponse =
          await http.get(Uri.parse("$bashUrl/api/antrian/saatini"), headers: {
        'Authorization': 'Bearer ${token}',
        'Content-Type': 'application/json',
      });

      if (listAntrianResponse.statusCode == 200 &&
          antrianNowResponse.statusCode == 200) {
        var listAntrianJson = json.decode(listAntrianResponse.body);
        var antrianNowJson = json.decode(antrianNowResponse.body);

        AwaitingAntrian listAntrianData =
            AwaitingAntrian.fromMap(listAntrianJson);
        AntrianSekarang antrianNowData =
            AntrianSekarang.fromMap(antrianNowJson);

        emit(AtrianstateBlocStateListantrian(
          listantrian: listAntrianData.data ?? [],
          antrian: antrianNowData.antrian,
        ));
      } else {
        emit(AtrianstateBlocStateFailed(
            message: "Gagal mengambil data antrian atau antrian saat ini"));
      }
    });
    //ubah status menjadiongoing
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

          add(AtrianEventBlocGetlist());
        } else {
          add(AtrianEventBlocGetlist());
          emit(AtrianstateBlocStateFailed(message: response['message']));
        }
      });
    });
  }
}
