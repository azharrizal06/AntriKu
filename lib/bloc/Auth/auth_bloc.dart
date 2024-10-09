import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import '../../Model/AuthModel.dart';
import '../../help/help.dart';
import '../../help/localData.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  //login
  AuthBloc() : super(AuthStateInitial()) {
    on<AuthEventLogin>((event, emit) async {
      emit(AuthStateLoading());
      var resphone = await http.post(Uri.parse("$bashUrl/api/login"),
          body: {"email": event.email, "password": event.password});
      print("statuscode ${resphone.statusCode}");
      if (resphone.statusCode == 200) {
        var data = jsonDecode(resphone.body);
        print("Data Login : $data");
        Auth auth = Auth.fromMap(data);
        await LocalData().SaveDataAuth(auth);
        emit(AuthStateLogin());
      } else if (resphone.statusCode == 401) {
        var data = jsonDecode(resphone.body);
        print(data['message']);
        emit(AuthStateError(message: data['message']));
      } else {
        var data = jsonDecode(resphone.body);
        print(data['message']);
        emit(AuthStateError(message: data['message']));
      }
    });
    //logout
    on<AuthEventLogout>((event, emit) async {
      emit(AuthStateLoading());
      var token;
      await LocalData().GetDataAuth().then((value) {
        token = value?.token;
      });
      print("Token : $token");
      var resphone = await http.post(Uri.parse("$bashUrl/api/logout"),
          headers: {"Authorization": "Bearer $token"});
      print("statuscode ${resphone.statusCode}");
      if (resphone.statusCode == 200) {
        print("berhasil");
        await LocalData().DeleteDataAuth();
        emit(AuthStateLogout(token: token));
      } else {
        var data = jsonDecode(resphone.body);
        print(data['message']);
        print("error LOGOUT");
        emit(AuthStateError(message: data['message']));
      }
    });

    //register
    on<AuthEventRegister>((event, emit) async {
      var token;
      await LocalData().GetDataAuth().then((value) {
        token = value?.token;
      });
      emit(AuthStateLoading());
      var resphone = await http.post(Uri.parse("$bashUrl/api/register"), body: {
        "name": event.name,
        "email": event.email,
        "password": event.password,
        "role": event.role,
      }, headers: {
        "Accept": "application/json"
      });
      print("statuscode ${resphone.statusCode}");
      if (resphone.statusCode == 201) {
        var data = jsonDecode(resphone.body);
        print(data['message']);

        // emit(AuthStateRegister());
        add(AuthEventLogin(email: event.email, password: event.password));
      } else if (resphone.statusCode == 401) {
        var data = jsonDecode(resphone.body);
        print(data['message']);
        emit(AuthStateError(message: data['message']));
      } else {
        var data = jsonDecode(resphone.body);
        print(data['message']);
        emit(AuthStateError(message: data['message']));
      }
    });
  }
}
