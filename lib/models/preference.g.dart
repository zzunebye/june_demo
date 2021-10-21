// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preference.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PreferenceAdapter extends TypeAdapter<Preference> {
  @override
  final int typeId = 0;

  @override
  Preference read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Preference(
      name: fields[0] as String,
      id: fields[1] as String,
      changedDate: fields[2] as DateTime,
      checked: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Preference obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.changedDate)
      ..writeByte(3)
      ..write(obj.checked);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PreferenceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
