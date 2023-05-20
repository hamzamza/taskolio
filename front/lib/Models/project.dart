import 'package:front/Models/repetation.dart';
import 'package:front/Models/sub_task.dart';
import 'package:front/Models/task.dart';
import 'package:front/Models/user.dart';
import 'package:flutter/material.dart';
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
   Color them;

  @HiveField(4)
  String ? icon ;

  @HiveField(4)
  List<Member> members =<Member>[];

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
  String  userrole = "owner";

  /// constructor auto instance the hive
  Project({this.id="",required this.title, this.desc, required this.them, this.icon,List<Member>? members,this.archived = false,List<Task>? tasks, this.userrole = "owner"}) {
    //id = getId();
    //save();
  }


  static Future< Box<Project>> getBox() => Hive.openBox<Project>('projects');
  // receive a prject comming from an owner
  static Future<void> getAffectedProject(
      Project affectedproject, Role myrole) async {
    // in this case it's important to be online
    Project addedproject = affectedproject;
    addedproject.userrole = myrole as String;
    final box = Hive.box<Project>('projects');
    box.put(addedproject.id, addedproject);
  }

  static Future<List<Project>> getAllProject() async {
    print("hello in getAllProject");
    final box =await getBox();
    final projects = box!.values.toList();
    //print("the length of categories is ${categories.length}");
    /*for(Category c in categories){
      print("title is ${c.title}");
      Category? category=await getCategoryById(c.id);
      // print("the length of categories is ${category!.tasks!.length}");
    }*/
    return projects;
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
      List<Task>? subtasks}) {
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

  static Future<void> addMeny(List<Project> newlist) async {
    final box =await getBox();
    box.addAll(newlist);
  }

  // Add a user to the project
  void addUser(Member user) {
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
  void save() {
    final box = Hive.box<Project>('projects');
    box.put(id, this);
  }
  static Future<void> addProject(Project project) async {
    final box = await getBox();
    await box.put(project.id, project);
  }

  static Future<void> deleteProject(String taskListId) async {
    final box = await getBox();
    await box.delete(taskListId);
  }

    static Project fromJson(Map<String, dynamic> json) {
    final id = json['_id'] as String;
    final title = json['title'] as String;
    final desc = json['desc'] as String?;
    final them = Color(json['them']);
    final icon = json['icon'] as String?;
    final membersJson = json['members'] as List<dynamic>;
    final members = membersJson.map((member) => Member.fromJson(member)).toList();
    final archived = json['archived'] as bool;
    final tasksJson = json['tasks'] as List<dynamic>;
    final tasks = tasksJson.map((task) => Task.fromJson(task)).toList();
    final sectionsJson = json['sections'] as List<dynamic>;
    final sections = sectionsJson.map((section) => Section.fromJson(section)).toList();
    final userrole = json['userrole']!=null ? json['userrole'] :"owner";
     Project project=Project(id: id,
       title: title,
       desc: desc,
       them: them,
       icon: icon,
       members: members ,
       archived: archived,
       tasks: tasks,
       //sections: sections,
       userrole: userrole,);
       project.sections=sections;
    return project;
  }
}


class Section {
  Section({required this.title, this.desc, this.index, List<Task>? tasks}) {
    index ??= getId();
  }
  String? index;
  String title;
  String? desc;
  List<Task> tasks = [];
  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      index: json['_id'] as String?,
      title: json['title'] as String,
      desc: json['desc'] as String?,
      tasks: (json['tasks'] as List<dynamic>).map((task) => Task.fromJson(task['task'] as Map<String, dynamic>)).toList(),
    );
  }
}
class Member {
  String id;
  String role;
  String status;

  Member({
    required this.id,
    required this.role,
    required this.status,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['id'] as String,
      role: json['role'] as String,
      status: json['status'] as String,
    );
  }
}

enum Role { owner, admin, user }
