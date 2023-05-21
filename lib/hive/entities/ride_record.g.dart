// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ride_record.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PositionRecordAdapter extends TypeAdapter<PositionRecord> {
  @override
  final int typeId = 1;

  @override
  PositionRecord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PositionRecord(
      fields[1] as Duration,
      fields[2] as Position,
    );
  }

  @override
  void write(BinaryWriter writer, PositionRecord obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.timestamp)
      ..writeByte(2)
      ..write(obj.position);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PositionRecordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class RideRecordAdapter extends TypeAdapter<RideRecord> {
  @override
  final int typeId = 2;

  @override
  RideRecord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RideRecord()
      ..route = (fields[3] as List).cast<PositionRecord>()
      ..time = fields[4] as Duration;
  }

  @override
  void write(BinaryWriter writer, RideRecord obj) {
    writer
      ..writeByte(2)
      ..writeByte(3)
      ..write(obj.route)
      ..writeByte(4)
      ..write(obj.time);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RideRecordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
