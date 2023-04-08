
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../Models/Category.dart';

Future<List<Category>> FetchCategories() async {
  print('fetch categories');
  String? apiKey = dotenv.env['URL'];
  var url = Uri.parse("$apiKey/category/getCategories");
  const token='eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NDBhMzQzNjk2ZTBmNjY0ZDA1ZDM5ZTIiLCJ1c2VybmFtZSI6IjEiLCJpYXQiOjE2Nzg2NDI0NDYsImV4cCI6MTY4MTIzNDQ0Nn0.pbNJDOmBG7YvSsoP7g83kT1wDH1JoMd0LLpV1G19pKQ';
  const headers = {'Content-Type': 'application/json','Authorization': token};
  var response = await http.get(url, headers: headers);
  if (response.statusCode == 200) {
     print('get cateogorie succefly');
    // Parse the JSON response and return a list of MyClass objects
    List<dynamic> jsonResponse = jsonDecode(response.body);
    return jsonResponse.map((json) => Category.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load data');
  }
}