

import 'package:flutter/material.dart';
import 'package:front/Models/category.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TaskController extends GetxController{
    var taskContent="Task Content".obs;
    var isChecked=false.obs;
    var selectedRepeatItem="".obs;
    var selectedDate = DateTime.now().obs;
    var selectedStartTime=TimeOfDay.now().obs;
    var selectedLastTime=TimeOfDay.now().obs;
    var reminderTime=TimeOfDay.now().obs;
    var category=Category(title: "", them: Colors.white, icon: "").obs;
    var dateFormat="".obs;
    var WeekDays=[
      {
        'day':'MON',
        'isSelected':false
      },
      {
        'day':'TUE',
        'isSelected':false
      },
      {
        'day':'WED',
        'isSelected':false
      },
      {
        'day':'THU',
        'isSelected':false
      },
      {
        'day':'FRI',
        'isSelected':false
      },
      {
        'day':'SAT',
        'isSelected':false
      },
      {
        'day':'SUN',
        'isSelected':false
      },
    ].obs;
    UpdateSelectedDay(Map e){
       var index=WeekDays.indexOf(e);
       print("index is $index day ");
       WeekDays.assignAll(
           WeekDays.map((e) => e).toList()
       );
       WeekDays[index]={ 'day':e['day'],'isSelected':!e['isSelected'] };
    }
    setTaskContent(String value){
       taskContent.value=value;
    }
    ChangeChecked(){
       isChecked.value=!isChecked.value;
    }
   getCategory(String id)async{
       category.value!=await Category.getCategoryById(id);
   }
   setDate (DateTime dateTime){
    // selectedDate.value=dateTime;
     dateFormat.value=DateFormat('MMM d hh:mma').format(dateTime);
   }

}