import 'package:flutter/material.dart';
import 'package:front/Models/category.dart';
import 'package:front/controllers/TaskController.dart';
import 'package:front/widgets/Menu//PickDate.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import '../../Models/task.dart';

ShowDateMenu(BuildContext context,Task? task,bool edit ,bool add, TaskController taskController)async{

  Category category=taskController.category.value;
  DateTime now = DateTime.now();
  String formattedDay = DateFormat('EEEE').format(now);
  DateTime tomorrow = now.add(Duration(days: 1));
  String formattedTomorrow=DateFormat('EEEE').format(tomorrow);
  var DateOptions=<Map<String,dynamic>>[
    {
      'date':'Today($formattedDay)',
      'icon':Icons.calendar_today_outlined
    },
    {
      'date':'Tomorrow($formattedTomorrow)',
      'icon':Icons.calendar_today_outlined
    },
    {
      'date':'No date',
      'icon':Icons.not_interested
    },
    {
      'date':'Pick a date',
      'icon':Icons.today_outlined
    },
    {
      'date':'add Start Time',
      'icon':Icons.start,
    },
    {
      'date':'add end Time',
      'icon':Icons.hourglass_top,
    }
  ];
  showMenu(
      context: context,
      position:  RelativeRect.fromLTRB(50, 100.0, 200, 100),
      items: DateOptions.map((e) =>
          PopupMenuItem(
              child: TextButton.icon(
                onPressed: () async {
                  var index =DateOptions.indexOf(e);
                  switch(index){
                    case 0:
                      if(edit){
                        category.editTask(taskId: task!.id,start: now,isTimed:true);
                        taskController.setDate(now);
                        taskController.getCategory(category.id);
                      }else {
                           taskController.selectedDate.value=now;
                           taskController.isTimed.value=true;
                      }
                      break;
                    case 1:
                      if(edit){
                         if(task!.isInCategory){
                           category.editTask(taskId: task.id,start: tomorrow,isTimed:true);
                           taskController.setDate(tomorrow);
                           taskController.getCategory(category.id);

                         }else if(task.isInproject){

                         }
                      }
                      else{
                        taskController.selectedDate.value=tomorrow;
                        taskController.isTimed.value=true;
                      }

                      break;
                    case 2:
                      if(edit){
                        category.editTask(taskId: task!.id, isTimed:false);
                      }
                       else{
                        taskController.isTimed.value=false;
                      }
                      break;
                    case 3:
                      if(edit){
                        if(task!.isInCategory){
                          await PickDate(context, taskController);
                          var picked=taskController.selectedDate.value;
                          DateTime newDateTime=DateTime( picked.year, picked.month,picked.day,task.start!.hour,task.start!.minute );
                          category.editTask(taskId: task.id,start: newDateTime,isTimed:true);
                          taskController.getCategory(category.id);
                          taskController.dateFormat.value=DateFormat('MMM d hh:mma').format(newDateTime);
                        }
                        else{

                        }

                      }else{
                       PickDate(context, taskController);
                      }

                      break;
                    case 4:
                      if(edit){
                         if(task!.isInCategory){
                           await PickTime(context, 'start', task, taskController);
                           var picked=taskController.selectedStartTime.value;
                           DateTime newDateTime=DateTime( task.start!.year, task.start!.month, task.start!.day,picked.hour,picked.minute );
                           category.editTask(taskId: task.id,start: newDateTime,isTimed:true);
                           taskController.getCategory(category.id);
                           taskController.dateFormat.value=DateFormat('MMM d hh:mma').format(newDateTime);
                         }

                      }else{
                        PickTime(context, 'start', task!, taskController);
                      }

                      break;
                    case 5:
                      if(edit){
                        if(task!.isInCategory){
                          await PickTime(context, 'last', task, taskController);
                          var picked=taskController.selectedLastTime.value;
                          DateTime newDateTime=DateTime( task.start!.year, task.start!.month, task.start!.day,picked.hour,picked.minute );
                          category.editTask(taskId: task.id,end: newDateTime,isTimed:true);
                        }

                      }else{
                        await PickTime(context, 'last', task!, taskController);
                      }

                      break;
                  }
                },
                icon: Icon(e['icon'] as IconData,color: Colors.grey,),
                label: Text(
                  e['date'].toString(),
                  style:const TextStyle(
                      color: Colors.black,
                      fontSize: 15
                  ),
                ),
              )),
      ).toList()
  );
}