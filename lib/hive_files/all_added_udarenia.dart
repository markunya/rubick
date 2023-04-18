import 'package:hive/hive.dart';
part 'all_added_udarenia.g.dart';

@HiveType(typeId: 319)
class AllAddedUdarenia extends HiveObject{
  AllAddedUdarenia({
  required this.words,
  required this.wordsVariants,
  required this.wordsAnswers,
  required this.wordsWords,
  });

  @HiveField(0)
  Map words;

  @HiveField(1)
  Map wordsVariants;

  @HiveField(2)
  Map wordsAnswers;

  @HiveField(3)
  Map wordsWords;
}