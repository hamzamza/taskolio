


import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:front/Models/project.dart';

import '../controllers/TaskController.dart';

Future<List<Project>> getAllProject()async{
  print("hello in get All Project ");
  String? apiKey = dotenv.env['URL'];
  var url = Uri.parse("${apiKey}/project");
  const token='eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NDYyZTE3ZTE0MzRhMjZkNjYwZTdjY2UiLCJ1c2VybmFtZSI6IjEiLCJpYXQiOjE2ODQ1MzY2MDcsImV4cCI6MTY4NzEyODYwN30.qf2KuD5JEl_nzxdHgX-XVGMygS1sNGHG1BckXkjwUQU';
  const headers = {'Content-Type': 'application/json','Authorization': token};
  var response = await http.get(url, headers: headers);
  if (response.statusCode == 200) {
    print('get cateogorie succefly');
    // Parse the JSON response and return a list of MyClass objects
    List<dynamic> jsonResponse = jsonDecode(response.body);
    return jsonResponse.map((json) => Project.fromJson(json)).toList();
  } else {
    print(" the status code is  ${response.body}");
    throw Exception('Failed to load data');
  }

}
Future<Project> GetProjectById(String id)async {
  print("api project id is ${id}");
  String? apiKey = dotenv.env['URL'];
  var url = Uri.parse("${apiKey}/project/byId");
  const token='eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NDYyZTE3ZTE0MzRhMjZkNjYwZTdjY2UiLCJ1c2VybmFtZSI6IjEiLCJpYXQiOjE2ODQ1MzY2MDcsImV4cCI6MTY4NzEyODYwN30.qf2KuD5JEl_nzxdHgX-XVGMygS1sNGHG1BckXkjwUQU';
  const headers = {'Content-Type': 'application/json', 'Authorization': token};
  var Body = jsonEncode({'projectId': '$id' });

  var response = await http.post(url, headers: headers,body: Body);
  if (response.statusCode == 200) {
    print('get proejct succefly');
    // Parse the JSON response and return a list of MyClass objects
    var jsonResponse = jsonDecode(response.body);
    return Project.fromJson(jsonResponse);
  } else {
    print("status is ${ response.statusCode}");
    throw Exception('Failed to load data');
  }
}
Future<bool> CreateProject(Project project)async {
  print("api projecttttt id is ${project.id}");
  String? apiKey = dotenv.env['URL'];
  var url = Uri.parse("${apiKey}/project/create");
  const token='eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NDYyZTE3ZTE0MzRhMjZkNjYwZTdjY2UiLCJ1c2VybmFtZSI6IjEiLCJpYXQiOjE2ODQ1MzY2MDcsImV4cCI6MTY4NzEyODYwN30.qf2KuD5JEl_nzxdHgX-XVGMygS1sNGHG1BckXkjwUQU';
  const headers = {'Content-Type': 'application/json', 'Authorization': token};
  var Body = jsonEncode({'projectData':{'title': '${project.title}','them':1,'desc':'' } });

  var response = await http.post(url, headers: headers,body: Body);
  if (response.statusCode == 200) {
    print('create  proejct succefly');
    // Parse the JSON response and return a list of MyClass objects
    var jsonResponse = jsonDecode(response.body);
    return true ;
  } else {
    print("status is ${ response.statusCode}");
    throw Exception('Failed to load data');
  }
}
Future<bool> AddSection(String projectId,String title)async {
  print("api projecttttt id is ${projectId} section ${title}");
  String? apiKey = dotenv.env['URL'];
  var url = Uri.parse("${apiKey}/project/section/create");
  const token='eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NDYyZTE3ZTE0MzRhMjZkNjYwZTdjY2UiLCJ1c2VybmFtZSI6IjEiLCJpYXQiOjE2ODQ1MzY2MDcsImV4cCI6MTY4NzEyODYwN30.qf2KuD5JEl_nzxdHgX-XVGMygS1sNGHG1BckXkjwUQU';
  const headers = {'Content-Type': 'application/json', 'Authorization': token};
  var Body = jsonEncode({'projectId':projectId,'sectionData':{"title": title}});

  var response = await http.post(url, headers: headers,body: Body);
  if (response.statusCode == 200) {
    print('section   proejct succefly');
    // Parse the JSON response and return a list of MyClass objects
    var jsonResponse = jsonDecode(response.body);
    return true ;
  } else {
    print("status is ${ response.statusCode}");
    throw Exception('Failed to load data');
  }
}

/*Future<bool> AddTaskInProject(String projectId,int index)async {
 TaskController taskController=Get.put(TaskController());
  print("api projecttttt id is ${projectId} section ${title}");
  String? apiKey = dotenv.env['URL'];
  var url = Uri.parse("${apiKey}/project/section/create");
  const token='eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NDYyZTE3ZTE0MzRhMjZkNjYwZTdjY2UiLCJ1c2VybmFtZSI6IjEiLCJpYXQiOjE2ODQ1MzY2MDcsImV4cCI6MTY4NzEyODYwN30.qf2KuD5JEl_nzxdHgX-XVGMygS1sNGHG1BckXkjwUQU';
  const headers = {'Content-Type': 'application/json', 'Authorization': token};

  var Body = jsonEncode({
      "projectId":projectId ,
      "sectionIndex":index,
      "taskData": {
      "title": taskControll,
      "id": "1",
      "desc": "Create API endpoint for user login functionality",
      "isTimed": false,
      "start": null,
      "end": null,
      "dueDate": "2023-05-31",
      "isRepeated": false,
      "repetationType": null,
      "repetations": [],
      "reminder": false,
      "reminderInterval": null,
      "progress": 0,
      "isDone": false,
      "preority": null,
      "favorite": false,
      "bin": false,
      "isInproject": true,
      "projectId": "64610c000d961dcabae9de5e",
      "sectionIndex": null,
      "assignedtoId": null,
      "isInCategory": false,
      "categorieId": null,
      "subtasks": []
  });

  var response = await http.post(url, headers: headers,body: Body);
  if (response.statusCode == 200) {
    print('section   proejct succefly');
    // Parse the JSON response and return a list of MyClass objects
    var jsonResponse = jsonDecode(response.body);
    return true ;
  } else {
    print("status is ${ response.statusCode}");
    throw Exception('Failed to load data');
  }
}*/
