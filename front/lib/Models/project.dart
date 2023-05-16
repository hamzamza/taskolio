import 'package:front/Models/repetation.dart';
import 'package:front/Models/sub_task.dart';
import 'package:front/Models/task.dart';
import 'package:front/Models/user.dart';

import 'id.dart';

import 'package:hive/hive.dart';

part 'project.g.dart';

@HiveType(typeId: 4)
class Project {
  @HiveField(0)
  late String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String? desc;

  @HiveField(3)
  int them;

  @HiveField(4)
  List<User> members = [];

  @HiveField(5)
  bool archived = false;

  @HiveField(6)
  List<Task> tasks = [];

  @HiveField(7)
  List<Section> sections = [
    Section(index: '0', title: "Todo"),
    Section(index: '1', title: "Doing "),
    Section(index: '2', title: "Done")
  ];
  @HiveField(8)
  Role? userrole = Role.owner;

  /// constructor auto instance the hive
  Project({required this.title, this.desc, required this.them, this.userrole}) {
    id = getId();
    save();
  }

  static Future<Box<Project>> getBox() => Hive.openBox<Project>('projects');
  // receive a prject comming from an owner
  static Future<void> getAffectedProject(
      Project affectedproject, Role myrole) async {
    // in this case it's important to be online
    Project addedproject = affectedproject;
    addedproject.userrole = myrole;
    final box = Hive.box<Project>('projects');
    box.put(addedproject.id, addedproject);
  }

  void addSection(Section section) {
    sections.add(section);
    save();
  }

  void editSection(String? title, String? desc, String index) {
    int i = sections.indexWhere((element) => element.index == index);
    if (title != null) sections[i].title = title;
    if (desc != null) sections[i].desc = desc;
    save();
  }

  void deleteSection(String index) {
    sections.removeWhere((element) => element.index == index);
    save();
  }

  void addtaskToSection(Task task, String index) {
    final i = sections.indexWhere((element) => element.index == index);
    sections[i].tasks.add(task);
    save();
  }

  void addTask(Task task) {
    tasks.add(task);
    save();
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

  static Future<void> addMeny(List<Project> newlist) async {
    final box = await getBox();
    box.addAll(newlist);
  }

  // Add a user to the project
  void addUser(User user) {
    if (userrole == Role.owner) {
      members.add(user);
      save();
    }
  }

  // Delete a user from the project by their ID
  void deleteUser(String userId) {
    if (userrole == Role.owner) {
      members.removeWhere((user) => user.id == userId);
      save();
    }
  }

  // Save the project to Hive
  void save() async {
    final box = await getBox();
    box.put(id, this);
  }
}

class Section {
  Section({required this.title, this.desc, this.index}) {
    index ??= getId();
  }
  String? index;
  String title;
  String? desc;
  List<Task> tasks = [];
}

enum Role { owner, admin, user }
