// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../entities/ride_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PositionTimestampAdapter extends TypeAdapter<PositionTimestamp> {
  @override
  final int typeId = 1;

  @override
  PositionTimestamp read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PositionTimestamp(
      fields[1] as String,
      fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PositionTimestamp obj) {
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
      other is PositionTimestampAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class RideItemAdapter extends TypeAdapter<RideItem> {
  @override
  final int typeId = 2;

  @override
  RideItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RideItem()..positionTimestamps = (fields[3] as List).cast<dynamic>();
  }

  @override
  void write(BinaryWriter writer, RideItem obj) {
    writer
      ..writeByte(1)
      ..writeByte(3)
      ..write(obj.positionTimestamps);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RideItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
