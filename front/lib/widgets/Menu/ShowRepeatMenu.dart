import 'package:flutter/material.dart';
import 'package:front/Models/category.dart';
import 'package:front/controllers/TaskController.dart';
import 'package:get/get.dart';
import '../../Models/repetation.dart';
import '../../Models/task.dart';


ShowRepeatMenu(BuildContext context,Task? task,bool edit, bool add,TaskController taskController)async{
  Category category=taskController.category.value;
  final List<Map<String, dynamic>> RepeatOptions = [
    {
      'icon': Icons.not_interested,
      'name': 'Never',
    },
    {
      'icon': Icons.repeat,
      'name': 'Daily',
    },
    {
      'icon': Icons.repeat,
      'name': 'Weekly',
    },
    {
      'icon': Icons.repeat,
      'name': 'Monthly',
    },
    {
      'icon': Icons.repeat,
      'name': 'Yearly',
    },
    {
      'icon': Icons.menu_outlined,
      'name': 'Custom',
    },
  ];
  showMenu(
      context: context,
      position: RelativeRect.fromLTRB(170, 150.0, 50, 50),
      items: RepeatOptions.map((option) =>
          PopupMenuItem(
              child: TextButton.icon(
                onPressed: () {
                  var index=RepeatOptions.indexOf(option);

                  switch(index){
                    case 0:
                      if(edit){
                         if(task!.isInCategory){
                           category.editTask(taskId: task.id, isRepeated: false);
                         }

                      }
                      else{
                         taskController.isRepetead.value=false;
                      }

                      break;
                    case 1:
                      if(edit){
                         if(task!.isInCategory){
                           category.editTask(taskId: task.id,isRepeated: true ,repetationType: Repetation.daily);
                         }
                      }else{
                        taskController.selectedRepeatItem.value=Repetation.daily;
                        taskController.isRepetead.value=true;
                      }

                      break;
                    case 2:
                      if(edit){
                        if(task!.isInCategory){
                          category.editTask(taskId: task.id, isRepeated: true ,repetationType: Repetation.weekly);
                        }
                      }else{
                        taskController.selectedRepeatItem.value=Repetation.weekly;
                        taskController.isRepetead.value=true;
                      }
                      break;
                    case 3:
                      if(edit){
                        if(task!.isInCategory){
                          category.editTask(taskId: task.id, isRepeated: true ,repetationType: Repetation.monthly);
                        }
                      }else{
                        taskController.selectedRepeatItem.value=Repetation.monthly;
                        taskController.isRepetead.value=true;
                      }

                      break;
                    case 4:
                      if(edit){
                        if(task!.isInCategory){
                          category.editTask(taskId: task.id, isRepeated: true ,repetationType: Repetation.yearly);
                        }
                      }else{
                        taskController.selectedRepeatItem.value=Repetation.yearly;
                        taskController.isRepetead.value=true;
                      }
                      break;
                    case 5:
                      showDialogWithInputs(context,taskController);
                      if(edit){
                        if(task!.isInCategory){
                          category.editTask(taskId: task.id, isRepeated: true ,repetationType: Repetation.weekly,repetations: SelectedDays(taskController.WeekDays.value));
                        }
                      }else{
                           taskController.ListRepetation.value=SelectedDays(taskController.WeekDays.value);
                           taskController.isRepetead.value=true;
                      }

                      break;
                  }
                },
                icon: Icon(option['icon'] as IconData,color: Colors.grey,),
                label: Text(
                  option['name'].toString(),
                  style:const TextStyle(
                      color: Colors.black,
                      fontSize: 15
                  ),
                ),
              )),
      ).toList()
  );
}

void showDialogWithInputs(BuildContext context ,TaskController taskController) {

  Get.dialog(
    ClipRRect(
      child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width*95,
            height: 235,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20,left:20),
                  child:const Text(
                    'Repeat every ...',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0
                    ),
                  ),
                ),
                Container(
                    width: 250,
                    margin: EdgeInsets.only(left: 40,top: 30),
                    child:Obx(()=>Wrap(
                      spacing: 15,
                      runSpacing: 10,
                      children: [
                        ...taskController.WeekDays.map((e) =>
                            InkWell(
                              onTap: () {
                                taskController.UpdateSelectedDay(e);
                              },
                              child:  Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                    color:   e['isSelected'] as bool ? Colors.blue : Colors.white,
                                    border:  e['isSelected'] as bool ? Border.all(width: 0,color: Colors.blue): Border.all(width: 1,color: Colors.grey),
                                    shape:BoxShape.circle
                                ),
                                child: Center(
                                  child: Text(
                                    e['day'].toString() ,
                                    style: TextStyle(
                                        color: e['isSelected'] as bool ? Colors.white: Colors.grey,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500
                                    ),
                                  ),
                                ),
                              ),

                            ),

                        ).toList()
                      ],
                    ))
                ),
                Container(
                  margin: EdgeInsets.only(right: 20,top: 20),
                  child:   Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white, // Set background color here
                        ),
                        onPressed: () {
                          // Perform action when 'Cancel' button is pressed
                          Navigator.of(context).pop();
                        },
                        child:const Text('CANCEL'),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white, // Set background color here
                        ),
                        onPressed: () {
                          // Perform action when 'Ok' button is pressed
                          // ...
                          var repeatedList=taskController.WeekDays.where((day) => day['isSelected'] as bool).toList();
                          Navigator.of(context).pop();
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

List<String > SelectedDays(List<Map<String,dynamic>> days){
  var selectedDays=<String>[];
   for(Map<String,dynamic> c in days){
       if(c['isSelected']){
          selectedDays.add(c['day']);
       }
   }
  return selectedDays;
}