
import '../Models/list.dart';
import '../Models/task.dart';
import 'package:front/Models/category.dart';

  Future<List<Task>> FavoriteTask()async{
    List<TaskList> allLists=await TaskList.getAllTaskLists();
    var  FavoritTasks=<Task>[];
    for(TaskList c in allLists){
      var tasks =c.tasks.where((element) =>  element.favorite).toList();
      FavoritTasks.addAll(tasks);
    }

    List<Category> allCategories=await Category.getAllCategories();
    for( Category c in allCategories){
      var tasks =c.tasks.where((element) =>  element.favorite).toList();
      FavoritTasks.addAll(tasks);
    }

    return FavoritTasks;
}