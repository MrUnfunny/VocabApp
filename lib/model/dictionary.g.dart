// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dictionary.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DictionaryAdapter extends TypeAdapter<Dictionary> {
  @override
  final int typeId = 0;

  @override
  Dictionary read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Dictionary(
      word: fields[0] as String,
      pronunciation: fields[1] as String,
      definitions: (fields[2] as List)?.cast<Definition>(),
      rhymes: (fields[3] as List)?.cast<String>(),
      synonynms: (fields[4] as List)?.cast<String>(),
      antonyms: (fields[5] as List)?.cast<String>(),
      isFav: fields[6] as bool,
      isLiked: fields[7] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Dictionary obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.word)
      ..writeByte(1)
      ..write(obj.pronunciation)
      ..writeByte(2)
      ..write(obj.definitions)
      ..writeByte(3)
      ..write(obj.rhymes)
      ..writeByte(4)
      ..write(obj.synonynms)
      ..writeByte(5)
      ..write(obj.antonyms)
      ..writeByte(6)
      ..write(obj.isFav)
      ..writeByte(7)
      ..write(obj.isLiked);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DictionaryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
