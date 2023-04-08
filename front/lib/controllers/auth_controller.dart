import 'package:front/api/authapi.dart';
import 'package:front/api/storage.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class AuthController extends GetxController {
  late bool _waiting = false;
  late String _email;
  late String _password;
  late bool _logedin = false;
  late bool _loading = true;

  Future<bool> login(String username, String password) async {
    _waiting = true;
    update();
    bool logedin = await Login(username, password);
    _waiting = false;
    update();
    return logedin;
  }

  void checkAuth() async {
    _loading = true;
    update();
    var isauth = await getStroage();
    _logedin = isauth != null ? true : false;
    _loading = false;
    update();
  }

  get Iswaiting => _waiting;
  get IsLogedin => _logedin;
  get IsLoading => _loading;
}
