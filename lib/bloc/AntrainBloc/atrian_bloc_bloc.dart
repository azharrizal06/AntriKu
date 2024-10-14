import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import '../../Model/antriansekarang.dart';
import '../../Model/listantrianmodel.dart';
import '../../Model/pendingmodel.dart';
import '../../help/help.dart';
import '../../help/localData.dart';

part 'atrian_bloc_event.dart';
part 'atrian_bloc_state.dart';

class AtrianBlocBloc extends Bloc<AtrianBlocEvent, AtrianBlocState> {
  AtrianBlocBloc() : super(AtrianStateBlocInitial()) {
    // Get list antrian admin
    on<AtrianEventBlocGetlist>(_getListAntrian);
    // Ubah status menjadi ongoing
    on<AtrianEventBlocStatus>(_changeStatus);
    // Next antrian
    on<AtrianEventBlocStateantrinext>(_nextAntrian);
    // Pending antrian
    on<AtrianEventBlocPending>(_pendingAntrian);
  }

  Future<void> _getListAntrian(
      AtrianEventBlocGetlist event, Emitter<AtrianBlocState> emit) async {
    emit(AtrianstateBlocLoading());

    try {
      var token = await _getToken();

      // Fetch list antrian
      final listAntrianResponse = await http.post(
        Uri.parse("$bashUrl/api/antrian"),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "status": event.status == "null" ||
                  event.status == '' ||
                  event.status == null
              ? "waiting"
              : event.status
        }),
      );

      // Antrian saat ini
      final antrianNowResponse = await http.get(
        Uri.parse("$bashUrl/api/antrian/saatini"),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      final response = await http.post(
        Uri.parse("$bashUrl/api/antrian"),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
        body: {"status": "pending"},
      );
      final responseselesai = await http.post(
        Uri.parse("$bashUrl/api/antrian"),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
        body: {"status": "completed"},
      );

      if (listAntrianResponse.statusCode == 200 &&
          antrianNowResponse.statusCode == 200 &&
          response.statusCode == 200 &&
          responseselesai.statusCode == 200) {
        var listAntrianJson = json.decode(listAntrianResponse.body);
        var antrianNowJson = json.decode(antrianNowResponse.body);
        var pendingBody = json.decode(response.body);
        var selesaipendingBody = json.decode(responseselesai.body);
        Pendingmodel responPending = Pendingmodel.fromMap(pendingBody);
        Pendingmodel selesai = Pendingmodel.fromMap(selesaipendingBody);

        AwaitingAntrian listAntrianData =
            AwaitingAntrian.fromMap(listAntrianJson);
        AntrianSekarang antrianNowData =
            AntrianSekarang.fromMap(antrianNowJson);

        emit(AtrianstateBlocStateListantrian(
          listantrian: listAntrianData.data,
          antrian: antrianNowData.antrian,
          pendingdata: responPending.data,
          selesai: selesai.data,
        ));
      } else {
        emit(AtrianstateBlocStateFailed(
            message: "Gagal mengambil data antrian atau antrian saat ini"));
      }
    } catch (e) {
      emit(AtrianstateBlocStateFailed(
          message: "Terjadi kesalahan: ${e.toString()}"));
    }
  }

  Future<void> _changeStatus(
      AtrianEventBlocStatus event, Emitter<AtrianBlocState> emit) async {
    emit(AtrianstateBlocLoading());
    try {
      var token = await _getToken();
      var id = event.id;

      final response = await http.patch(
        Uri.parse("$bashUrl/api/antrian/$id/select"),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        add(AtrianEventBlocGetlist());
      } else {
        var errorResponse = json.decode(response.body);
        emit(AtrianstateBlocStateFailed(message: errorResponse['message']));
      }
    } catch (e) {
      emit(AtrianstateBlocStateFailed(
          message: "Terjadi kesalahan: ${e.toString()}"));
    }
  }

  Future<void> _nextAntrian(AtrianEventBlocStateantrinext event,
      Emitter<AtrianBlocState> emit) async {
    emit(AtrianstateBlocLoading());
    try {
      var token = await _getToken();

      final response = await http.patch(
        Uri.parse("$bashUrl/api/antrian/selesai"),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        add(AtrianEventBlocGetlist());
      } else {
        emit(AtrianstateBlocStateFailed(
            message: "Gagal mengambil data antrian"));
      }
    } catch (e) {
      emit(AtrianstateBlocStateFailed(
          message: "Terjadi kesalahan: ${e.toString()}"));
    }
  }

  Future<void> _pendingAntrian(
      AtrianEventBlocPending event, Emitter<AtrianBlocState> emit) async {
    emit(AtrianstateBlocLoading());
    try {
      var token = await _getToken();

      final response = await http.post(
        Uri.parse("$bashUrl/api/antrian"),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
        body: {"status": "pending"},
      );

      if (response.statusCode == 200) {
        var pendingBody = json.decode(response.body);
        Pendingmodel responPending = Pendingmodel.fromMap(pendingBody);
        print(responPending.data?.length);
        emit(AtrianstateBlocStateListantrian(pendingdata: responPending.data));
      } else {
        emit(AtrianstateBlocStateFailed(
            message: "Gagal mengambil data antrian"));
      }
    } catch (e) {
      emit(AtrianstateBlocStateFailed(
          message: "Terjadi kesalahan: ${e.toString()}"));
    }
  }

  Future<String> _getToken() async {
    var token;
    await LocalData().GetDataAuth().then((value) {
      token = value?.token;
    });
    return token;
  }
}
