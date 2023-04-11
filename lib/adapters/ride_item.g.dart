// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ride_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RideItemAdapter extends TypeAdapter<RideItem> {
  @override
  final int typeId = 0;

  @override
  RideItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RideItem(
      fields[0] as Locator,
      fields[1] as Timer,
    );
  }

  @override
  void write(BinaryWriter writer, RideItem obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.locator)
      ..writeByte(1)
      ..write(obj.timer);
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
