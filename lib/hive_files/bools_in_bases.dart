import 'package:hive/hive.dart';
part 'bools_in_bases.g.dart';

@HiveType(typeId: 2)
class BoolsInBases extends HiveObject{

  BoolsInBases({
  this.baseOfSlovarnieSlovaIsAdded = true,
  this.baseOfUdareniaIsAdded = true,
  this.currentStudyPage = true,
  this.currentTestPage = true,
  });

  @HiveField(0)
  bool baseOfSlovarnieSlovaIsAdded;

  @HiveField(1)
  bool baseOfUdareniaIsAdded;

  @HiveField(2)
  bool currentStudyPage;

  @HiveField(3)
  bool currentTestPage;
}