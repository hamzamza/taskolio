import 'package:flutter/material.dart';
import 'package:front/Models/list.dart';
import 'package:front/controllers/Listcontroller.dart';
import 'package:front/controllers/TaskController.dart';
import 'package:front/widgets/TaskWidget.dart';
import 'package:get/get.dart';
import 'package:front/main.dart';

import '../widgets/menu_bottom.dart';

class ListTask extends StatelessWidget {
   ListTask();
   ListController listController=Get.put(ListController());
   TaskController taskController=Get.put(TaskController());
  @override
  Widget build(BuildContext context) {

    final String TaskId=Get.arguments!=null? Get.arguments : "";
    listController.getListById(TaskId);
    return  Obx(() =>
        Scaffold(
          backgroundColor: listController.list.value.them,
          appBar: AppBar(
            backgroundColor: listController.list.value.them,
            title: Container(
              child: Row(
                children: [
                  Obx(() => Text(
                    '${ listController.list.value.title }' ,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight:FontWeight.bold
                    ),
                  ),
                  )
                ],
              ),
            ),
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.white),

          ),
          body: Container(
            height: MediaQuery.of(context).size.height*1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    listController.list.value.them.withOpacity(1.0) ,
                    listController.list.value.them.withOpacity(0.5) ,
                  ]
              ),
            ),
             child: Obx(()=>ListView.builder(
               itemCount: listController.list.value.tasks.length,
               itemBuilder: (BuildContext context, int index) {
                  return ListCadrd(context, listController.list.value.tasks[index], taskController,index);
               },
             )),
          ),
          bottomNavigationBar: Container(height: 70, child:   Menubottom(from_list: true,)),
        )
    );
  }
}
