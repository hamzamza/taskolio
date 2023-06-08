import 'package:flutter/material.dart';
import 'package:front/Models/project.dart';
import 'package:front/api/Projet.dart';
import 'package:get/get.dart';

class ProjectController extends GetxController{
       var ProjectList=<Project>[].obs;
       var project=Project(title: "", them: Colors.white).obs;
       var SectionTitle="".obs;
       var checked=false.obs;
       var favorite=false.obs;
       var projectRole="owner".obs;
   changeChecked(){
       checked.value=!checked.value;
   }
   fetchProject()async{
        print("hello in fetch project ");
        var projects=await getAllProject();
        ProjectList.value=projects;
        print("project length is ${ProjectList.length}");
   }
   getProjectById(String id)async{
        print("get project by the id ${id}");
        var pproject=await GetProjectById(id);
        project.value=pproject;
        print("the current project is ${project.value.title}");
   }
   creatProject(Project project)async{
        print("create project with id ${project.id}");
        await CreateProject(project);
        await fetchProject();
   }
  addSection(String title)async{
       print("hello in add Section ");
       await AddSection(project.value.id, title);
       var pproject=await GetProjectById(project.value.id);
       project.value=pproject;
  }
   Future<String>  addMemberProject(String email,String Role, String Message)async{
    Map<String,dynamic> msg= await AddMember(project.value.id, email, Role, Message);
     return msg['msg'];
  }
}