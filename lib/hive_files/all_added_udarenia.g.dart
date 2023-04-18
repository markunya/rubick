part of 'all_added_udarenia.dart';

class AllAddedUdareniaAdapter extends TypeAdapter<AllAddedUdarenia> {
  @override
  final typeId = 183;

  @override
  AllAddedUdarenia read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
        for(int i=0; i < numOfFields; i ++) reader.readByte(): reader.read(),
    };
    return AllAddedUdarenia(
         words: fields[0] as Map,
         wordsVariants: fields[1] as Map,
         wordsAnswers: fields[2] as Map,
         wordsWords: fields[3] as Map,
    );
  }

  @override
  void write(BinaryWriter writer, AllAddedUdarenia obj){
    writer
    ..writeByte(4)
    ..writeByte(0)
    ..write(obj.words)
    ..writeByte(1)
    ..write(obj.wordsVariants)
    ..writeByte(2)
    ..write(obj.wordsAnswers)
    ..writeByte(3)
    ..write(obj.wordsWords);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator == (Object other) =>
             identical(this, other) ||
             other is AllAddedUdareniaAdapter &&
             runtimeType == other.runtimeType &&
             typeId == other.typeId; 
}