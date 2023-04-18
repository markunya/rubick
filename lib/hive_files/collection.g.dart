part of 'hive_collection.dart';

class CollectionAdapter extends TypeAdapter<Collection> {
  @override
  final typeId = 16;

  @override
  Collection read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
        for(int i=0; i < numOfFields; i ++) reader.readByte(): reader.read(),
    };
    return Collection(
         name: fields[0] as String,
         words: fields[1] as List,
         isAdded: fields[2] as bool,

    );
  }

  @override
  void write(BinaryWriter writer, Collection obj){
    writer
    ..writeByte(3)
    ..writeByte(0)
    ..write(obj.name)
    ..writeByte(1)
    ..write(obj.words)
    ..writeByte(2)
    ..write(obj.isAdded);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator == (Object other) =>
             identical(this, other) ||
             other is CollectionAdapter &&
             runtimeType == other.runtimeType &&
             typeId == other.typeId; 
}


