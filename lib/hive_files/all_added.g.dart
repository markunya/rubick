part of 'all_added.dart';

class AllAddedAdapter extends TypeAdapter<AllAdded> {
  @override
  final typeId = 18;

  @override
  AllAdded read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
        for(int i=0; i < numOfFields; i ++) reader.readByte(): reader.read(),
    };
    return AllAdded(
         words: fields[0] as Map,
         wordsQuestions: fields[1] as Map,
         wordsAnswers: fields[2] as Map,
         wordsMistakes: fields[3] as Map,
    );
  }

  @override
  void write(BinaryWriter writer, AllAdded obj){
    writer
    ..writeByte(4)
    ..writeByte(0)
    ..write(obj.words)
    ..writeByte(1)
    ..write(obj.wordsQuestions)
    ..writeByte(2)
    ..write(obj.wordsAnswers)
    ..writeByte(3)
    ..write(obj.wordsMistakes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator == (Object other) =>
             identical(this, other) ||
             other is AllAddedAdapter &&
             runtimeType == other.runtimeType &&
             typeId == other.typeId; 
}