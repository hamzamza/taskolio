import 'package:flutter/material.dart';
import 'package:front/Models/task.dart';
import 'package:front/controllers/TaskController.dart';
import 'package:get/get.dart';




Future<void> PickDate(BuildContext context,TaskController taskController) async {
  var  _selectedDate=taskController.selectedDate.value;
  final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2050));
  if (picked != null && picked != _selectedDate) {
    taskController.selectedDate.value = picked;
  }
}

Future<void> PickTime(BuildContext context,String type,Task? task,TaskController taskController) async {
  final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: taskController.selectedStartTime.value
  );
  if (picked != null && picked != taskController.selectedStartTime.value) {

    if(type=='start'){
      taskController.selectedStartTime.value=picked;
    }
    else if(type=='reminder'){
      taskController.reminderTime.value=picked;

    }
    else if(type=='last'){
      taskController.selectedLastTime.value=picked;
    }
  }
}
