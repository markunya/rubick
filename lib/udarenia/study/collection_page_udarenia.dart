import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:rubickk/bigwidgets/appbar_actions.dart';
import 'package:rubickk/udarenia/study/add_words_manually_1_udarenia.dart';
import '../../bigwidgets/word_card_button.dart';
import '../../dimensions.dart';
import '../../firebase_options.dart';
import '../../hive_files/hive_collection.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import '../../main.dart';
import 'package:rubickk/consts.dart';
import 'package:rubickk/widgets.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:collection/collection.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'cards_mode_udarenia.dart';

contain_0(a,b){
          for(int i = 0; i<b.length; i++){
           if(b[i][0].toString() == a.toString()){
             return true;
         }
        }
        return false;
        }

class CollectionPageUdarenia extends StatefulWidget {
   int index;
   CollectionPageUdarenia({
    Key? key,
    required this.index
    }) : super(key: key);

  @override
  State<CollectionPageUdarenia> createState() => _CollectionPageUdareniaState(index: index);
}

class _CollectionPageUdareniaState extends State<CollectionPageUdarenia> {
  bool searchItemsChecker = true;
  TextEditingController _controller = TextEditingController();
  String word = '';
  var wordsListOnSearh = [];
  double _value = 10; 
  int index;
  bool isLoading = false;
  _CollectionPageUdareniaState({required this.index});
  @override
  Widget build(BuildContext context) {

     Future addData(List words_ , int amount, Collection collection) async {     
        CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('udareniya');         
        collectionReference.get().then((value) async {
        int docs_len = value.docs.length;
        int counterOfAdditiveWords = amount - docs_len + all_added_udarenia.get(0).words.length as int;
        int newWordsCounter = 0;
        List shuffledIndexes = List.generate(docs_len, (i) => i);
        shuffledIndexes.shuffle();
        for(int i = 0; i < docs_len; i++){
          String _wordId = value.docs[shuffledIndexes[i]].id;
          String _wordWord = value.docs[shuffledIndexes[i]]['word'];
          String _wordAnswer = value.docs[shuffledIndexes[i]]['answer'];
          String _wordVariants = value.docs[shuffledIndexes[i]]['variants'].toList().join('#');
          bool _hasDef = value.docs[shuffledIndexes[i]]['def'] != "";
          if(!all_added_udarenia.get(0).words.containsKey(_wordId)){
          words_.add([
                        _wordId,
                        _wordWord,
                        _wordAnswer,
                        _wordVariants,  
                        _hasDef,
                        ],
                      );
          collection.save();
          newWordsCounter++;
          all_added_udarenia.get(0).words[_wordId] = 1;
          all_added_udarenia.get(0).wordsVariants[_wordId] = _wordVariants;
          all_added_udarenia.get(0).wordsAnswers[_wordId] = _wordAnswer;
          all_added_udarenia.get(0).wordsWords[_wordId] = _wordWord;
          all_added_udarenia.get(0).save();
          }else if((counterOfAdditiveWords > 0) && !contain_0(_wordId, words_)){
            words_.add([
                        _wordId,
                        _wordWord,
                        _wordAnswer,
                        _wordVariants,  
                        _hasDef,
                        ],
                      );
            collection.save();
            newWordsCounter++;
            all_added_udarenia.get(0).words[_wordId]++;
            all_added_udarenia.get(0).wordsVariants[_wordId] = _wordVariants;
            all_added_udarenia.get(0).wordsAnswers[_wordId] = _wordAnswer;
            all_added_udarenia.get(0).wordsWords[_wordId] = _wordWord;
            all_added_udarenia.get(0).save();
            counterOfAdditiveWords--;
          }
          if (newWordsCounter == amount){
            break;
          }
          }
          if (docs_len > 0) {
              setState(() {});
              Navigator.pop(context);
              if (newWordsCounter < amount) {
              ToastNotification(AppStrings.youHaveAddedAllWordsFromBase, context);
              }
          } else {
              ToastNotification(AppStrings.errorMessage, context);
              Navigator.pop(context);
          }
        }
       );
       
     }  
    
    Future showLoadingIndicator() => showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
        return AlertDialog(   
          backgroundColor: AppColors.invisible,
          content: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.circularProgressIndicatorColor),
                  ),
          ),    
        );
      } 
        )
    );
    
    Future addWords(
     Collection collection,
     int amount,
     ) async {  
            showLoadingIndicator();
            await addData(collection.words, amount, collection);          
     }

    Future addWordsDialog() => showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          backgroundColor: AppColors.alertDialogBackgroundColor,
          title: MyText(text: AppStrings.collectionAllertDialogTitle,
          size: Dimensions.collectionAlertDialogTitleFS,
          textAlign: TextAlign.center,),
          content: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SliderTheme(
        data: SliderTheme.of(context).copyWith(
        trackHeight: Dimensions.TestSliderTrackHeight/1.5,
        trackShape: RoundedRectSliderTrackShape(),
        activeTrackColor:  AppColors.sliderActiveTrackColor,
        inactiveTrackColor: AppColors.sliderInActiveTrackColor,
        thumbShape: RoundSliderThumbShape(
                enabledThumbRadius: Dimensions.TestSliderenabledThumbRadius,
                pressedElevation: 8.0,
        ),
        thumbColor: AppColors.sliderThumbColor,
        overlayColor: AppColors.sliderOverlayColor,
        overlayShape: RoundSliderOverlayShape(overlayRadius: Dimensions.TestSlideroverlayRadius),
        tickMarkShape: RoundSliderTickMarkShape(),
        activeTickMarkColor: AppColors.sliderActiveTickMarkColor,
        inactiveTickMarkColor: AppColors.sliderInActiveTickMarkColor,
        valueIndicatorShape: PaddleSliderValueIndicatorShape(),
        valueIndicatorColor: AppColors.sliderValueIndicatorColor,
        valueIndicatorTextStyle: TextStyle(
                color: AppColors.textColor,
                fontSize: Dimensions.TestSliderFontSize,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
                Slider(
                  min: SliderConsts.minValue,
                  max: SliderConsts.maxValue,
                  value: _value,
                  divisions: (SliderConsts.maxValue - SliderConsts.minValue).round(),
                  label: '${_value.round()}',
                  onChanged: (value) {
                    setState(() {
                      _value = value;
                    });
                  },
                ),
                MyText(text: AppStrings.collectionSliderLabel1 + _value.round().toString() + AppStrings.collectionSliderLabel2,
                       size: Dimensions.collectionSliderLabelFontSize,
                       color: AppColors.grayTextColor),
        ],
      ),
    ),          
                SizedBox(height: Dimensions.SBHeight20),
                ElevatedButton( 
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: Dimensions.addCollectionAlertDialogButtonPadding),
                    child: MyText(text: AppStrings.collectionAlertDialogButton1, size: Dimensions.collectionAlertDialogButtonFS),
                  ),
                  style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(AppColors.buttonBackgroundColor),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                   RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(Dimensions.addCollectionAlertDialogButtonBR),
                  ),
                  ),
                  ),
                   onPressed: () {
                     Navigator.pop(context);
                     addWords(
                      udarenia_box.get(widget.index),
                      _value.round(),
                    );
                   }),
               SizedBox(height: Dimensions.SBHeight10),
              ElevatedButton(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: Dimensions.addCollectionAlertDialogButtonPadding),
                    child: MyText(text: AppStrings.collectionAlertDialogButton2,
                     size: Dimensions.collectionAlertDialogButtonFS,
                      color: AppColors.buttonBackgroundColor),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: AppColors.invisible,
                      side: BorderSide(color: AppColors.buttonBackgroundColor,
                                       width: Dimensions.collectionAlertDialogButton2BorderSide),
                      shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(Dimensions.addCollectionAlertDialogButtonBR),
           ),
                  
                  ),
                   onPressed: (){
                   Navigator.pop(context);
                    Navigator.push(
                                   context,
                                   MaterialPageRoute(builder: (context) => AddWordsManuallyPageUdarenia(indexOfCollection: widget.index),
                                   ),
                                  );  
                   }),
            ],
          ),
          ),


          actions: [   
          ],
        );
      }
    ) 
    );
    
    return Scaffold(
      appBar: AppBar(
         leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textColor),
          onPressed: (){
            Navigator.pop(context);
          }
        ),
         title: MyText(
           text: udarenia_box.get(widget.index).name,
           size: Dimensions.collectionPageABTitle,
           color: AppColors.textColor,
         ),
         actions: [
                AppBarActions(),
           ],
      ),
       body: Column(
         children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                      width: 0.85*Dimensions.screenWidth,
                      child: Padding(
                      padding: EdgeInsets.only(left: Dimensions.searchMarginHorizontal,
                                                right: Dimensions.searchMarginTop,
                                                top: Dimensions.searchMarginTop), 
                      child: TextFormField(
                              onChanged: (value){
                              setState(() {
                              searchItemsChecker = true;
                              word = value;
                                });
                                    },
                              style: TextStyle(color: AppColors.textColor, fontSize: Dimensions.inputFontSize),
                              controller: _controller,        
                              decoration: InputDecoration(    
                              focusedBorder: UnderlineInputBorder(
                                                            borderSide: BorderSide(color: AppColors.textFormFieldUnderlineColor),
                                                                ),
                              prefixIcon:  Icon(Icons.search, size: Dimensions.baseOfWordsSearchIconSize,
                                                color: AppColors.textFormFieldSearchIconColor),
                              hintText: AppStrings.BaseOfWordsSearch,
                              hintStyle: TextStyle(fontSize: Dimensions.TestSSInputHintFontSize,
                                                   color: AppColors.textFormFieldHintColor),           
                                               ),
                                              ),
                                        ),
                                      ),

                IconButton(
                icon: Icon(Icons.library_books, size: Dimensions.iconButtonToCardModeSize, color: AppColors.textColor),
                onPressed: (){
                  if(udarenia_box.get(widget.index).words.length != 0){
                        List listOfWords = udarenia_box.get(widget.index).words;
                        listOfWords.shuffle();
                        Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => CardsModeUdareniaPage(listOfWords: listOfWords,),
                                        ),
                                        ); 
                  } else {
                        ToastNotification(AppStrings.collectionIsEmptyWarning, context);
                  }
                },
                ),
            ],
          ),

             ValueListenableBuilder(
              valueListenable: udarenia_box.listenable(),
              builder: (context,Box _someBox,_){
                return  Padding(
                         padding: const EdgeInsets.symmetric(vertical: 3),
                         child: Center(
                            child: MyText(text: AppStrings.CollectionAmountOfWordsFP
                             + udarenia_box.get(widget.index).words.length.toString()
                              + AppStrings.CollectionAmountOfWordsSP, size: Dimensions.baseOfWordsWordsAmountFS,
                               color: AppColors.grayTextColor),
                                       ),
                       );
              }
             ),

             udarenia_box.get(widget.index).words.length == 0 ? 
                     Expanded(
                       child: Container(
                         child: Column(
                           mainAxisSize: MainAxisSize.max,
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                               Image.asset(
                              'lib/assets/icons/collection_is_empty_icon.png',
                              width: Dimensions.collectionIsEmptyIconSize,
                              color: AppColors.collectionIsEmptyIconColor,
                             ),
                              SizedBox(height: Dimensions.SBHeight20,),
                              MyText(text: AppStrings.collectionIsEmptyText,
                                     textAlign: TextAlign.center,
                                     size: Dimensions.collectionIsEmptyTextFontSize,
                                     color: AppColors.collectionIsEmptyTextColor,
                                     ),
                              SizedBox(height: Dimensions.SBHeight120),
                           ],
                         ),
                       ),
                     ) :
                Expanded(
                child: ValueListenableBuilder(
                valueListenable: udarenia_box.listenable(),
                builder: (context,Box _someBox,_){
                  return ScrollConfiguration(
                    behavior: MyBehavior(),
                    child: ListView.builder(
                      physics: AlwaysScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: udarenia_box.get(widget.index).words.length,
                      itemBuilder: (BuildContext context, int i){
                        udarenia_box.get(widget.index).words.sort((a,b) => a.toList()[1].toString().compareTo(b.toList()[1].toString()));
                        if(word.isEmpty){
                        return Slidable(
                          endActionPane: ActionPane(
                            extentRatio: 0.2,
                            motion: StretchMotion(),
                            children: [
                              SlidableAction(
                              onPressed: ((context) {
                                setState(() {
                                all_added_udarenia.get(0).words[udarenia_box.get(widget.index).words[i][0]]--;
                                if(all_added_udarenia.get(0).words[udarenia_box.get(widget.index).words[i][0]] <= 0){
                                all_added_udarenia.get(0).words.remove(udarenia_box.get(widget.index).words[i][0]);
                                all_added_udarenia.get(0).wordsVariants.remove(udarenia_box.get(widget.index).words[i][0]);
                                all_added_udarenia.get(0).wordsAnswers.remove(udarenia_box.get(widget.index).words[i][0]);
                                all_added_udarenia.get(0).wordsWords.remove(udarenia_box.get(widget.index).words[i][0]);
                                }
                                udarenia_box.get(widget.index).words.removeAt(i);
                                all_added_udarenia.get(0).save();
                                udarenia_box.get(widget.index).save();
                                });
                              }),
                              backgroundColor: AppColors.deleteFromCollectionButtonBackgroundColor,
                              foregroundColor: AppColors.textColor,
                              icon: Icons.delete,
                            ),
                            ],
                          ),
                          child: Container(                
                                              child: MyCard(
                                                            text: udarenia_box.get(widget.index).words[i][2],
                                                            textFontSize: Dimensions.wordCardFS,
                                                            side: BorderSide(color: AppColors.cardWidgetCommonBorderColor, width: 2,),
                                                            borderRadius: Dimensions.WordCardBR,
                                                            backgroundColor: AppColors.cardWidgetBackgroundColor,
                                                            verticalMargin: Dimensions.WordCardVerticalMargin,
                                                            horizontalMargin: Dimensions.WordCardHorizontalMargin,
                                                            trailing: udarenia_box.get(widget.index).words[i][4] ?
                                                            WordCardButton(id: udarenia_box.get(widget.index).words[i][0], chapter: 'udareniya') :
                                                            Icon(Icons.abc, size: 0),
                                                           ),          
                                            ),
                        );
                        }else if( _someBox.get(widget.index).words[i][1].toString().toLowerCase().startsWith(word.toLowerCase())){ 
                         searchItemsChecker = false;
                         return Slidable(
                            endActionPane: ActionPane(
                            extentRatio: 0.2,
                            motion: StretchMotion(),
                            children: [
                              SlidableAction(
                              onPressed: ((context) {
                                setState(() {
                                all_added_udarenia.get(0).words[udarenia_box.get(widget.index).words[i][0]]--;
                                if(all_added_udarenia.get(0).words[udarenia_box.get(widget.index).words[i][0]] <= 0){
                                all_added_udarenia.get(0).words.remove(udarenia_box.get(widget.index).words[i][0]);
                                all_added_udarenia.get(0).wordsVariants.remove(udarenia_box.get(widget.index).words[i][0]);
                                all_added_udarenia.get(0).wordsAnswers.remove(udarenia_box.get(widget.index).words[i][0]);
                                all_added_udarenia.get(0).wordsWords.remove(udarenia_box.get(widget.index).words[i][0]);
                                }
                                udarenia_box.get(widget.index).words.removeAt(i);
                                all_added_udarenia.get(0).save();
                                udarenia_box.get(widget.index).save();
                                });
                              }),
                              backgroundColor: AppColors.deleteFromCollectionButtonBackgroundColor,
                              foregroundColor: AppColors.textColor,
                              icon: Icons.delete,
                            ),
                            ],
                          ),
                          child: Container(                
                                              child: MyCard(
                                                            text: udarenia_box.get(widget.index).words[i][2],
                                                            textFontSize: Dimensions.wordCardFS,
                                                            side: BorderSide(color: AppColors.cardWidgetCommonBorderColor, width: 2,),
                                                            borderRadius: Dimensions.WordCardBR,
                                                            backgroundColor: AppColors.cardWidgetBackgroundColor,
                                                            verticalMargin: Dimensions.WordCardVerticalMargin,
                                                            horizontalMargin: Dimensions.WordCardHorizontalMargin,
                                                            trailing: udarenia_box.get(widget.index).words[i][4] ?
                                                            WordCardButton(id: udarenia_box.get(widget.index).words[i][0], chapter: 'udareniya') :
                                                            Icon(Icons.abc, size: 0),
                                                           ),          
                                            ),
                        );
                        }else{
                          if(i == udarenia_box.get(widget.index).words.length - 1 && searchItemsChecker==true){
                                                            return Container(
                                                              child: Center(
                                                                child: NotFound(),
                                                           ),
                                                            ); 
                                                            } else{
                                                              return Container();
                                                            }       
                        }
                      }
                      ),
                  );
                }
              ),
           ),
           

           Align(
            alignment: Alignment.bottomCenter,
             child: Container(                   
                           width: Dimensions.screenWidth,
                           color: AppColors.backgroundColor,
                           child: Padding(
                           padding: EdgeInsets.only(bottom: Dimensions.addWordsManuallyButtonMarginBottom,
                           top:0,
                           left: Dimensions.addWordsManuallyButtonMarginHorizontal,
                           right: Dimensions.addWordsManuallyButtonMarginHorizontal),
                           child: ElevatedButton(
                           child: Padding(
                                    padding:EdgeInsets.symmetric(vertical: Dimensions.screenHeight*10/926),
                                    child: MyText(text: AppStrings.collectionPageButtonTitle, size: Dimensions.buttonFontSize),
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
                 addWordsDialog(); 
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