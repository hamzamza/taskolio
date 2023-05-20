import 'repetation.dart';
import 'sub_task.dart';
import 'id.dart';
import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 1)
class Task {
  // key generated automaticly
  @HiveField(0)
  late String id;
  // text data
  @HiveField(1)
  String title;
  //
  @HiveField(2)
  String? desc;
  // dates section
  @HiveField(3)
  bool isTimed;
  @HiveField(4)
  DateTime? start;
  @HiveField(5)
  DateTime? end;
  @HiveField(24)
  DateTime? dueDate;

  // repetations field
  @HiveField(6)
  bool isRepeated;
  @HiveField(7)
  String? repetationType;
  @HiveField(8)
  List<String> repetations;
  // reminder section
  @HiveField(9)
  bool reminder;
  @HiveField(10)
  Duration? reminderInterval;
  @HiveField(11)

  // progress
  @HiveField(12)
  int progress; // 0 <progress < 100
  @HiveField(13)
  bool isDone;
  @HiveField(14)
  int preority;
  @HiveField(15)
  bool favorite;
  @HiveField(16)
  bool bin = false;
// relational properties
  @HiveField(17)
  bool isInproject;

  @HiveField(17)
  bool isInList=false;
  @HiveField(18)
  String? ListId;

  @HiveField(18)
  String? projectId;
  @HiveField(21)
  String? sectionIndex;
  @HiveField(23)
  String? assignedtoId;
  @HiveField(19)
  bool isInCategory;
  @HiveField(20)
  String? categorieId;
  @HiveField(22)
  List<Task>? subtasks=<Task>[];

  Task(
      {this.id="",
      required this.title,
      this.desc,
      required this.isTimed,
      this.start,
      this.end,
      this.dueDate,
      required this.isRepeated,
      this.repetationType,
      required this.repetations,
      required this.reminder,
      this.reminderInterval,
      this.isDone=false,
      this.progress=0,
      required this.preority,
      this.favorite=false,
      required this.isInproject,
      this.projectId,
      required this.isInCategory,
      this.categorieId,
      this.isInList=false,
      this.ListId, this.bin=false,
      this.sectionIndex,
      this.assignedtoId,
      this.subtasks})
  //
  {
    // init id
    id = getId();
    //
    //
  }
  factory Task.fromJson(Map<String, dynamic> json) {
    print("hello this from json ${json['title']}");
    var RmembersJson = json['repetations'] as List<dynamic>;
    var  repetations = RmembersJson.map((rep) => rep.toString()).toList();
    return Task(
      id: json['_id'] as String,
      title: json['title']!=null ?json['title'] as String :"",
      desc: json['desc'] as String?,
      isTimed: json['isTimed']!=null?json['isTimed'] as bool:false,
      start: json['start'] != null ? DateTime.parse(json['start'] as String) : null,
      end: json['end'] != null ? DateTime.parse(json['end'] as String) : null,
      dueDate: json['dueDate'] != null ? DateTime.parse(json['dueDate'] as String) : null,
      isRepeated: json['isRepeated'] !=null ? json['isRepeated'] as bool:false,
      repetationType: json['repetationType'] ,
      repetations: repetations,
      //repetations: json['repetations']!=null ?json['repetations']  :[] ,
      reminder: json['reminder'] !=null ? json['reminder']  as bool : false,
      reminderInterval: json['reminderInterval'] != null ? Duration(milliseconds: json['reminderInterval'] as int) : null,
      progress: json['progress']!=null ? json['progress'] as int:0 ,
      isDone: json['isDone']!=null? json['isDone'] as bool:false,
      preority: json['priority']!=null? json['priority'] as int:4,
      favorite: json['favorite']!=null ? json['favorite'] as bool:false,
      bin: json['bin']!=null ? json['bin'] as bool:false,
      isInproject: json['isInProject'] !=null ? json['isInProject'] as bool:false,
      isInList: json['isInList']!=null? json['isInList'] as bool:false,
      ListId: json['listId']!=null? json['listId'] as String? :"",
      projectId: json['projectId']!=null ? json['projectId'] as String?:"",
      sectionIndex: json['sectionIndex']!=null ? json['sectionIndex'] as String? : "",
      assignedtoId: json['assignedToId'] !=null? json['assignedToId'] as String? :"" ,
      isInCategory: json['isInCategory']!=null ? json['isInCategory'] as bool:false,
      categorieId: json['categoryId']!=null ? json['categoryId'] as String? :"",
      subtasks:json['subtasks']!=null? (json['subtasks'] as List<dynamic>).map((task) => Task.fromJson(task as Map<String, dynamic>)).toList():[],
    );
  }
}
