import 'package:flutter/material.dart';
import 'package:front/controllers/TaskController.dart';
import 'package:front/main.dart';

import '../Models/task.dart';
import '../helpers/TodaysTask.dart';
import 'package:get/get.dart';

import '../widgets/TaskWidget.dart';
import '../widgets/menu_bottom.dart';

class Today extends StatelessWidget {
  Today() ;
  List<Task> todaysTask=[];
  TaskController taskController=Get.put(TaskController());
  @override
  Widget build(BuildContext context) {
   taskController.getTodayTasks();
    return Scaffold(
       appBar: AppBar(
         elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            "Today"
          ),
         leading: null,
       ),
      body: Obx(() => ListView.builder(
       itemCount: taskController.todaysTask.length,
       itemBuilder: (BuildContext context, int index) {
         var task=taskController.todaysTask[index];
         return ListCadrd(context, task, taskController,index);
        }
       )
      ),
      bottomNavigationBar: Container(height: 70, child:   Menubottom()),
    );
  }
}
