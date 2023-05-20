import 'package:hive/hive.dart';

enum Role { owner, admin, user }

class RoleAdapter extends TypeAdapter<Role> {
  @override
  final typeId = 0;

  @override
  Role read(BinaryReader reader) {
    final index = reader.readByte();
    switch (index) {
      case 0:
        return Role.owner;
      case 1:
        return Role.admin;
      case 2:
        return Role.user;
      default:
        return Role.user;
    }
  }

  @override
  void write(BinaryWriter writer, Role obj) {
    switch (obj) {
      case Role.owner:
        writer.writeByte(0);
        break;
      case Role.admin:
        writer.writeByte(1);
        break;
      case Role.user:
        writer.writeByte(2);
        break;
    }
  }
}
