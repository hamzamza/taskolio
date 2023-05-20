
import 'package:flutter/material.dart';
import 'package:front/Models/category.dart';
import 'package:front/Models/repetation.dart';
import 'package:front/Models/task.dart';
import 'package:front/controllers/TaskController.dart';
import 'package:front/controllers/screens_controller.dart';
import 'package:front/widgets/Menu/ShowDateMenu.dart';
import 'package:front/widgets/Menu/ShowPriorityMenu.dart';
import 'package:front/widgets/Menu/ShowReminderMenu.dart';
import 'package:front/widgets/Menu/ShowRepeatMenu.dart';
import 'package:front/widgets/TaskWidget.dart';
import 'package:front/widgets/menu_bottom.dart';
import 'package:get/get.dart';
import 'package:flutter_ui_toolkit/flutter_ui_toolkit.dart';
import 'package:intl/intl.dart';

class ListScreen extends StatelessWidget {
  ListScreen(){

  }
  TaskController taskController=Get.put(TaskController());
  final String CategoryId =Get.arguments ;
  late Category category;
  @override
  Widget build(BuildContext context) {
    //print("the title isss:${taskController.category.value.tasks!.length}  id: ${CategoryId}");
    //ScreenController screenConctroller = Get.put(ScreenController());
    taskController.getCategory(CategoryId);
    //int listindex = screenConctroller.selectedScreen;

       return
            Scaffold(
              body: Obx(()=>GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 5,
                ),
                itemCount: taskController.ListTask.length,
                itemBuilder: (context,index)=>ListCadrd(context, taskController.ListTask[index], taskController),
              ),),
          appBar: AppBar(
            actions: [
              PopupMenuButton(
                  elevation: 4,
                  shadowColor: const Color.fromARGB(87, 0, 0, 0),
                  // add icon, by default "3 dot" icon
                  iconSize: 30,
                  // icon: Icon(Icons.book)
                  itemBuilder: (context) {
                    return [
                      const PopupMenuItem<int>(
                        value: 0,
                        child: Text("Selectionner des Tâches "),
                      ),
                    ];
                  },
                  onSelected: (value) {}),
            ],
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Colors.white,
            title: Row(
              children:  [
                Icon(Icons.text_snippet_rounded),
                SizedBox(
                  width: 20,
                ),
                GestureDetector(
                    child: Text("salam"),
                     onTap: (){
                       //buildShowModalBottomSheet(context,task);
                     },
                )
              ],
            ),
           ),
          bottomNavigationBar: Container(height: 70, child:   Menubottom(from_category: true,)),
            );

  }


  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.grey;
    }
    return Colors.black;
  }





}


