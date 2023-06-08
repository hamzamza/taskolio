import 'package:hive/hive.dart';

class DurationAdapter extends TypeAdapter<Duration> {
  @override
  Duration read(BinaryReader reader) {
    final durationMilliseconds = reader.readInt();
    return Duration(milliseconds: durationMilliseconds);
  }

  @override
  void write(BinaryWriter writer, Duration obj) {
    writer.writeInt(obj.inMilliseconds);
  }

  @override
  int get typeId => 123; // Replace with a unique identifier for your adapter
}





