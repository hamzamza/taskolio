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

  User(
      {required this.name,
      required this.email,
      required this.profileImagePath}) {
    this.id = getId();
  }
}
