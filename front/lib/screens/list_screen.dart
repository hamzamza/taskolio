
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
import 'package:front/widgets/menu_bottom.dart';
import 'package:get/get.dart';
import 'package:flutter_ui_toolkit/flutter_ui_toolkit.dart';
import 'package:intl/intl.dart';

class ListScreen extends StatelessWidget {
  ListScreen(){
  }
  TaskController taskController=Get.put(TaskController());
  final String CategoryId = Get.arguments;
  late Category category;
  @override
  Widget build(BuildContext context) {
    //print("the title isss:${taskController.category.value.tasks!.length}  id: ${CategoryId}");
    //ScreenController screenConctroller = Get.put(ScreenController());
    taskController.getCategory(CategoryId);
    //int listindex = screenConctroller.selectedScreen;
    return WillPopScope(
        onWillPop: () async {
          return false; // returning false will do nothing
        },
        child: Scaffold(
          body: Obx(() => ListView.builder(
              itemCount: taskController.listTask.length,
              itemBuilder: (BuildContext context, int index) {
                var task=taskController.listTask[index];
                return ListCadrd(context,task);
              }) ),
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
          bottomNavigationBar: Container(height: 70, child:   Menubottom()),
        ));
  }

  Future<dynamic> buildShowModalBottomSheet(BuildContext context,Task task) {
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
                            Obx(() =>  Text( taskController.category.value.icon! )),
                             SizedBox(width: 25),
                             Expanded(
                               flex: 3,
                               child: Obx(() => Text(
                                 taskController.category.value.title!,
                                 style: TextStyle(
                                     color: Color(0xff595757),
                                     fontWeight: FontWeight.w500,
                                     fontSize: 17

                                 ),
                               ),)
                             ),
                               Container(

                                 child: InkWell(
                                   onTap: (){
                                     showMenu(
                                         context: context,
                                         position: RelativeRect.fromLTRB(100, 420, 20, 0),
                                         items: [
                                             PopupMenuItem(
                                               onTap: (){
                                                  taskController.category.value.removeTask(task);
                                                   taskController.getCategory(CategoryId);
                                                   Navigator.pop(context);
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
                                taskController.ChangeChecked();
                                taskController.category.value.editTask(taskId: task.id,isDone:taskController.isChecked.value);
                             },
                               child: Obx(()=> taskController.isChecked.value
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
                                 taskController.setTaskContent(value);
                                 taskController.category.value.editTask(taskId: task.id,title: value);
                                 taskController.getCategory(CategoryId);
                               },
                             ),

                           ),
                         ],
                      ),
                   ),
                   GestureDetector(
                     onTap: (){
                       ShowDateMenu(context, task, true, false, taskController);
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
                                  ShowPriority(context, task, true, false, taskController);
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
                          return buildOption(options[index]['label'].toString(), options[index]['icon'] as IconData,index,context,task);
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
                     child: Row(
                        children:const [
                           Icon(
                             Icons.add,
                             size: 25,
                           ),
                          SizedBox(width: 20),
                          Text(
                            'Add sub-task',
                             style: TextStyle(
                                fontSize: 18,
                               fontWeight: FontWeight.w500

                             ),
                          )
                        ],
                     ),
                   )

                 ],
             ),
        );
      },
    );
  }
  ElevatedButton ListCadrd(BuildContext context,Task task) => ElevatedButton(
    onPressed: () {
      buildShowModalBottomSheet(context,task);
    },
    style: elevatedbuttonStyle(),
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(children: [
        Transform.scale(
          scale: 1.3,
          child: Checkbox(
            fillColor: MaterialStateProperty.resolveWith(getColor),
            shape: const CircleBorder(),
            value: false,
            onChanged: (bool? value) {},
          ),
        ),
        Text(task.title)
      ]),
    ),
  );

  ButtonStyle elevatedbuttonStyle() => ElevatedButton.styleFrom(
    foregroundColor: Colors.black87,
    backgroundColor: Colors.white,
    alignment: Alignment.centerLeft,
    elevation: 0,
    padding: EdgeInsets.zero,
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
  );

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

  Widget buildOption(String title,IconData iconData,int index,BuildContext context,Task task) {

    return GestureDetector(
      onTap: () {
        switch(index){
           case 1:
           ShowRepeatMenu(context, task, true,false, taskController);
           break;
          case 2:
            ShowReminderOption(context, task, taskController, true, false);
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




}


