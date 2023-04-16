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
  Repetation? repetationType;
  @HiveField(8)
  List<DateTime> repetations;

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
  List<SubTask>? subtasks;

  Task(
      {required this.title,
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
      required this.isDone,
      required this.progress,
      required this.preority,
      required this.favorite,
      required this.isInproject,
      this.projectId,
      required this.isInCategory,
      this.categorieId,
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
}
