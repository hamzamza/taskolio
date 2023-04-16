import 'package:front/Models/task.dart';
import 'package:hive/hive.dart';

Future<List<Task>> getTodaysTasks() async {
  var box = await Hive.openBox('task');
  var l = box.values.toList().cast<Task>();
  return l.where((item) {
    return item.start?.day == DateTime.now().day;
  }).toList();
}

Future<bool> putTasksforTherFirstTime(List<Task> tasks) async {
  var box = await Hive.openBox('task');
  await box.clear();
  await box.addAll(tasks);

  return true;
}
