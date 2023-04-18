import 'dart:math';
import 'package:flutter/material.dart';
import 'package:rubickk/consts.dart';
import 'package:rubickk/main.dart';
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
import 'add_words_manually_page_2.dart';

class MapsInAWMP1{
  static Map<String, bool?> selectedWordsChecker = {};
  static Map<String, String> selectedWordsWords = {};
  static Map<String, String> selectedWordsQuestions = {};
  static Map<String, String> selectedWordsMistakes = {};
  static Set<String> selectedWordsHasDefs = {};
  static int counterOfSelectedWords = 0;
}

  contain_1(a,word){
  for(int i = 0; i < a.length; i++){
    if(a[i][2] == word){
      return true;
    }
  }
  return false;
}

class AddWordsManuallyPage extends StatelessWidget {
  int indexOfCollection;
  AddWordsManuallyPage({
    Key? key,
    required this.indexOfCollection,
    }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textColor),
          onPressed: (){
            MapsInAWMP1.selectedWordsChecker.clear();
            MapsInAWMP1.selectedWordsWords.clear();
            MapsInAWMP1.selectedWordsQuestions.clear();
            MapsInAWMP1.selectedWordsMistakes.clear();
            MapsInAWMP1.selectedWordsHasDefs.clear();
            MapsInAWMP1.counterOfSelectedWords = 0;
            Navigator.pop(context);
          }
        ),
        title: MyText(text: AppStrings.AddWordsManuallyPageTitle, size: Dimensions.appBarFontSize, weight: FontWeight.w700, fittedBox: true,),
        actions: [ AppBarActions(),],
        
      ),
      body: AddWordsManuallyPageBody(indexOfCollection: indexOfCollection),
      );
  }
}

class AddWordCheckBox extends StatefulWidget {
  String id;
  String word;
  String question;
  String mistake;
  bool hasDef;
  int indexOfCollection;
  AddWordCheckBox({
    Key? key,
    required this.id,
    required this.word,
    required this.question,
    required this.mistake,
    required this.indexOfCollection,
    required this.hasDef,
    }) : super(key: key);

  @override
  State<AddWordCheckBox> createState() => _AddWordCheckBoxState(id:id,
                                          question: question,
                                          mistake: mistake,
                                          word: word,
                                          indexOfCollection: indexOfCollection,
                                          hasDef: hasDef,
                                          );
}

class _AddWordCheckBoxState extends State<AddWordCheckBox> {
  String id;
  String word;
  String question;
  String mistake;
  bool hasDef;
  int indexOfCollection;
  _AddWordCheckBoxState({
    required this.id,
    required this.word,
    required this.question,
    required this.mistake,
    required this.indexOfCollection,
    required this.hasDef,
    });
  late bool? isInThisCollection = contain_1(slovarnie_slova_box.get(indexOfCollection).words, id) ? null : false;
  late bool isChecked = isInThisCollection == null ? true :
  (MapsInAWMP1.selectedWordsChecker.containsKey(id) ? MapsInAWMP1.selectedWordsChecker[id]! : false);
  @override
  Widget build(BuildContext context, ) {
    MapsInAWMP1.selectedWordsWords[id] = word;
    MapsInAWMP1.selectedWordsQuestions[id] = question;
    MapsInAWMP1.selectedWordsMistakes[id] = mistake;
    if (hasDef) {
      MapsInAWMP1.selectedWordsHasDefs.add(id);
    }
    if(MapsInAWMP1.selectedWordsChecker.containsKey(id) == false){
      MapsInAWMP1.selectedWordsChecker[id] = (isInThisCollection == null ? null : false);
    }
    return Transform.scale(
      scale: 1.3,
      child: Checkbox(
        checkColor: isInThisCollection == false ? AppColors.textColor : AppColors.alreadyAddedCheckBoxColor,
        side: MaterialStateBorderSide.resolveWith(
        (states) => BorderSide(width: 1, color: isInThisCollection == false ? AppColors.textColor : AppColors.alreadyAddedCheckBoxColor),),
        activeColor: AppColors.checkBoxActiveColor,
        value: isChecked,
        shape: CircleBorder(),
        onChanged: (bool? value) {
          setState(() {
            isChecked = (isInThisCollection == null ? true : !isChecked);
            MapsInAWMP1.selectedWordsChecker[id] = isInThisCollection == null ? null : isChecked;
            if(isInThisCollection != null){
              MapsInAWMP1.counterOfSelectedWords += isChecked == true ? 1 : -1; 
            }
          });
        },
      ),
    );
  }
}

class AddWordsManuallyPageBody extends StatefulWidget {
  int indexOfCollection;
   AddWordsManuallyPageBody(
    {Key? key,
    required this.indexOfCollection,
    }) : super(key: key); 

  @override
  State<AddWordsManuallyPageBody> createState() => _AddWordsManuallyPageBody(indexOfCollection: indexOfCollection);
}

class _AddWordsManuallyPageBody extends State<AddWordsManuallyPageBody> {
  int indexOfCollection;

  _AddWordsManuallyPageBody({
    required this.indexOfCollection,
  });
   bool searchItemsChecker = true;
   TextEditingController _controller = TextEditingController();
   String word = '';
   var wordsListOnSearh = [];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
          stream: FirebaseFirestore.instance.collection("slovarnie_slova").orderBy("word").snapshots(),
          builder:(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if(!snapshot.hasData || snapshot.data?.docs.length == 0) return Center(
                child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(AppColors.circularProgressIndicatorColor),),
              );
             int amountOfWords = snapshot.data?.docs.length as int;

             return Container(
              height: Dimensions.screenHeight,
               width: Dimensions.screenWidth,

                 child: Column(
                   children: [
                       Container(
                                child: Padding(
                                padding: EdgeInsets.only(left: Dimensions.searchMarginHorizontal,
                                                         right: Dimensions.searchMarginHorizontal,
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
                                             prefixIcon:  Icon(Icons.search, size: Dimensions.baseOfWordsSearchIconSize, color: AppColors.grayTextColor),
                                             hintText: AppStrings.BaseOfWordsSearch,
                                             hintStyle: TextStyle(fontSize: Dimensions.TestSSInputHintFontSize, color: AppColors.textFormFieldHintColor),           
                                           ),
                                          ),
                                    ),
                                  ),
                     Padding(
                       padding: const EdgeInsets.symmetric(vertical: 3),
                       child: Center(
                                  child: MyText(text: AppStrings.BaseOfWordsAmountOfWordsFP + amountOfWords.toString() + AppStrings.BaseOfWordsAmountOfWordsSP,
                                   size: Dimensions.baseOfWordsWordsAmountFS,
                                    color: AppColors.grayTextColor),
                                     ),
                     ),              
                     Expanded(
                       child: ScrollConfiguration(
                        behavior: MyBehavior(),
                         child: SingleChildScrollView(
                          physics: AlwaysScrollableScrollPhysics(),
                           child: Container(
                             child: Column(
                                           children: [
                                             ScrollConfiguration(
                                              behavior: MyBehavior(),
                                               child: ListView.builder(
                                                      physics: NeverScrollableScrollPhysics(),
                                                      shrinkWrap: true,
                                                      scrollDirection: Axis.vertical,
                                                      itemCount: amountOfWords,
                                                      itemBuilder: (BuildContext context, int index){                               
                                                        var data = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                                                        bool isAddedChecker = all_added.get(0).words.containsKey(snapshot.data!.docs[index].id);
                                                          if(word.isEmpty){
                                                          return Container(                
                                                            child: MyCard(
                                                            text: snapshot.data!.docs[index].get('word'),
                                                            textFontSize: Dimensions.wordCardFS,
                                                            side: isAddedChecker == true ?  BorderSide(color: AppColors.cardWidgetAddedBorderColor, width: 2, )
                                                                                          : BorderSide(color: AppColors.cardWidgetCommonBorderColor, width: 2, ),
                                                            borderRadius: Dimensions.WordCardBR,
                                                            backgroundColor: AppColors.cardWidgetBackgroundColor,
                                                            verticalMargin: Dimensions.WordCardVerticalMargin,
                                                            horizontalMargin: Dimensions.WordCardHorizontalMargin,
                                                            trailing: AddWordCheckBox(
                                                                               id: snapshot.data!.docs[index].id,
                                                                               word: snapshot.data!.docs[index].get('word'),
                                                                               question: snapshot.data!.docs[index].get('question'),
                                                                               mistake: snapshot.data!.docs[index].get('mistake'), 
                                                                               hasDef: snapshot.data!.docs[index].get('def') != "",
                                                                               indexOfCollection: indexOfCollection,), 
                                                           ),
                                                          ); 
                                                          }else if( data['word'].toString().toLowerCase().startsWith(word.toLowerCase())){
                                                              searchItemsChecker= false;
                                                              return  Container(                
                                                            child: MyCard(
                                                            text: snapshot.data!.docs[index].get('word'),
                                                            textFontSize: Dimensions.wordCardFS,
                                                            side: isAddedChecker == true ?  BorderSide(color: AppColors.cardWidgetAddedBorderColor, width: 2, )
                                                                    : BorderSide(color: AppColors.cardWidgetCommonBorderColor, width: 2, ),
                                                            borderRadius: Dimensions.WordCardBR,
                                                            backgroundColor: AppColors.cardWidgetBackgroundColor,
                                                            verticalMargin: Dimensions.WordCardVerticalMargin,
                                                            horizontalMargin: Dimensions.WordCardHorizontalMargin,
                                                            trailing: AddWordCheckBox(
                                                                               id: snapshot.data!.docs[index].id,
                                                                               word: snapshot.data!.docs[index].get('word'),
                                                                               question: snapshot.data!.docs[index].get('question'), 
                                                                               mistake: snapshot.data!.docs[index].get('mistake'),
                                                                               hasDef: snapshot.data!.docs[index].get('def') != "",
                                                                               indexOfCollection: indexOfCollection,), 
                                                           ),
                                                          );
                                                           }else{  
                                                            if(index == snapshot.data!.docs.length - 1 && searchItemsChecker==true){
                                                            return Container(
                                                              child: Center(
                                                                child: NotFound(),
                                                           ),
                                                            ); 
                                                            } else{
                                                              return Container();
                                                            }                              
                                                           } 
                                                       },
                                                       ),
                                             ),
                                     ],
                                   ),
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
                                    child: MyText(text: AppStrings.addWordsManuallyPage1ButtonTitle, size: Dimensions.buttonFontSize),
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
                 if(MapsInAWMP1.counterOfSelectedWords!=0){
                    Navigator.push(
                           context,
                           MaterialPageRoute(builder: (context) => checkChosedWordsPage(selectedWordsChecker: MapsInAWMP1.selectedWordsChecker,
                                                                                        selectedWordsWords: MapsInAWMP1.selectedWordsWords,
                                                                                        selectedWordsQuestions: MapsInAWMP1.selectedWordsQuestions,
                                                                                        selectedWordsMistakes: MapsInAWMP1.selectedWordsMistakes,
                                                                                        selectedWordsHasDefs: MapsInAWMP1.selectedWordsHasDefs,
                                                                                        indexOfCollection: indexOfCollection,),
                          ),
                          );  
             }
              },
                            ),
                            ),
                         ),
           ),
                   ],
                 ),
             );
                          
          },
    );
  }
}