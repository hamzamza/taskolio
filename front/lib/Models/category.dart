import 'dart:ui';

import 'package:front/Models/id.dart';
import 'package:front/Models/repetation.dart';
import 'package:front/Models/sub_task.dart';
import 'package:hive/hive.dart';
import 'task.dart';

part 'category.g.dart';

@HiveType(typeId: 3)
class Category {
// get instance
  //static Box<Category> getBox() => Hive.box<Category>('categories');
  static Box<Category>? box;
  static Box<Category>? getBox() {
    if (box == null) {
      box = Hive.box<Category>('categories');
    }
    return box;
  }


  @HiveField(0)
  late String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String? icon ;

  @HiveField(3)
  String? desc="";

  @HiveField(4)
  Color them;

  @HiveField(5)
  List<Task> tasks = [];

  Category({
    required this.title,
    this.desc,
    required this.them,
    required this.icon,
  }) {
    id = getId();
    save();
  }

  void addTask(Task task) {
    tasks.add(task);
    save();
  }

  // Insert a task at a specific index
  void insertTask(int index, Task task) {
    tasks.insert(index, task);
    save();
  }

  // Remove a task at a specific index
  void removeTask(Task task) {
    final index = tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      tasks.removeAt(index);
      save();
    }
  }

  void editTask(
      {required String taskId,
      String? title,
      String? desc,
      bool? isTimed,
      DateTime? start,
      DateTime? end,
      DateTime? dueDate,
      bool? isRepeated,
      Repetation? repetationType,
      List<DateTime>? repetations,
      bool? reminder,
      Duration? reminderInterval,
      bool? isDone,
      int? progress,
      int? preority,
      bool? favorite,
      bool? isInproject,
      String? projectId,
      bool? isInCategory,
      String? categorieId,
      String? sectionIndex,
      String? assignedtoId,
      List<SubTask>? subtasks}) {
    //
    //
    var index = tasks.indexWhere((element) => element.id == taskId);
    var newtask = tasks[index];

    if (newtask != null) {
      if (title != null) {
        newtask.title = title;
      }

      if (desc != null) {
        newtask.desc = desc;
      }

      if (isTimed != null) {
        newtask.isTimed = isTimed;
      }

      if (start != null) {
        newtask.start = start;
      }

      if (end != null) {
        newtask.end = end;
      }

      if (dueDate != null) {
        newtask.dueDate = dueDate;
      }

      if (isRepeated != null) {
        newtask.isRepeated = isRepeated;
      }

      if (repetationType != null) {
        newtask.repetationType = repetationType;
      }

      if (repetations != null) {
        newtask.repetations = repetations;
      }

      if (reminder != null) {
        newtask.reminder = reminder;
      }

      if (reminderInterval != null) {
        newtask.reminderInterval = reminderInterval;
      }

      if (isDone != null) {
        newtask.isDone = isDone;
      }

      if (progress != null) {
        newtask.progress = progress;
      }

      if (preority != null) {
        newtask.preority = preority;
      }

      if (favorite != null) {
        newtask.favorite = favorite;
      }

      if (isInproject != null) {
        newtask.isInproject = isInproject;
      }

      if (projectId != null) {
        newtask.projectId = projectId;
      }

      if (isInCategory != null) {
        newtask.isInCategory = isInCategory;
      }

      if (categorieId != null) {
        newtask.categorieId = categorieId;
      }

      if (sectionIndex != null) {
        newtask.sectionIndex = sectionIndex;
      }

      if (assignedtoId != null) {
        newtask.assignedtoId = assignedtoId;
      }

      if (subtasks != null) {
        newtask.subtasks = subtasks;
      }
      tasks[index] = newtask;
      save();
    }
  }

  static Future<void> addMeny(List<Category> newlist) async {
    final box = getBox();
    box!.addAll(newlist);
  }

// add new categorey static function to use it every where inside the app
  static Future<bool> addCategory(Category category) async {
    print("hello to add category");
    final box = getBox();
    await box!.put(category.id, category);
    var newCategory=await getCategoryById(category.id);
    if(newCategory!.id==category.id){
        return true;
    }else{
      return false;
    }
  }

  void moveTask(int newIndex, String idtask) {
    final oldIndex = tasks.indexWhere((t) => t.id == idtask);
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final task = tasks.removeAt(oldIndex);
    tasks.insert(newIndex, task);
    save();
  }

  static Future<void> deleteCategory(String categoryId) async {
    final box = getBox();
    await box!.delete(categoryId);
  }

  static Future<Category?> getCategoryById(String categoryId) async {
    final box = getBox();
    return box!.get(categoryId);
  }

  static Future<List<Category>> getAllCategories() async {
    print("hello in getAllCategories");
    final box = getBox();
    final categories = box!.values.toList();
    print("the length of categories is ${categories.length}");
    for(Category c in categories){
       print("title is ${c.title}");
    }
    return categories;
  }

  save() async {
    final box = getBox();
    await box!.put(id, this);
  }
}
