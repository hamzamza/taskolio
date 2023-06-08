

import 'package:front/Models/category.dart';
import 'package:front/Models/list.dart';
import 'package:front/Models/project.dart';

import '../Models/task.dart';

Future<List<Task>> TodaysTask()async{
    List<Task> TodaysTasks=<Task>[];
    List<Category> allCategories=await Category.getAllCategories();
    print("the cateogory length ${allCategories.length}");
    DateTime today=DateTime.now();
    DateTime Today = DateTime(today.year, today.month, today.day);
    for(Category c in allCategories){
         var tasks =c.tasks.where((element) => DateTime(element.start!.year , element.start!.month ,element.start!.day)!.compareTo(Today)==0).toList();
         TodaysTasks.addAll(tasks);
    }
   /*List<Project> allProject=await Project.getAllProject();
    for(Project c in allProject){
      var tasks =c.tasks.where((element) => element.start?.compareTo(DateTime.now())==0).toList();
      TodaysTasks.addAll(tasks);
    }*/

    List<TaskList> allLists=await TaskList.getAllTaskLists();

    for(TaskList c in allLists){
      var tasks =c.tasks.where((element) =>  DateTime(element.start!.year , element.start!.month ,element.start!.day)!.compareTo(Today)==0).toList();
      TodaysTasks.addAll(tasks);
    }
    return TodaysTasks;
}


