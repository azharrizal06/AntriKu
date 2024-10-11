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
      print(event.status);
      // Fetch list antrian
      final listAntrianResponse =
          await http.post(Uri.parse("$bashUrl/api/antrian"),
              headers: {
                'Authorization': 'Bearer ${token}',
                'Accept': 'application/json',
                'Content-Type': 'application/json',
              },
              body: json.encode({
                "status": event.status == "null" ||
                        event.status == '' ||
                        event.status == null
                    ? "waiting"
                    : event.status
              }));

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
        print(listAntrianJson);
        AwaitingAntrian listAntrianData =
            AwaitingAntrian.fromMap(listAntrianJson);
        AntrianSekarang antrianNowData =
            AntrianSekarang.fromMap(antrianNowJson);

        emit(AtrianstateBlocStateListantrian(
          listantrian: listAntrianData.data,
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

    on<AtrianEventBlocStateantrinext>((event, emit) async {
      emit(AtrianstateBlocLoading());
      var token;

      await LocalData().GetDataAuth().then((value) {
        token = value?.token;
      });

      // Fetch list antrian
      final respon =
          await http.patch(Uri.parse("$bashUrl/api/antrian/selesai"), headers: {
        'Authorization': 'Bearer ${token}',
        'accept': 'application/json',
      });
      print("respon next antrian${respon.statusCode}");
      if (respon.statusCode == 200) {
        print("berhasila");
        add(AtrianEventBlocGetlist());
      } else {
        emit(AtrianstateBlocStateFailed(
            message: "Gagal mengambil data antrian"));
      }
    });
  }
}
