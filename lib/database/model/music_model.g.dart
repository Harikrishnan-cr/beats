// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'music_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MyMusicModelAdapter extends TypeAdapter<MyMusicModel> {
  @override
  final int typeId = 1;

  @override
  MyMusicModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MyMusicModel(
      id: fields[0] as String?,
      audio: fields[1] as String?,
      musicName: fields[2] as String?,
      musicArtist: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, MyMusicModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.audio)
      ..writeByte(2)
      ..write(obj.musicName)
      ..writeByte(3)
      ..write(obj.musicArtist);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyMusicModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
