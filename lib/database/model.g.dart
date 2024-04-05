// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StudentupdatesAdapter extends TypeAdapter<Studentupdates> {
  @override
  final int typeId = 1;

  @override
  Studentupdates read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Studentupdates(
      name: fields[0] as String?,
      week: fields[1] as String?,
      image: fields[2] as String?,
      age: fields[3] as int?,
      phone: fields[4] as int?,
      address: fields[5] as String?,
      hub: fields[6] as String?,
      id: fields[7] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Studentupdates obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.week)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.age)
      ..writeByte(4)
      ..write(obj.phone)
      ..writeByte(5)
      ..write(obj.address)
      ..writeByte(6)
      ..write(obj.hub)
      ..writeByte(7)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentupdatesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
