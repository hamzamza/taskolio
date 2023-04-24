import 'package:get/get_state_manager/get_state_manager.dart';

class UserController extends GetxController {
  late bool _waiting = false;
  late String _email = "";
  late String usernam = "";
  late String _password = "";
  late bool _logedin = false;
  late bool _loading = true;
}
