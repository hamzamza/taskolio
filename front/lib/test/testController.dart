import 'package:front/Models/category.dart';
import 'package:front/Models/list.dart';
import 'package:hive_flutter/hive_flutter.dart';

runtest() async {
  print(
      "test section *********************************************************************");
// ********************************************************************  $$ categories $$
  await Category.deleteAllCategories();
  await Category.addMany([
    Category(title: "studing", them: 1),
    Category(title: "sport", them: 3, desc: "this is sport category")
  ]);

  List<Category> categorieslist = await Category.getAllCategories();
  int i = 0;
  print(categorieslist.length);
  categorieslist.forEach((element) {
    i++;
    print(i);
    print("${element.title}   ${element.id}");
  });
// ********************************************************************  $$ task list $$
//  TaskList.addTaskList(TaskList(title: "title", them: 1));
  //  List<TaskList> list = await TaskList.getAllTaskLists();
  // print(list[0].title);

  print(
      "end test section  ******************************************************************");
}
