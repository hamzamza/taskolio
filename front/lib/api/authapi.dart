import 'package:front/Models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';

//
/// login  ---------------------------

Future<bool> Login(String username, String password) async {
  String? apiKey = dotenv.env['URL'];
  var url = Uri.parse("$apiKey/auth/login");
  var body = json.encode({'username': username, 'password': password});

  var headers = {'Content-Type': 'application/json'};

  try {
    var response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200 || response.statusCode == 203) {
      var data = json.decode(response.body);

      await User.putProfile(
          email: data['email'],
          username: data['username'],
          profileImagePath: 'imageurl',
          token: data['token']);

      return true;
    } else {
      return false;
    }
  } catch (e) {
    print('Error  in logein page: $e');
    return false;
  }
}
