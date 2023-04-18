import 'dart:math';
import 'package:flutter/material.dart';
import 'package:rubickk/consts.dart';
import 'package:rubickk/main.dart';
import 'package:rubickk/slovarnie_slova/study/add_words_manually_page_1.dart';
import 'package:rubickk/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rubickk/bigwidgets/appbar_actions.dart';
import 'package:rubickk/dimensions.dart';
import 'package:rubickk/slovarnie_slova/study/collection_page.dart';
import '../../hive_files/hive_collection.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import '../../main.dart';
import 'package:collection/collection.dart';



class checkChosedWordsPage extends StatelessWidget {
  Map selectedWordsChecker;
  Map selectedWordsWords;
  Map selectedWordsQuestions;
  Map selectedWordsMistakes;
  Set selectedWordsHasDefs;
  int indexOfCollection;
  checkChosedWordsPage({Key? key,
  required this.selectedWordsChecker,
  required this.selectedWordsWords,
  required this.selectedWordsQuestions,
  required this.selectedWordsMistakes,
  required this.indexOfCollection,
  required this.selectedWordsHasDefs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List chosedWordsList = [];
    for(var item in selectedWordsChecker.entries){
      if (item.value == true){
        chosedWordsList.add([selectedWordsWords[item.key],
                              selectedWordsQuestions[item.key],
                              item.key,
                              selectedWordsMistakes[item.key],
                              selectedWordsHasDefs.contains(item.key),
                              ]);
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
                                                              text: chosedWordsList[i][0],
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
                        if(!all_added.get(0).words.containsKey(chosedWordsList[i][2])){
                            all_added.get(0).words[chosedWordsList[i][2]]=1;
                            all_added.get(0).wordsQuestions[chosedWordsList[i][2]] = chosedWordsList[i][1];
                            all_added.get(0).wordsAnswers[chosedWordsList[i][2]] = chosedWordsList[i][0];
                            all_added.get(0).wordsMistakes[chosedWordsList[i][2]] = chosedWordsList[i][3]; 
                            all_added.get(0).save();
                        }else{
                            all_added.get(0).words[chosedWordsList[i][2]]++;
                            all_added.get(0).save();
                        }
                        slovarnie_slova_box.get(indexOfCollection).words.add(chosedWordsList[i]);
                        slovarnie_slova_box.get(indexOfCollection).save();
                       }
                       MapsInAWMP1.counterOfSelectedWords = 0;
                       MapsInAWMP1.selectedWordsChecker.clear();
                       MapsInAWMP1.selectedWordsQuestions.clear();
                       MapsInAWMP1.selectedWordsWords.clear();
                       MapsInAWMP1.selectedWordsMistakes.clear();
                       MapsInAWMP1.selectedWordsHasDefs.clear();
                       chosedWordsList.clear();
                       Navigator.pop(context);
                       Navigator.pop(context);
                       Navigator.pop(context);
                       Navigator.push(
                                                     context,
                                                     MaterialPageRoute(builder: (context) => CollectionPage(index: indexOfCollection),
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