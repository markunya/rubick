import 'package:hive/hive.dart';
part 'all_added.g.dart';

@HiveType(typeId: 3)
class AllAdded extends HiveObject{

  AllAdded({
  required this.words,
  required this.wordsQuestions,
  required this.wordsAnswers,
  required this.wordsMistakes,
  });

  @HiveField(0)
  Map words;

  @HiveField(1)
  Map wordsQuestions;

  @HiveField(2)
  Map wordsAnswers;

  @HiveField(3)
  Map wordsMistakes;
}