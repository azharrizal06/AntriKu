import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthStateLogout()) {
    on<AuthEventLogin>((event, emit) async {
      emit(AuthStateLoading());
      await Future.delayed(Duration(seconds: 3));
      if (event.email == 'admin' && event.password == 'admin') {
        print('login sukses');
        emit(AuthStateLogin());
      } else {
        print('login gagal');
        emit(AuthStateError());
      }
    });
  }
}
