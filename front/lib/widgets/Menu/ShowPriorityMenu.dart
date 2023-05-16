import 'package:flutter/material.dart';
import 'package:front/Models/category.dart';
import 'package:front/controllers/TaskController.dart';

import '../../Models/task.dart';

  ShowPriority(BuildContext context,Task? task,bool edit ,bool add,TaskController taskController )async {
      Category category=taskController.category.value;
      var PriorityOptions=[
        {
          'label':'Priority 1',
          'color':Colors.red
        },
        {
          'label':'Priority 2',
          'color':Colors.yellow
        },
       {
         'label':'Priority 3',
         'color':Colors.blue
       },
       {
          'label':'Priority 4',
          'color':Color(0xf0646664)
       },

  ];
  await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(130, 190.0, 50, 50),
      items: PriorityOptions.map((e) => PopupMenuItem(
          child: TextButton.icon(
            onPressed: () {
              var index=PriorityOptions.indexOf(e);
              switch(index){
                case 0:
                  if(edit){
                     if(task!.isInCategory){
                        category.editTask(taskId: task.id,preority:1 );
                     }
                  }else{
                       taskController.priority.value=1;
                  }
                  break;
                case 1:
                  if(edit){
                    if(task!.isInCategory){
                      category.editTask(taskId: task.id,preority:2 );
                    }
                  }else{
                    taskController.priority.value=2;
                  }
                  break;
                case 2:
                  if(edit){
                    if(task!.isInCategory){
                      category.editTask(taskId: task.id,preority:3 );
                    }
                  }else{
                    taskController.priority.value=3;
                  }
                  break;
                case 3:
                  if(edit){
                    if(task!.isInCategory){
                      category.editTask(taskId: task.id,preority:4 );
                    }
                  }else{
                    taskController.priority.value=4;
                  }
                  break;
              }
            },
            icon: Icon(Icons.flag, color: e['color'] as Color,),
            label: Text(e['label'].toString()),
          )
      )
      ).toList()
  );
}