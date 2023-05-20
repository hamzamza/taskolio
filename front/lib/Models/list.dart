import 'package:front/Models/repetation.dart';
import 'package:front/Models/sub_task.dart';
import 'package:front/Models/task.dart';
import 'package:flutter/material.dart';
import 'id.dart';
import 'package:hive/hive.dart';

part 'list.g.dart';

//  ites preferable to make list root and extends from it all other similars like projects and
@HiveType(typeId: 2)
class TaskList {
  // update in the disk
  Future<void> save() async {
    final box = await getBox();
    await box.put(id, this);
  }

  @HiveField(0)
  late String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String? desc;

  @HiveField(3)
  Color them;

  @HiveField(4)
  String ? icon ;

  @HiveField(5)
  List<Task> tasks = [];

// operation inside the list of tasks

  TaskList({required this.title, this.desc, required this.them,required this.icon}) {
    id = getId();
    //save();
  }
  void editTask(
      {
      required String taskId,
      String? title,
      String? desc,
      bool? isTimed,
      DateTime? start,
      DateTime? end,
      DateTime? dueDate,
      bool? isRepeated,
      Repetation? repetationType,
      List<String>? repetations,
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
      List<Task>? subtasks
       }
       ) {
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
        newtask.repetationType = repetationType as String?;
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

  void update({
    String? title,
    String? desc,
    int? them,
    int? icon,
    List<Task>? tasks,
  }) {
    if (title != null) {
      this.title = title;
    }
    if (desc != null) {
      this.desc = desc;
    }
    if (them != null) {
      this.them = them as Color;
    }
    if (icon != null) {
      this.icon = icon as String?;
    }
    if (tasks != null) {
      this.tasks = tasks;
    }
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

  Future<void> removeTask(Task task) async{
    final index = tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      tasks.removeAt(index);
      save();
    }
  }

  // Remove a task at a specific index

  // Move a task from one index to another
  void moveTask(int newIndex, String idtask) {
    final oldIndex = tasks.indexWhere((t) => t.id == idtask);
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final task = tasks.removeAt(oldIndex);
    tasks.insert(newIndex, task);
    save();
  }

  static Future<void> addTaskList(TaskList taskList) async {
    final box = await getBox();
    await box.put(taskList.id, taskList);
  }

  static Future<void> deleteTaskList(String taskListId) async {
    final box = await getBox();
    await box.delete(taskListId);
  }

  static Future<TaskList?> getTaskListById(String taskListId) async {
    final box = await getBox();
    return box.get(taskListId);
  }

  static Future<List<TaskList>> getAllTaskLists() async {
    final box = await getBox();
    final taskLists = box.values.toList();
    return taskLists;
  }

  static Future<void> addMeny(List<TaskList> newlist) async {
    final box = await getBox();
    box.addAll(newlist);
  }

  static Future<Box<TaskList>> getBox() async {
    return Hive.openBox<TaskList>("lists");
  }
}
