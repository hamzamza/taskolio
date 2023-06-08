import 'package:flutter/material.dart';

import '../Models/task.dart';
import '../controllers/TaskController.dart';
import 'package:get/get.dart';

import '../widgets/TaskWidget.dart';
import '../widgets/menu_bottom.dart';

class FavoritScreen extends StatelessWidget {
   FavoritScreen({Key? key}) : super(key: key);
  TaskController taskController=Get.put(TaskController());
  @override
  Widget build(BuildContext context) {
    taskController.getFavoritTask();
    return  Scaffold(
       appBar: AppBar(
         title: Text("Favorite Tasks "),
         elevation: 0,
         backgroundColor: Colors.white,
       ),
      body: Obx(() => ListView.builder(
          itemCount: taskController.favoritTasks.length,
          itemBuilder: (BuildContext context, int index) {
          var task=taskController.favoritTasks[index];
          return ListCadrd(context, task, taskController,index);
         }
        ),
       ),
        bottomNavigationBar: Container(height: 70, child:   Menubottom()),
    );
  }
}
