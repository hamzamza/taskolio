import 'package:shared_preferences/shared_preferences.dart';

Future<bool> putinStorage(params) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', params);
  return true;
}

Future<String?> getStroage() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var toekn = await prefs.getString('token');
  return toekn;
}
