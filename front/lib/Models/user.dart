import 'package:front/Models/id.dart';
import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 5)
class User {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String name;

  @HiveField(2)
  late String email;

  @HiveField(3)
  late String profileImagePath;
  @HiveField(4)
  late String password;

  updateProfile({String? username, String? email, String? password}) {
    if (username != null) {
      this.name = username;
    }
    if (email != null) {
      this.email = email;
    }
    if (password != null) {
      this.password = password;
    }
    save();
  }

  User(
      {this.id="",
        this.password="",
        required this.name,
      required this.email,
      required this.profileImagePath}) {
    this.id = getId();
  }

  void save() async {
    var box = await Hive.openBox<User>("user");
  }
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      profileImagePath: json['profileImagePath'] as String,
      password: json['password'] as String,
    );
  }
}
