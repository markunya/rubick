import 'dart:math';
import 'package:flutter/material.dart';
import 'package:rubickk/consts.dart';
import 'package:rubickk/main.dart';
import 'package:rubickk/udarenia/study/add_words_manually_1_udarenia.dart';
import 'package:rubickk/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rubickk/bigwidgets/appbar_actions.dart';
import 'package:rubickk/dimensions.dart';
import 'package:rubickk/udarenia/study/collection_page_udarenia.dart';
import '../../hive_files/hive_collection.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import '../../main.dart';
import 'package:collection/collection.dart';



class checkChosedWordsPageUdarenia extends StatelessWidget {
  Map selectedWordsChecker;
  Map selectedWordsWords;
  Map selectedWordsAnswers;
  Map selectedWordsVariants;
  Set selectedWordsHasDefs;
  int indexOfCollection;
  checkChosedWordsPageUdarenia({Key? key,
  required this.selectedWordsChecker,
  required this.selectedWordsWords,
  required this.selectedWordsAnswers,
  required this.selectedWordsVariants,
  required this.selectedWordsHasDefs,
  required this.indexOfCollection,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List chosedWordsList = [];
    for(var item in selectedWordsChecker.entries){
      if (item.value == true){
        chosedWordsList.add([item.key,
                              selectedWordsWords[item.key], 
                              selectedWordsAnswers[item.key], 
                              selectedWordsVariants[item.key],
                              selectedWordsHasDefs.contains(item.key)]);
      }
    }
    return Scaffold(
      appBar:  AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textColor),
          onPressed: (){
            Navigator.pop(context);
          }
        ),
        title: MyText(text: AppStrings.addWordsManuallyPage2AppBarTitle, size: Dimensions.appBarFontSize, weight: FontWeight.w700, fittedBox: true,),
        actions: [ AppBarActions(),],
    ),
    body: Column(
      children: [
        Expanded(
          child: ScrollConfiguration(
                              behavior: MyBehavior(),
                              child: SingleChildScrollView(
                                   physics: ScrollPhysics(),
                                   child: ListView.builder(
                                           itemCount: chosedWordsList.length,
                                           physics: NeverScrollableScrollPhysics(),
                                           shrinkWrap: true,
                                           itemBuilder: (context, i){
                                           return  MyCard(
                                                              text: chosedWordsList[i][2],
                                                              textFontSize: Dimensions.wordCardFS,
                                                              side: BorderSide(color: AppColors.cardWidgetCommonBorderColor, width: 2,),
                                                              borderRadius: Dimensions.WordCardBR,
                                                              backgroundColor: AppColors.cardWidgetBackgroundColor,
                                                              verticalMargin: Dimensions.WordCardVerticalMargin,
                                                              horizontalMargin: Dimensions.WordCardHorizontalMargin,
                                                              trailing: Icon(Icons.delete, size: 0, color: AppColors.invisible),
                                                             );              
                                  } ,
                               ),
                               ),
                            ),
                           ),
             Align(
             alignment: Alignment.bottomCenter,
             child: Container(                   
                           width: Dimensions.screenWidth,
                           color: AppColors.backgroundColor,
                           child: Padding(
                           padding: EdgeInsets.only(bottom: Dimensions.addWordsManuallyButtonMarginBottom, top:0,
                           left: Dimensions.addWordsManuallyButtonMarginHorizontal,
                           right:Dimensions.addWordsManuallyButtonMarginHorizontal),
                           child: ElevatedButton(
                           child: Padding(
                                    padding:EdgeInsets.symmetric(vertical: Dimensions.addWordsManuallyButtonPaddingVerical),
                                    child: MyText(text: AppStrings.addWordsManuallyPage2ButtonTitle, size: Dimensions.buttonFontSize),
                                    ),      
                           style: ButtonStyle(
                           backgroundColor: MaterialStateProperty.all<Color>(AppColors.buttonBackgroundColor),
                           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                           RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(Dimensions.TestPageButtonBR),
         ),
        ),
                   ) ,
              onPressed:(){
                 for(int i = 0; i< chosedWordsList.length; i++){
                        if(!all_added_udarenia.get(0).words.containsKey(chosedWordsList[i][0])){
                            all_added_udarenia.get(0).words[chosedWordsList[i][0]]=1;
                            all_added_udarenia.get(0).wordsWords[chosedWordsList[i][0]] = chosedWordsList[i][1];
                            all_added_udarenia.get(0).wordsVariants[chosedWordsList[i][0]] = chosedWordsList[i][3];
                            all_added_udarenia.get(0).wordsAnswers[chosedWordsList[i][0]] = chosedWordsList[i][2];
                            all_added_udarenia.get(0).save();
                        }else{
                            all_added_udarenia.get(0).words[chosedWordsList[i][0]]++;
                            all_added_udarenia.get(0).save();
                        }
                        udarenia_box.get(indexOfCollection).words.add(chosedWordsList[i]);
                        udarenia_box.get(indexOfCollection).save();
                       }
                       MapsInAWMP1.counterOfSelectedWords = 0;
                       MapsInAWMP1.selectedWordsChecker.clear();
                       MapsInAWMP1.selectedWordsAnswers.clear();
                       MapsInAWMP1.selectedWordsVariants.clear();
                       MapsInAWMP1.selectedWordsWords.clear();
                       MapsInAWMP1.selectedWordsHasDefs.clear();
                       chosedWordsList.clear();
                       Navigator.pop(context);
                       Navigator.pop(context);
                       Navigator.pop(context);
                       Navigator.push(
                                                     context,
                                                     MaterialPageRoute(builder: (context) => CollectionPageUdarenia(index: indexOfCollection),
                                                     ),
                                                    );
                      },
                            ),
                            ),
                         ),
           ),


              
      ],
    ),
    );
  }
}