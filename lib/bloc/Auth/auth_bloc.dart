import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import '../../help/help.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthStateLogout()) {
    on<AuthEventLogin>((event, emit) async {
      emit(AuthStateLoading());
      var resphone = await http.post(Uri.parse("$bashUrl/api/login"),
          body: {"email": event.email, "password": event.password});
      print("statuscode ${resphone.statusCode}");
      if (resphone.statusCode == 200) {
        var data = jsonDecode(resphone.body);
        print("Data Login : $data");
        emit(AuthStateLogin());
      } else {
        emit(AuthStateError());
      }
    });

    on<AuthEventLogout>((event, emit) async {
      emit(AuthStateLogout());
    });
    on<AuthEventRegister>((event, emit) async {
      emit(AuthStateRegister());
    });
  }
}
