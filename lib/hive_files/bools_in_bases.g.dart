part of 'bools_in_bases.dart';

class BoolsInBasesAdapter extends TypeAdapter<BoolsInBases> {
  @override
  final typeId = 17;

  @override
  BoolsInBases read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
        for(int i=0; i < numOfFields; i ++) reader.readByte(): reader.read(),
    };
    return BoolsInBases(
         baseOfSlovarnieSlovaIsAdded: fields[0] as bool,
         baseOfUdareniaIsAdded: fields[1] as bool,
         currentStudyPage: fields[2] as bool,
         currentTestPage: fields[3] as bool,

    );
  }

  @override
  void write(BinaryWriter writer, BoolsInBases obj){
    writer
    ..writeByte(4)
    ..writeByte(0)
    ..write(obj.baseOfSlovarnieSlovaIsAdded)
    ..writeByte(1)
    ..write(obj.baseOfUdareniaIsAdded)
    ..writeByte(2)
    ..write(obj.currentStudyPage)
    ..writeByte(3)
    ..write(obj.currentTestPage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator == (Object other) =>
             identical(this, other) ||
             other is BoolsInBasesAdapter &&
             runtimeType == other.runtimeType &&
             typeId == other.typeId; 
}