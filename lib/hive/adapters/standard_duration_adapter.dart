import 'package:bike_buddy/models/standard_duration.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DurationAdapter extends TypeAdapter<Duration> {
  @override
  final typeId = 3;

  @override
  void write(BinaryWriter writer, Duration value) =>
      writer.writeInt(value.inMicroseconds);

  @override
  Duration read(BinaryReader reader) =>
      Duration(microseconds: reader.readInt());
}

class StandardDurationAdapter extends TypeAdapter<StandardDuration> {
  @override
  final typeId = 4;

  @override
  void write(BinaryWriter writer, Duration value) =>
      writer.writeInt(value.inMicroseconds);

  @override
  StandardDuration read(BinaryReader reader) =>
      StandardDuration(Duration(microseconds: reader.readInt()));
}