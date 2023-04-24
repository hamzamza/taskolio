
import 'package:flutter/material.dart';
import 'package:front/Models/category.dart';
import 'package:front/Models/repetation.dart';
import 'package:front/Models/task.dart';
import 'package:front/controllers/TaskController.dart';
import 'package:front/controllers/screens_controller.dart';
import 'package:front/widgets/menu_bottom.dart';
import 'package:get/get.dart';
import 'package:flutter_ui_toolkit/flutter_ui_toolkit.dart';
import 'package:intl/intl.dart';

class ListScreen extends StatelessWidget {
  ListScreen(){
  }
  TaskController taskController=Get.put(TaskController());
  final Map<String, dynamic> Categorydata = Get.arguments;
  late Category category;
  @override
  Widget build(BuildContext context) {
    ScreenController screenConctroller = Get.put(ScreenController());
    taskController.getCategory(Categorydata['categoryId']);
    int listindex = screenConctroller.selectedScreen;
    return WillPopScope(
        onWillPop: () async {
          return false; // returning false will do nothing
        },
        child: Scaffold(
          body: ListView.builder(
              itemCount: 26,
              itemBuilder: (BuildContext context, int index) {
                return ListCadrd(context);
              }),
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
                       buildShowModalBottomSheet(context,task);
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
                            Categorydata['icon'],
                             SizedBox(width: 25),
                             Expanded(
                               flex: 3,
                               child:  Text(
                                   Categorydata['title'],
                                   style: TextStyle(
                                      color: Color(0xff595757),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17

                                   ),
                               ),
                             ),
                               Icon(
                              Icons.more_vert,
                              color: Color(0xff383737),
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
                               },
                             ),
                           ),
                         ],
                      ),
                   ),
                   GestureDetector(
                     onTap: (){
                       ShowUpdatDateMenu(context);
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
                           children:const [
                             Icon(
                                Icons.flag,
                                color: Color(0xff3d4c82),
                             ),
                             SizedBox(
                               width: 15,
                             ),
                             Text(
                                'Priority 3'
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
                          return buildOption(options[index]['label'].toString(), options[index]['icon'] as IconData,index,context);
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
        Text('data')
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
             ShowRepeatMenu(context,task);
           break;
          case 2:
            ShowReminderOption(context,task);
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
     ShowRepeatMenu(BuildContext context,Task task)async{
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
           position: RelativeRect.fromLTRB(130, 300.0, 50, 50),
           items: RepeatOptions.map((option) =>
               PopupMenuItem(
                   child: TextButton.icon(
                     onPressed: () {
                       var index=RepeatOptions.indexOf(option);

                         switch(index){
                           case 0:
                             category.editTask(taskId: task.id, isRepeated: false);
                             break;
                           case 1:
                             category.editTask(taskId: task.id,isRepeated: true ,repetationType: Repetation.daily);
                             break;
                           case 2:
                             category.editTask(taskId: task.id, isRepeated: true ,repetationType: Repetation.weekly);
                             break;
                           case 3:
                             category.editTask(taskId: task.id, isRepeated: true ,repetationType: Repetation.monthly);
                             break;
                           case 4:
                             category.editTask(taskId: task.id, isRepeated: true ,repetationType: Repetation.yearly);
                             break;
                           case 5:
                             showDialogWithInputs(context);

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


  void showDialogWithInputs(BuildContext context) {

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
   ShowUpdatDateMenu(BuildContext context,Task task){
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
          position:  RelativeRect.fromLTRB(70, 300.0, 200, 50),
          items: DateOptions.map((e) =>
              PopupMenuItem(
                  child: TextButton.icon(
                    onPressed: () {
                        var index =DateOptions.indexOf(e);
                        switch(index){
                          case 0:
                             category.editTask(taskId: task.id,start: now,isTimed:true);
                             taskController.setDate(now);
                            break;
                          case 1:
                            category.editTask(taskId: task.id,start: tomorrow,isTimed:true);
                            taskController.setDate(tomorrow);
                            taskController.getCategory(category.id);
                            break;
                          case 2:
                              category.editTask(taskId: task.id, isTimed:false);
                            break;
                          case 3:
                             _selectDate(context);
                         break;
                          case 4:
                             _selectTime(context,'start',task);
                          break;
                          case 5:
                            _selectTime(context,'last',task);
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
  Future<void> _selectDate(BuildContext context,Task task) async {

    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate:  taskController.selectedDate.value,
        firstDate: DateTime(2010),
        lastDate: DateTime(2050));
    if (picked != null && picked != taskController.selectedDate.value) {
         //taskController.selectedDate.value = picked;
         DateTime newDateTime=DateTime( picked.year, picked.month,picked.day,task.start!.hour,task.start!.minute );
         category.editTask(taskId: task.id,start: newDateTime,isTimed:true);
         taskController.getCategory(category.id);
         taskController.dateFormat.value=DateFormat('MMM d hh:mma').format(newDateTime);
    }
  }
  Future<void> _selectTime(BuildContext context,String type,Task task) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: taskController.selectedStartTime.value
    );
    if (picked != null && picked != taskController.selectedStartTime.value) {
         if(type=='start'){
           //taskController.selectedStartTime.value=picked;
           DateTime newDateTime=DateTime( task.start!.year, task.start!.month, task.start!.day,picked.hour,picked.minute );
           category.editTask(taskId: task.id,start: newDateTime,isTimed:true);
           taskController.getCategory(category.id);
           taskController.dateFormat.value=DateFormat('MMM d hh:mma').format(newDateTime);
         }
         else if(type=='reminder'){
           taskController.reminderTime.value=picked;
         }
         else if(type=='end'){
           taskController.selectedLastTime.value=picked;
         }
    }
  }
  ShowReminderOption(BuildContext context,Task task){
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
         position: RelativeRect.fromLTRB(100, 450.0, 200, 50),
         items: RminderOptions.map((e) =>
             PopupMenuItem(
                 child: TextButton.icon(
                   onPressed: () {
                     var index =RminderOptions.indexOf(e);
                     switch(index){
                       case 0:
                         category.editTask(taskId: task.id, reminder: false);
                         break;
                       case 1:
                         category.editTask(taskId: task.id, reminder: true,reminderInterval: Duration(minutes: 5));
                         break;
                       case 2:
                         category.editTask(taskId: task.id, reminder: true,reminderInterval: Duration(minutes: 15));
                         break;
                       case 3:
                         category.editTask(taskId: task.id, reminder: true,reminderInterval: Duration(minutes: 30));
                         break;
                       case 4:
                         category.editTask(taskId: task.id, reminder: true,reminderInterval: Duration(hours: 1));
                         break;
                       case 5:
                         _selectTime(context,'reminder',task);
                         var Minute=taskController.reminderTime.value.minute;
                         var hours=taskController.reminderTime.value.hour;
                         category.editTask(taskId: task.id, reminder: true,reminderInterval: Duration(minutes: Minute ,hours: hours));
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
   ShowDialog(BuildContext context){
      Get.dialog(
         const ClipRRect(
           child: Dialog(

           ),
        )
      );
  }

}


