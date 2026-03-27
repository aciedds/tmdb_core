// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'film_model_adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FilmModelAdapterAdapter extends TypeAdapter<FilmModelAdapter> {
  @override
  final int typeId = 0;

  @override
  FilmModelAdapter read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FilmModelAdapter(
      id: fields[0] as int?,
      title: fields[1] as String?,
      overview: fields[2] as String?,
      backdropPath: fields[3] as String?,
      posterPath: fields[4] as String?,
      releaseDate: fields[5] as String?,
      voteAverage: fields[6] as double?,
      genreIds: (fields[7] as List?)?.cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, FilmModelAdapter obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.overview)
      ..writeByte(3)
      ..write(obj.backdropPath)
      ..writeByte(4)
      ..write(obj.posterPath)
      ..writeByte(5)
      ..write(obj.releaseDate)
      ..writeByte(6)
      ..write(obj.voteAverage)
      ..writeByte(7)
      ..write(obj.genreIds);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FilmModelAdapterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
