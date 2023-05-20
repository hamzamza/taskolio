// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskAdapter extends TypeAdapter<Task> {
  @override
  final int typeId = 1;

  @override
  Task read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Task(
      title: fields[1] as String,
      desc: fields[2] as String?,
      isTimed: fields[3] as bool,
      start: fields[4] as DateTime?,
      end: fields[5] as DateTime?,
      dueDate: fields[24] as DateTime?,
      isRepeated: fields[6] as bool,
      repetationType: fields[7] as String?,
      repetations: (fields[8] as List).cast<String>(),
      reminder: fields[9] as bool,
      reminderInterval: fields[10] as Duration?,
      isDone: fields[13] as bool,
      progress: fields[11] as int,
      preority: fields[14] as int,
      favorite: fields[15] as bool,
      isInproject: fields[17] as bool,
      projectId: fields[18] as String?,
      isInCategory: fields[19] as bool,
      categorieId: fields[20] as String?,
      sectionIndex: fields[21] as String?,
      assignedtoId: fields[23] as String?,
      subtasks: (fields[22] as List?)?.cast<Task>(),
    )
      ..id = fields[0] as String
      ..bin = fields[16] as bool;
  }

  @override
  void write(BinaryWriter writer, Task obj) {
    writer
      ..writeByte(24)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.desc)
      ..writeByte(3)
      ..write(obj.isTimed)
      ..writeByte(4)
      ..write(obj.start)
      ..writeByte(5)
      ..write(obj.end)
      ..writeByte(24)
      ..write(obj.dueDate)
      ..writeByte(6)
      ..write(obj.isRepeated)
      ..writeByte(7)
      ..write(obj.repetationType)
      ..writeByte(8)
      ..write(obj.repetations)
      ..writeByte(9)
      ..write(obj.reminder)
      ..writeByte(10)
      ..write(obj.reminderInterval)
      ..writeByte(11)
      ..write(obj.progress)
      ..writeByte(13)
      ..write(obj.isDone)
      ..writeByte(14)
      ..write(obj.preority)
      ..writeByte(15)
      ..write(obj.favorite)
      ..writeByte(16)
      ..write(obj.bin)
      ..writeByte(17)
      ..write(obj.isInproject)
      ..writeByte(18)
      ..write(obj.projectId)
      ..writeByte(21)
      ..write(obj.sectionIndex)
      ..writeByte(23)
      ..write(obj.assignedtoId)
      ..writeByte(19)
      ..write(obj.isInCategory)
      ..writeByte(20)
      ..write(obj.categorieId)
      ..writeByte(22)
      ..write(obj.subtasks);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
