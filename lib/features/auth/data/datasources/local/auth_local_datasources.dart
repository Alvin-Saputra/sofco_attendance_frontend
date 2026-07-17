import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDatasources {
  final SharedPreferences prefs;
  
 AuthLocalDatasources(this.prefs);

  

  Future<void> saveUserId(int userId) async {
    await prefs.setInt('userId', userId);
  }
  Future<void> saveUserName(String userName) async {
    await prefs.setString('userName', userName);
  }
  
  Future<void> saveToken(String token) async {
    await prefs.setString('token', token);
  }


  int? getUserId() {
    return prefs.getInt('userId');
  }

  String? getUserName() {
    return prefs.getString('userName');
  }
  String? getToken() {
    return prefs.getString('token');
  }

  Future<void> clearAuthData() async {
    await prefs.remove('userId');
    await prefs.remove('userName');
    await prefs.remove('token');
  }
}



