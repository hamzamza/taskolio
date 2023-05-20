
import 'package:flutter/material.dart';

import 'package:front/Models/list.dart';
import 'package:get/get.dart';
import '../Models/task.dart';

class ListController extends GetxController{
  var GroupList=<TaskList>[].obs;
  var checked=false.obs;
  var list=TaskList(title: "list title ",them: Colors.red,icon: "").obs;

  changeChecked(){
     checked.value=!checked.value;
  }
  fetchList()async{
     print("hello in fetch lists ");
     var lists=await TaskList.getAllTaskLists();
     GroupList.value=lists;
     print("the lists length is ${GroupList.length}");
  }
  getListById(String id)async{
       print("get list by id");
       var llist=await TaskList.getTaskListById(id);
       list.value=llist!;
       print("id isssss $list.value.id}");

  }

}