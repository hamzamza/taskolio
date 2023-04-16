import 'id.dart';

class SubTask {
  SubTask({required this.title, required this.body}) {
    id = getId();
  }
  late String id;
  String title;
  String body;
  bool done = false;
}
