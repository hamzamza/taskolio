

class Task {
  // key generated automaticly
  late String id;
  // text data
  String title;
  String? desc;
  // dates section
  bool isTimed;
  DateTime? start;
  DateTime? end;
  DateTime? dueDate;
  bool isRepeated;
  //String Repetation? repetationType;
  List<int> repetations;

  // reminder section
  bool reminder;
  int? reminderInterval;
  int progress;

  bool isDone;

  int preority;

  bool favorite;

  bool bin = false;


  bool isInproject;

  String? projectId;

  String? sectionIndex;

  String? assignedtoId;

  bool isInCategory;

  String? categorieId;

  //List<SubTask>? subtasks;

  Task(
      {required this.title,
        this.desc,
        required this.isTimed,
        this.start,
        this.end,
        this.dueDate,
        required this.isRepeated,
        //this.repetationType,
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
        //this.subtasks
  })

  {
    // init id
    //id = getId();
    //
    //
  }
}