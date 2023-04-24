import 'package:front/Models/user.dart';
import 'package:front/api/authapi.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class AuthController extends GetxController {
  late bool _waiting = false;
  late String _email = "";
  late String _password = "";
  late bool _logedin = false;
  late bool _loading = true;
  setPassword(String password) {
    _password = password;
  }

  setEmail(String email) {
    _email = email;
  }

  Future<bool> login() async {
    _waiting = true;
    print("email" + _email);
    update();
    bool logedin = await Login(_email, _password);
    _waiting = false;
    update();
    return logedin;
  }

  void checkAuth() async {
    _loading = true;
    update();
    var isauth = await User.getToken();
    _logedin = isauth != null ? true : false;
    _loading = false;
    update();
  }

  get Iswaiting => _waiting;
  get IsLogedin => _logedin;
  get IsLoading => _loading;
}
