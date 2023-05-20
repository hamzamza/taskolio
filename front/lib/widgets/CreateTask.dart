import 'package:flutter/material.dart';
import 'package:front/Models/category.dart';
import 'package:front/controllers/Listcontroller.dart';
import 'package:front/widgets/Menu/SelectCategoryMenu.dart';
import 'package:front/widgets/Menu/ShowDateMenu.dart';
import 'package:front/widgets/Menu/ShowPriorityMenu.dart';
import 'package:front/widgets/Menu/ShowReminderMenu.dart';
import 'package:front/widgets/Menu/ShowRepeatMenu.dart';
import 'package:get/get.dart';

import '../Models/task.dart';
import '../controllers/TaskController.dart';
void CreateTaskView({BuildContext? context,TaskController? taskController,bool InProject=false ,bool InList=false ,bool InCategory=false })async {
  ListController listController=Get.put(ListController());
  final taskTitleController = TextEditingController();
  final taskDescController = TextEditingController();
  var categories=await Category.getAllCategories();
  Get.dialog(
    ClipRRect(
      child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            padding: EdgeInsets.only(bottom: 5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 200,
                  height: 40,
                  margin: EdgeInsets.only(left: 10,top: 10),
                  child:  TextField(
                    controller: taskTitleController,
                    decoration: InputDecoration(
                        hintText: 'Task name',
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                        )
                    ),
                  ),
                ),
                Container(
                  width: 250,
                  height: 25,
                  padding:const EdgeInsets.symmetric(horizontal: 10),
                  margin:const EdgeInsets.only(left: 10,top: 5),
                  child:  TextField(
                    controller: taskDescController,
                    decoration: InputDecoration(
                        hintText: 'Description',
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        )
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        buildOption('Today', Icons.today,'0xff23850b',context!,1,taskController!,InProject , InList, InCategory),
                        buildOption('Priority', Icons.flag_outlined,'0xff173599',context!,2,taskController,InProject , InList, InCategory),
                        buildOption('Rminder', Icons.alarm,'0xffbf841f',context,3,taskController,InProject , InList, InCategory),
                        buildOption('Repeat', Icons.repeat_rounded, '0xff8c8d8f', context, 4,taskController,InProject , InList, InCategory),
                        InCategory? buildOption('Categories', Icons.category,'0xff737272',context,5,taskController,InProject , InList, InCategory):
                        InProject? buildOption('Project', Icons.people_rounded,'0xff737272',context,5,taskController,InProject , InList, InCategory):Container()
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 20,top: 10),
                  child:   Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white, // Set background color here
                        ),
                        onPressed: () {
                          // Perform action when 'Cancel' button is pressed
                          Navigator.of(context!).pop();
                        },
                        child:const Text('CANCEL'),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white, // Set background color here
                        ),
                        onPressed: () async {
                          var title=taskTitleController.text;
                          var desc=taskDescController.text;
                          var start=DateTime( taskController.selectedDate.value.year, taskController.selectedDate.value.month, taskController.selectedDate.value.day,taskController.selectedStartTime.value.hour,taskController.selectedStartTime.value.minute );
                          var last=DateTime( taskController.selectedDate.value.year, taskController.selectedDate.value.month, taskController.selectedDate.value.day,taskController.selectedLastTime.value.hour,taskController.selectedLastTime.value.minute );
                          var isTimed=taskController.isTimed.value;
                          var isRepeted=taskController.isRepetead.value;
                          var RepetationType=taskController.selectedRepeatItem.value;
                          var Repetations=taskController.ListRepetation.value;
                          var priority=taskController.priority.value;
                          var reminder=taskController.isReminder.value;
                          var reminderInterval=taskController.reminderDuration.value;
                          var categoryId=taskController.categoryId.value;
                          var ListId=listController.list.value.id;
                          Task task=Task(title: title, desc: desc,start: start,end: last ,isTimed: isTimed, isRepeated: isRepeted, repetationType: RepetationType,repetations: Repetations, reminder: reminder, reminderInterval: reminderInterval,preority: priority, isInproject: InProject, isInCategory: InCategory,categorieId: categoryId,isInList: InList,ListId: ListId) ;
                          if(InCategory){
                            await taskController.category.value.addTask(task);
                            taskController.addNewTask(task);
                            await taskController.getCategory(categoryId);
                            Navigator.of(context).pop();
                          }else if(InList){
                             listController.list.value.addTask(task);
                             await listController.getListById(ListId);
                             Navigator.of(context).pop();
                          }else if(InProject){

                          }
                          //skController.getCategory(categoryId);
                         },
                         child:const Text(
                          'DONE',
                          style: TextStyle(
                              color: Colors.blue
                           ),
                         ),
                       ),
                     ],
                   ),
                 )
               ],
             ),
          )
       ),
     ),
   );
 }
Widget buildOption(String title, IconData iconData,String colors,BuildContext context,int index,TaskController taskController,bool InProject ,bool InList,bool InCategory){
  ListController listController=Get.put(ListController());
  final Color color=Color(int.parse(colors));
  //var ListCategory=await Category.getAllCategories();
  return GestureDetector(
    onTap: () {
      // Handle option selection
       switch(index){
         case 1:
           ShowDateMenu(context, null, false,true, taskController);
           break;
         case 2:
            ShowPriority(context, null, false, true, taskController);
           break;
         case 3:
            ShowReminderOption(context, null, taskController, false, true);
           break;
         case 4:
            ShowRepeatMenu(context, null, false, true, taskController);
           break;
         case 5:
           if(InCategory){
             selectCategoryMenu(context, taskController);
           }else if(InCategory){
           }

           break;
       }

    },
    child: Container(
      width: 118,
      margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color:const Color(0xffb5b8b4),
          width: 1.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(iconData,color: color),
            const SizedBox(height: 8.0,width: 5,),
            Text(
              title,
              style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold
              ),

            ),
          ],
        ),
      ),
    ),
  );
}
