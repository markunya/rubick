import 'package:hive/hive.dart';
part 'collection.g.dart';

@HiveType(typeId: 1)
class Collection extends HiveObject{

  Collection({
  required this.name,
  required this.words,
  required this.isAdded,
  });

  @HiveField(0)
  String name;

  @HiveField(1)
  List words;

  @HiveField(2)
  bool isAdded;
}