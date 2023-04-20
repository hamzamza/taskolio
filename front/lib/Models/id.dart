import 'package:uuid/uuid.dart';

String getId() {
  const uuid = Uuid();
  String id = uuid.v4();
  return id;
}
