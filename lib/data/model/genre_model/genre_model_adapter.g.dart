// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'genre_model_adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GenreModelAdapterAdapter extends TypeAdapter<GenreModelAdapter> {
  @override
  final int typeId = 1;

  @override
  GenreModelAdapter read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GenreModelAdapter(
      id: fields[0] as int?,
      name: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, GenreModelAdapter obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GenreModelAdapterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
