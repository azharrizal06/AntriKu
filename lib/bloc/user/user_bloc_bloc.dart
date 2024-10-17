import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import '../../Model/GetAntriUser.dart';
import '../../Model/antriansekarang.dart';
import '../../help/help.dart';
import '../../help/localData.dart';

part 'user_bloc_event.dart';
part 'user_bloc_state.dart';

class UserBlocBloc extends Bloc<UserBlocEvent, UserBlocState> {
  UserBlocBloc() : super(UserBlocInitial()) {
    on<UserBlocEventGetAntriUser>((event, emit) async {
      emit(UserBlocLoading());
      try {
        var token = await LocalData().GetDataAuth();
        print(token?.token);
        var response = await http.get(
          Uri.parse("$bashUrl/api/antrian/${token?.user?.id}/user"),
          headers: {
            'Authorization': 'Bearer ${token?.token}',
            'Accept': 'application/json',
          },
        );
        print(response.statusCode);
        if (response.statusCode == 200) {
          var body = json.decode(response.body);
          print(body);
          GetantriUser respon = GetantriUser.fromMap(body);

          emit(UserBlocSuccess(data: respon.data));
        } else {
          emit(UserBlocFailed(message: "Gagal mengambil data antrian"));
        }
      } catch (e) {
        emit(UserBlocFailed(message: "Terjadi kesalahan: ${e.toString()}"));
      }
    });

    on<UserBlocEventGetAntriNow>((event, emit) async {
      emit(UserBlocLoading());
      try {
        var token = await LocalData().GetDataAuth();
        var response = await http.get(
          Uri.parse("$bashUrl/api/antrian/saatini"),
          headers: {
            'Authorization': 'Bearer ${token?.token}',
            'Accept': 'application/json',
          },
        );
        print(response.statusCode);
        if (response.statusCode == 200) {
          var body = json.decode(response.body);
          print(body);
          AntrianSekarang respon = AntrianSekarang.fromMap(body);

          print(respon.antrian?.nama);

          emit(UserBlocSuccess(datanow: respon.antrian));
        } else {
          emit(UserBlocFailed(message: "Gagal mengambil data antrian"));
        }
      } catch (e) {
        emit(UserBlocFailed(message: "Terjadi kesalahan: ${e.toString()}"));
      }
    });

    on<UserBlocEventCreateAntri>((event, emit) async {
      emit(UserBlocLoading());
      try {
        var token = await LocalData().GetDataAuth();
        var response = await http.post(
          Uri.parse("$bashUrl/api/antrian/create"),
          headers: {
            'Authorization': 'Bearer ${token?.token}',
            'Accept': 'application/json',
          },
          body: {
            "nama": token?.user?.name,
          },
        );
        print(response.statusCode);
        if (response.statusCode == 200) {
          var body = json.decode(response.body);
          print(body);
          GetantriUser respon = GetantriUser.fromMap(body);

          emit(UserBlocSuccess(data: respon.data));
        } else {
          emit(UserBlocFailed(message: "Gagal mengambil data antrian"));
        }
      } catch (e) {
        emit(UserBlocFailed(message: "Terjadi kesalahan: ${e.toString()}"));
      }
    });
  }
}
