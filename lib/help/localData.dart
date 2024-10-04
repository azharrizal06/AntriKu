import 'package:shared_preferences/shared_preferences.dart';

import '../Model/AuthModel.dart';

//save data login
class LocalData {
  Future<void> SaveDataAuth(Auth auth) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('auth', auth.toJson());
    print("data save");
    print(auth.toJson());
  }

//Get data login
  Future<Auth?> GetDataAuth() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? auth = prefs.getString('auth');
    if (auth != null) {
      return Auth.fromJson(auth);
    }
    return null;
  }

  //Delete data login
  Future<void> DeleteDataAuth() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('auth');
  }

  //IsLogin
  Future<bool> IsLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey("auth");
  }
}
