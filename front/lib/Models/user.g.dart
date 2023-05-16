// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 5;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      username: fields[1] as String,
      email: fields[2] as String,
      profileImagePath: fields[3] as String,
<<<<<<< HEAD
      token: fields[4] as String,
    );
=======
    )
      ..id = fields[0] as String
      ..password = fields[4] as String;
>>>>>>> backendbranch
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
<<<<<<< HEAD
      ..writeByte(4)
=======
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
>>>>>>> backendbranch
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.profileImagePath)
      ..writeByte(4)
<<<<<<< HEAD
      ..write(obj.token);
=======
      ..write(obj.password);
>>>>>>> backendbranch
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
