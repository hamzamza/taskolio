
import 'package:front/Models/repetation.dart';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';

class ColorAdapter extends TypeAdapter<Color> {
  @override
  final typeId = 100;

  @override
  Color read(BinaryReader reader) {
    final value = reader.readUint32();
    return Color(value);
  }

  @override
  void write(BinaryWriter writer, Color obj) {
    writer.writeUint32(obj.value);
  }
}
class RepetationAdapter extends TypeAdapter<Repetation> {
  @override
  final typeId = 1;

  @override
  Repetation read(BinaryReader reader) {
    return Repetation.values[reader.readByte()];
  }

  @override
  void write(BinaryWriter writer, Repetation obj) {
    writer.writeByte(obj.index);
  }
}