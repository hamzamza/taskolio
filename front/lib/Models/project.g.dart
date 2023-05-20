// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProjectAdapter extends TypeAdapter<Project> {
  @override
  final int typeId = 4;

  @override
  Project read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Project(
      title: fields[1] as String,
      desc: fields[2] as String?,
      them: fields[3] as Color,
      userrole: fields[8] as String,
      icon: fields[4] as String?,
    )
      ..id = fields[0] as String
      ..members = (fields[4] as List).cast<Member>()
      ..archived = fields[5] as bool
      ..tasks = (fields[6] as List).cast<Task>()
      ..sections = (fields[7] as List).cast<Section>();
  }

  @override
  void write(BinaryWriter writer, Project obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.desc)
      ..writeByte(4)
      ..write(obj.icon)
      ..writeByte(3)
      ..write(obj.them)
      ..writeByte(4)
      ..write(obj.members)
      ..writeByte(5)
      ..write(obj.archived)
      ..writeByte(6)
      ..write(obj.tasks)
      ..writeByte(7)
      ..write(obj.sections)
      ..writeByte(8)
      ..write(obj.userrole);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProjectAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
