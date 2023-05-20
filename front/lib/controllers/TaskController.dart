

import 'package:flutter/material.dart';
import 'package:front/Models/category.dart';
import 'package:front/Models/repetation.dart';
import 'package:front/Models/task.dart';
import 'package:front/helpers/TodaysTask.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TaskController extends GetxController{
    var taskContent="".obs;
    var isChecked=false.obs;
    var isFavorite=false.obs;
    var isTimed=false.obs;
    var isReminder=false.obs;
    var isRepetead=false.obs;
    var priority=1.obs;
    var categoryId="".obs;
    var selectedRepeatItem="never".obs;
    var selectedDate = DateTime.now().obs;
    var selectedStartTime=TimeOfDay.now().obs;
    var selectedLastTime=TimeOfDay.now().obs;
    var reminderTime=TimeOfDay.now().obs;
    var reminderDuration =Duration().obs;
    var category=Category(title: "empty", them: Colors.white, icon: "empty").obs;
    var ListTask=[].obs;
    var dateFormat="".obs;
    var ListRepetation=<String>[].obs;
    var allCategories=<Category>[].obs;
    var todaysTask=<Task>[].obs;
    var CheckIndex=0.obs;
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
    getTodayTasks()async{
        todaysTask.value=await TodaysTask();
    }
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
    changeFavorite(){
      isFavorite.value=!isFavorite.value;
    }
   getCategory(String id)async{
       print("hello in get categoryyyyyyyy id is: ${id}");
       Category? ccategory=await Category.getCategoryById(id);
       category.value=ccategory!;
       //listTask.value=category.value.tasks!;
       print("the newwwww ccategoyis ${ccategory.title}");
       print("hyyy tasks length is :${category.value.tasks!.length} title is ${category.value.title}");
   }
   getNewLTasks(  )async{
     //Category? ccategory=await Category.getCategoryById(id);
     ListTask.value=category.value.tasks!;
     print("the new list length is ${ListTask.length}");
   }
   addNewTask(Task task){
      ListTask.value.add(task);
   }
   setDate (DateTime dateTime){
    // selectedDate.value=dateTime;
     dateFormat.value=DateFormat('MMM d hh:mma').format(dateTime);
   }
  getAllCategories()async{
      allCategories.value=await Category.getAllCategories();
  }
}