import 'package:hive/hive.dart';
import '../Models/project.dart';


class SectionAdapter extends TypeAdapter<Section> {
  @override
  final int typeId = 0;

  @override
  Section read(BinaryReader reader) {
    final numFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numFields; i++) reader.readByte(): reader.read(),
    };
    final section = Section(
      title: fields[0] as String,
      desc: fields[1] as String?,
    )..index = fields[2] as String?;
    return section;
  }

  @override
  void write(BinaryWriter writer, Section section) {
    writer.writeByte(3);
    writer.writeByte(0);
    writer.write(section.title);
    writer.writeByte(1);
    writer.write(section.desc);
    writer.writeByte(2);
    writer.write(section.index);
  }
 }
