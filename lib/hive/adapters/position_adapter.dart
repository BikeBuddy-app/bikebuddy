import 'package:geolocator/geolocator.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PositionAdapter extends TypeAdapter<Position> {
  @override
  final typeId = 5;

  @override
  void write(BinaryWriter writer, Position obj) => writer.writeMap(obj.toJson());

  @override
  Position read(BinaryReader reader) => Position.fromMap(reader.readMap());
}
