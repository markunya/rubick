import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rubickk/hive_files/bools_in_bases.dart';
import 'package:rubickk/consts.dart';
import 'package:rubickk/slovarnie_slova/study/slovarnie_slova.dart';
import 'package:rubickk/slovarnie_slova/tests/test_slovarnie_slova_page.dart';
import 'package:rubickk/pages/tests_page_for_ss.dart';
import 'package:rubickk/pages/home_page.dart';
import 'package:rubickk/slovarnie_slova/study/base_of_words_page.dart';
import 'package:rubickk/pages/instruction_page.dart';
import 'package:rubickk/firebase_options.dart';
import 'package:rubickk/udarenia/study/base_of_udarenia_page.dart';
import 'package:yandex_mobileads/mobile_ads.dart';
import 'hive_files/all_added.dart';
import 'hive_files/all_added_udarenia.dart';
import 'hive_files/hive_collection.dart';

late Box slovarnie_slova_box;
late Box udarenia_box;
late Box bools_in_bases;
late Box all_added;
late Box all_added_udarenia;


Future<void> main() async {
  try{
   WidgetsFlutterBinding.ensureInitialized();
   SystemChrome.setPreferredOrientations([ 
   DeviceOrientation.portraitUp,
   ]);
  await Hive.initFlutter();
  Hive.registerAdapter(CollectionAdapter());
  Hive.registerAdapter(AllAddedAdapter());
  Hive.registerAdapter(AllAddedUdareniaAdapter());
  Hive.registerAdapter(BoolsInBasesAdapter());
  slovarnie_slova_box = await Hive.openBox(AppStrings.collectionsBoxName);
  udarenia_box = await Hive.openBox(AppStrings.udareniaBoxName);
  bools_in_bases = await Hive.openBox(AppStrings.boolsInBasesName);
  all_added = await Hive.openBox(AppStrings.allAddedName);
  all_added_udarenia = await Hive.openBox(AppStrings.allAddedUdareniaName);
  /*slovarnie_slova_box.clear();
  udarenia_box.clear();
  all_added.clear();
  udarenia_box.clear();
  all_added_udarenia.clear();*/
  if(bools_in_bases.isEmpty){
  bools_in_bases.add(BoolsInBases());
  }
  if(all_added.isEmpty){
     all_added.add(AllAdded(words: {},
                            wordsQuestions: {},
                            wordsAnswers: {},
                            wordsMistakes: {},
                            ));
  }

  if (all_added_udarenia.isEmpty) {
    all_added_udarenia.add(AllAddedUdarenia(words:{},
                                            wordsVariants: {},
                                            wordsAnswers: {},
                                            wordsWords: {},
                                            ));}

  await Firebase.initializeApp(
    name: 'rubickk',
    options: DefaultFirebaseOptions.currentPlatform
    );
  await MobileAds.initialize();
  runApp(MyApp());
  }catch(e){
    runApp(Center(
      child: Text(
        e.toString(),
        textDirection: TextDirection.ltr,
      ),
    ));
  }
  
}



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

 
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(

      routes: {          
              '/baseOfWords': ((context) => BaseOfWords()),
              '/baseOfUdarenia': ((context) => BaseOfUdarenia()),
              '/instruction': ((context) => InstructionPage()),
            },
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData( 
          scaffoldBackgroundColor: AppColors.backgroundColor,   
          colorScheme: ColorScheme.fromSwatch().copyWith(   
          primary: AppColors.mainColor,
          secondary: AppColors.lightBlueColor,
                ),
        ),
      home: HomePage(),
    );
  }
}

