import 'package:front/Models/user.dart';
import 'package:front/api/authapi.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class AuthController extends GetxController {
  late bool _waiting = false;
  late String _email = "";
  late String _userName = "";
  late String _password = "";
  late String _passwordCopy = "";

  late bool _logedin = false;
  late bool _loading = true;

  String get email => _email;

  String get userName => _userName;

  String get password => _password;

  String get passwordCopy => _passwordCopy;

  String _submettedemail = "";
  String _submittedUsername = "";
  String _submittedpassword = "";

  String get submittedEmail => _submettedemail;
  String get submittedUsername => _submittedUsername;
  String get submittedPassword => _submittedpassword;
  setPassword(String password) {
    _password = password;
  }

  setCopyPassword(String password) {
    _passwordCopy = password;
  }

  setEmail(String email) {
    _email = email;
  }

  setUsername(String username) {
    _userName = username;
  }

  Future<bool> login() async {
    _waiting = true;

    update();
    bool logedin = await Login(_userName, _password);
    _waiting = false;
    update();
    return logedin;
  }

  Future<List<dynamic>> register() async {
    _waiting = true;
    update();
    if (_email.isEmpty) {
      _waiting = false;
      update();
      return [false, "Email can't be empty"];
    }

    if (_userName.isEmpty) {
      _waiting = false;
      update();
      return [false, "Username can't be empty"];
    }

    if (_password.isEmpty) {
      _waiting = false;
      update();
      return [false, "Password can't be empty"];
    }

    if (_passwordCopy.isEmpty) {
      _waiting = false;
      update();
      return [false, "Confirm Password can't be empty"];
    }
    if (_password != _passwordCopy) {
      _waiting = false;
      update();
      return [false, "passwords not matched "];
    }

    bool registered = await Register(_email, _userName, _password);
    _waiting = false;
    update();
    _submittedUsername = userName;
    _submettedemail = email;
    _submittedpassword = password;
    return [registered, "something wrong"];
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
