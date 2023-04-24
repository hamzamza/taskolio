import 'package:front/Models/id.dart';
import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 5)
class User {
  late String id;

  @HiveField(1)
  late String username;

  @HiveField(2)
  late String email;

  @HiveField(3)
  late String profileImagePath;
  @HiveField(4)
  late String token;

  static updateProfile({
    String? username,
    String? email,
    String? profileImagePath,
    String? token,
  }) async {
    var box = await getBox();
    var user = box.get("localuser");
    if (user != null) {
      if (token != null) user.token = token;
      if (username != null) user.username = username;
      if (email != null) user.email = email;
      if (profileImagePath != null) user.profileImagePath = profileImagePath;
      box.put("localuser", user);
    }
  }

  static Future<User?> getProfile() async {
    var box = await getBox();
    var user = box.get("localuser");
    return user;
  }

  static removeProfile() async {
    var box = await getBox();
    box.clear();
  }

  static Future<String?> getToken() async {
    var box = await getBox();
    return box.get("localuser")?.token;
  }

  static putProfile({
    required String username,
    required String email,
    required String profileImagePath,
    required String token,
  }) async {
    var box = await getBox();

    User user = User(
      email: email,
      username: username,
      token: token,
      profileImagePath: profileImagePath,
    );
    box.put("localuser", user);
  }

  User(
      {required this.username,
      required this.email,
      required this.profileImagePath,
      required this.token});

  static Future<Box<User>> getBox() => Hive.openBox<User>('user');
  void save() async {
    var box = await getBox();
    box.put("localuser", this);
  }
}
