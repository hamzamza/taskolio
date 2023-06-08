import 'package:flutter/material.dart';
import 'package:front/controllers/TaskController.dart';
import 'package:front/controllers/categorie_controller.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

import '../Models/task.dart';
import '../controllers/Listcontroller.dart';
import 'Menu/ShowDateMenu.dart';
import 'Menu/ShowPriorityMenu.dart';
import 'Menu/ShowReminderMenu.dart';
import 'Menu/ShowRepeatMenu.dart';
ElevatedButton ListCadrd(BuildContext context,Task? task,TaskController taskController,int index) {
  ListController listController=Get.put(ListController());
  if(task!.isInList){
      listController.checked.value=task!.isDone;
  }else if(task!.isInCategory){
      taskController.isChecked.value=task!.isDone;
  }
   return ElevatedButton(
   onPressed: () {
      buildShowModalBottomSheet(context,task!,taskController);
    },
  style: elevatedbuttonStyle(),
  child: Expanded(
    child: Container(

      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        children: [
          InkWell(
              onTap: () {
                if(task!.isInCategory){
                  /*taskController.ChangeChecked();
                  taskController.category.value.editTask(taskId: task!.id,isDone:taskController.isChecked.value);
                  taskController.index.value=index;*/
                  taskController.editDoneTask(task.id, !task.isDone);

                }else if(task.isInList){
                    /*listController.changeChecked();
                    listController.list.value.editTask(taskId: task!.id,isDone:listController.checked.value);*/
                     listController.editDoneTask(task.id, !task.isDone);
                }
                //taskController.CheckIndex.value=CheckIndex;
              },
              child:  task!.isInCategory && task.isDone   || task!.isInList &&  task.isDone ?
                const Icon(
                  Icons.check_circle,
                  size: 30.0,
                  color: Colors.grey,
                )
                    : const Icon(
                      Icons.radio_button_unchecked,
                      size: 30.0,
                      color: Colors.grey,
                ),

            /*task!.isDone
                  ? const Icon(
                Icons.check_circle,
                size: 30.0,
                color: Colors.grey,
              )
                  : const Icon(
                Icons.radio_button_unchecked,
                size: 30.0,
                color: Colors.grey,
                ),*/

          ),
          Container(
            padding: EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 180,
                  margin: EdgeInsets.only(top: 12.0,left: 5),
                  child: Text(
                    task!.title,
                    style: const TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'Heebo-Bold'),
                  ),
                ),
                Row(
                  children: [
                    task.start!=null? Icon(
                      Icons.date_range,
                      size: 20,
                      color: Colors.grey,
                    ):Container(),
                    Container(
                      child: Text(
                        '${task.start!=null ? DateFormat('MM/dd/yyyy:hh:mm').format(task.start!):''}',
                        style:const TextStyle(
                          fontSize: 17,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 80.0,top: 10),
            child:InkWell(
                onTap: () {
                  if(task.isInList){
                    listController.list.value.editTask(taskId: task!.id,favorite:listController.favorite.value);
                    listController.favorite.value=!listController.favorite.value;
                    taskController.favoritIndex.value=index;
                  }else if(task.isInCategory){
                    taskController.changeFavorite();
                    taskController.category.value.editTask(taskId: task.id,favorite:taskController.isFavorite.value);
                    taskController.favoritIndex.value=index;
                  }else if( task.isInproject){
                    taskController.changeFavorite();
                  }
                },
                child:
                task!.isInCategory && taskController.isFavorite.value && taskController.favoritIndex.value==index  || task!.isInList && listController.favorite.value && taskController.favoritIndex.value==index || task.isInproject && taskController.isChecked.value?
                const Icon(
                  Icons.star,
                  size: 30.0,
                  color: Colors.grey,
                )
                    : const Icon(
                  Icons.star_border_outlined,
                  size: 30.0,
                  color: Colors.grey,
                 )


              ), //child: popupMenu(task),
          ),
        ],
      ),
    ),
  ),
);
}
ButtonStyle elevatedbuttonStyle() => ElevatedButton.styleFrom(
  foregroundColor: Colors.black87,
  backgroundColor: Colors.white,
  alignment: Alignment.centerLeft,
  elevation: 0,
  padding: EdgeInsets.zero,
  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
);

Future<dynamic> buildShowModalBottomSheet(BuildContext context,Task task,TaskController taskController) {
  ListController listController=Get.put(ListController());
  var options=[
    { 'icon':Icons.person,'label':'Assignee' },
    { 'icon': Icons.repeat_rounded,'label':'Repeat' },
    { 'icon':Icons.alarm,'label':'Reminders' },
    { 'icon':Icons.menu_outlined,'label':'Description' },
    { 'icon':Icons.playlist_play,'label':'Move to...' },
  ];
  taskController.setDate(task.start!);
  taskController.taskContent.value=task.title;
  taskController.priority.value=task.preority;
  return showModalBottomSheet(
    isScrollControlled: false,
    context: context,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(10.0),
      ),
    ),
    builder: (builder) {
      return  Container(
        padding:const EdgeInsets.only(left:15,right: 15 ),
        child: Column(
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 8),
                width: 35,
                height: 6,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color:const Color(0xff5c5c5c)
                ),
              ),
            ),
            Container(
              margin:const EdgeInsets.symmetric(vertical: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(() =>
                     task.isInCategory ?  Text( taskController.category.value.icon! ):
                     task.isInproject ?  Text( taskController.category.value.icon! ):
                     task.isInList ?     Text(  listController.list.value.icon! ):Container()
                  ),
                  SizedBox(width: 25),
                  Expanded(
                      flex: 3,
                      child:  Text(
                         task.isInCategory? taskController.category.value.title!:
                         task.isInList ?  listController.list.value.title!:''
                        ,
                         style: TextStyle(
                            color: Color(0xff595757),
                            fontWeight: FontWeight.w500,
                            fontSize: 17

                         ),
                       ),

                  ),
                  Container(
                    child: InkWell(
                      onTap: (){
                        showMenu(
                            context: context,
                            position: RelativeRect.fromLTRB(100, 420, 20, 0),
                            items: [
                              PopupMenuItem(
                                  onTap: () async{
                                    if(task.isInCategory){
                                      taskController.category.value.removeTask(task);
                                      await taskController.getCategory(task.categorieId!);
                                      taskController.getNewLTasks();
                                      Navigator.pop(context);
                                    }else if(task.isInList){
                                      print("llllist  id is ${task.ListId} ");
                                      listController.list.value.removeTask(task);
                                      await listController.getListById(task.ListId!);
                                      Navigator.pop(context);
                                    }

                                  },
                                  child:Container(
                                    child: Row(
                                      children: [
                                        Icon(Icons.delete,color: Colors.red,),
                                        SizedBox(width: 10,),
                                        Text("delete Task")
                                      ],
                                    ),
                                  ) )
                            ]);
                      },
                      child: Icon(
                        Icons.more_vert,
                        color: Color(0xff383737),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  InkWell(
                      onTap: () {
                        if(task.isInCategory){
                          taskController.ChangeChecked();
                           taskController.category.value.editTask(taskId: task.id,isDone:taskController.isChecked.value);
                           //taskController.favoritIndex.value=index;
                        }else if(task.isInList){

                          listController.changeChecked();
                          listController.list.value.editTask(taskId: task.id,isDone:listController.checked.value );

                        }


                      },
                      child: Obx(()=> task.isInCategory && taskController.isChecked.value || task.isInList && listController.checked.value
                          ? const Icon(
                        Icons.check_circle,
                        size: 30.0,
                        color: Colors.grey,
                      )
                          : const Icon(
                        Icons.radio_button_unchecked,
                        size: 30.0,
                        color: Colors.grey,
                      ),
                      )

                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: EditableText(
                      controller: TextEditingController(text:taskController.taskContent.value ),
                      focusNode: FocusNode(),
                      style:const TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.bold

                      ),
                      cursorColor: Colors.blue,
                      backgroundCursorColor: Colors.grey[300]!,
                      onChanged: (value) {
                         if(task.isInCategory){
                           taskController.setTaskContent(value);
                           taskController.category.value.editTask(taskId: task.id,title: value);
                           taskController.getCategory(task.categorieId!);
                         }
                      },
                    ),

                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: (){
                if(task.isInCategory){
                  ShowDateMenu(context, task, true, false, taskController);
                }

              },
              child: Container(
                margin: EdgeInsets.only(top: 15),
                child: Row(
                  children: [
                    Icon(
                      Icons.date_range,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Obx(() => Text(
                      taskController.dateFormat.value,
                    )
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.transform,
                      color: Colors.grey,
                      size: 15,
                    ),

                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              child: Row(
                children: [
                  Icon(
                    Icons.flag,
                    color: Color(0xff3d4c82),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  InkWell(
                    onTap: (){
                      if(task.isInCategory){
                        ShowPriority(context, task, true, false, taskController);
                      }
                    },
                    child: Text(
                        'Priority ${task.preority}'
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 50,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount:options.length,
                  itemBuilder:(context,index){
                    return buildOption(options[index]['label'].toString(), options[index]['icon'] as IconData,index,context,task,taskController);
                  }),
            ),
            Container(
              margin:const EdgeInsets.only(top: 15),
              height: 5,
              width: MediaQuery.of(context).size.width,
              color: Color(0xffcccfcf),
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              child:  ExpansionPanelList.radio(
                children: [
                  ExpansionPanelRadio(
                    value: task.id as Object,
                    headerBuilder: (context, isOpen) =>SubTaskHeader(task),
                    body: SubTaskBody(task, taskController),
                  )
                ],
              )
            )

          ],
        ),
      );
    },
  );
}
Widget SubTaskHeader(Task? task){
   return Container(
     child: Row(
       children: [
          Text("Sub-tasks"),
          SizedBox(width: 15),
          Text(
             "/${task?.subtasks!=null ? task?.subtasks?.length:0 }"
          ),
       ],
     ),
   );
}
Widget SubTaskBody(Task task,TaskController taskController){
  return Container(
      child: Column(

        children: [
          Container(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: task?.subtasks!=null? task?.subtasks?.length :0,
                  itemBuilder:(context,index)=>ListCadrd(context, task!.subtasks![index], taskController,index),
              ),
          ),
          InkWell(
            onTap: (){

            },
            child: Container(
              child: Row(
                 children: [
                   Icon(
                     Icons.add,
                     color: Colors.red,
                   ),
                   SizedBox(
                     width: 15,
                   ),
                   Text(
                     "Add sub-task",
                      style: TextStyle(
                         color: Colors.red
                      ),
                   )
                 ],
              ),
            ),
          )
        ],
      ),
    );

}
Widget buildOption(String title,IconData iconData,int index,BuildContext context,Task task,TaskController taskController) {

  return GestureDetector(
    onTap: () {
      switch(index){
        case 1:
          if(task.isInCategory) {
            ShowRepeatMenu(context, task, true,false, taskController);
          }

          break;
        case 2:
          if(task.isInCategory){
            ShowReminderOption(context, task, taskController, true, false);
          }
          break;
      }
    },
    child: Container(
      width: 125,
      margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
      decoration: BoxDecoration(
        color:const Color(0x60d9dbdb),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(iconData,size: 20.0,),
            const SizedBox(height: 5.0,width: 5,),
            Text(
              title,
              style:const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
              ),

            ),
          ],
        ),
      ),
    ),
  );
}
