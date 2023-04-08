import 'package:get/get_state_manager/get_state_manager.dart';

class ScreenController extends GetxController {
  int _index = 0;
  SelectScreen(int screenindex) {
    _index = screenindex;
    update();
  }

  fetchData(int index) {
    // fetching data from the local storage
// then filter it and  return it
    return [];
  }

  List<String> getLis() {
    List<String> list = [];
    list.addAll(["hamza", "hamza2"]);
    return list;
  }

  int get selectedScreen => _index;
}
