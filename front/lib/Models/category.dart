import 'package:front/Models/id.dart';
import 'package:front/Models/repetation.dart';
import 'package:front/Models/sub_task.dart';
import 'package:hive/hive.dart';
import 'task.dart';

part 'category.g.dart';

@HiveType(typeId: 3)
class Category {
// get instance
  static Future<Box<Category>> getBox() => Hive.openBox<Category>('categories');

  @HiveField(0)
  late String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  int? icon = 0;

  @HiveField(3)
  String? desc;

  @HiveField(4)
  int them;

  @HiveField(5)
  List<Task> tasks = [];

  Category({
    required this.title,
    this.desc,
    required this.them,
    this.icon,
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

  static Future<void> addMany(List<Category> newlist) async {
    final box = await getBox();
    for (final category in newlist) {
      await box.put(category.id, category);
    }
  }

// add new categorey static function to use it every where inside the app
  static Future<void> addCategory(Category category) async {
    final box = await getBox();
    await box.put(category.id, category);
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

  static Future<void> deleteAllCategories() async {
    final box = await getBox();
    await box.clear();
  }

  static Future<void> deleteCategory(String categoryId) async {
    final box = await getBox();
    await box.delete(categoryId);
  }

  static Future<Category?> getCategoryById(String categoryId) async {
    final box = await getBox();
    return box.get(categoryId);
  }

  static Future<List<Category>> getAllCategories() async {
    final box = await getBox();
    final categories = box.values.toList();
    return categories;
  }

  save() async {
    final box = await getBox();
    await box.put(id, this);
  }
}
