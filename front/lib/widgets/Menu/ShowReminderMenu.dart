import 'package:flutter/material.dart';
import 'package:front/controllers/TaskController.dart';
import 'package:front/widgets/Menu//PickDate.dart';
import 'package:get/get.dart';

import '../../Models/task.dart';

ShowReminderOption(BuildContext context,Task? task,TaskController taskController,bool edit ,bool add){
  var category=taskController.category.value;
  var RminderOptions=[
    'Never',
    '5 minutes before',
    '15 minutes before',
    '30 minutes before',
    '1 hour before',
    'Pick Time'
  ];
  showMenu(
    context: context,
    position: RelativeRect.fromLTRB(150, 450.0, 200, 50),
    items: RminderOptions.map((e) =>
        PopupMenuItem(
            child: TextButton.icon(
              onPressed: () async {
                var index =RminderOptions.indexOf(e);
                switch(index){
                  case 0:
                    if(edit){
                      if(task!.isInCategory){
                        category.editTask(taskId: task.id, reminder: false);
                      }

                    }else{
                        taskController.isReminder.value=false;
                    }

                    break;
                  case 1:
                    if(edit){
                       if(task!.isInCategory){
                         category.editTask(taskId: task.id, reminder: true,reminderInterval: Duration(minutes: 5));
                       }
                    }else{
                        taskController.isReminder.value=true;
                        taskController.reminderDuration.value=Duration(minutes: 5);
                    }

                    break;
                  case 2:
                    if(edit){
                      if(task!.isInCategory){
                        category.editTask(taskId: task.id, reminder: true,reminderInterval: Duration(minutes: 15));
                      }

                    }else{
                      taskController.isReminder.value=true;
                      taskController.reminderDuration.value=Duration(minutes: 15);
                    }

                    break;
                  case 3:
                    if(edit){
                      if(task!.isInCategory){
                        category.editTask(taskId: task.id, reminder: true,reminderInterval: Duration(minutes: 30));
                      }
                      category.editTask(taskId: task.id, reminder: true,reminderInterval: Duration(minutes: 30));
                    }else{
                      taskController.isReminder.value=true;
                      taskController.reminderDuration.value=Duration(minutes: 30);
                    }

                    break;
                  case 4:
                    if(edit){
                       if(task!.isInCategory){
                         category.editTask(taskId: task.id, reminder: true,reminderInterval: Duration(hours: 1));
                       }

                    }else{
                      taskController.isReminder.value=true;
                      taskController.reminderDuration.value=Duration(hours: 1);
                    }

                    break;
                  case 5:
                    if(edit){
                      if(task!.isInCategory){
                        await PickTime(context, 'last', task, taskController);
                        var Minute=taskController.reminderTime.value.minute;
                        var hours=taskController.reminderTime.value.hour;
                        category.editTask(taskId: task.id, reminder: true,reminderInterval: Duration(minutes: Minute ,hours: hours));
                      }
                    }else{
                      await PickTime(context, 'last', task!, taskController);
                      taskController.isReminder.value=true;
                    }
                    break;
                }
              },
              icon:const Icon(Icons.navigate_before),
              label: Text(
                e,
                style:const TextStyle(
                    color: Colors.black,
                    fontSize: 15
                ),
              ),
            )),
    ).toList(),
  );

}