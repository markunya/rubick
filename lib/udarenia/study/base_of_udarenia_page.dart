import 'dart:math';
import 'package:flutter/material.dart';
import 'package:rubickk/consts.dart';
import 'package:rubickk/main.dart';
import 'package:rubickk/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rubickk/bigwidgets/appbar_actions.dart';
import 'package:rubickk/dimensions.dart';
import '../../bigwidgets/word_card_button.dart';


class BaseOfUdarenia extends StatelessWidget {
  BaseOfUdarenia({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textColor),
          onPressed: (){
            Navigator.pop(context);
          }
        ),
        title: MyText(text: AppStrings.baseOfUdareniaAppBarTitle,
         size: Dimensions.appBarFontSize,
         weight: FontWeight.w700),
        actions: [ AppBarActions(),],
        
      ),
      body: BaseOfUdareniaBody(),
      );
  }
}

class BaseOfUdareniaBody extends StatefulWidget {
   
  const BaseOfUdareniaBody({Key? key}) : super(key: key); 

  @override
  State<BaseOfUdareniaBody> createState() => _BaseOfUdareniaBodyState();
}

class _BaseOfUdareniaBodyState extends State<BaseOfUdareniaBody> {
   bool searchItemsChecker = true;
   TextEditingController _controller = TextEditingController();
   String word = '';
   var wordsListOnSearh = [];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
          stream: FirebaseFirestore.instance.collection("udareniya").orderBy("word").snapshots(),
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
                                padding: EdgeInsets.only(
                                         left: Dimensions.searchMarginHorizontal,
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
                                             prefixIcon:  Icon(Icons.search,
                                                               size: Dimensions.baseOfWordsSearchIconSize,
                                                               color: AppColors.textFormFieldSearchIconColor),
                                             hintText: AppStrings.BaseOfWordsSearch,
                                             hintStyle: TextStyle(fontSize: Dimensions.TestSSInputHintFontSize,
                                             color: AppColors.textFormFieldHintColor),   
                                             focusedBorder: UnderlineInputBorder(
                                                           borderSide: BorderSide(color: AppColors.textFormFieldUnderlineColor),
                                                               ),          
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
                                                        bool isAddedChecker = all_added_udarenia.get(0).words.containsKey(snapshot.data!.docs[index].id);
                                                          if(word.isEmpty){
                                                          return Container(                
                                                            child:  MyCard(
                                                            text: snapshot.data!.docs[index].get('answer'),
                                                            textFontSize: Dimensions.wordCardFS,
                                                            side: isAddedChecker == true ?  BorderSide(color: AppColors.cardWidgetAddedBorderColor, width: 2,)
                                                                                         : BorderSide(color: AppColors.cardWidgetCommonBorderColor, width: 2, ),
                                                            borderRadius: Dimensions.WordCardBR,
                                                            backgroundColor: AppColors.cardWidgetBackgroundColor,
                                                            verticalMargin: Dimensions.WordCardVerticalMargin,
                                                            horizontalMargin: Dimensions.WordCardHorizontalMargin,
                                                            trailing: snapshot.data!.docs[index].get('def') != "" ? 
                                                                                      WordCardButton(id: snapshot.data!.docs[index].id, chapter: 'udareniya') :
                                                                                      Icon(Icons.abc, size: 0),
                                                           ),          
                                                          ); 
                                                          }else if( data['word'].toString().toLowerCase().startsWith(word.toLowerCase())){
                                                              searchItemsChecker= false;
                                                              return  Container(                
                                                                         child:MyCard(
                                                                                      text: snapshot.data!.docs[index].get('answer'),
                                                                                      textFontSize: Dimensions.wordCardFS,
                                                                                      side: isAddedChecker == true ?  BorderSide(color: AppColors.cardWidgetAddedBorderColor, width: 2,)
                                                                                                                  : BorderSide(color: AppColors.cardWidgetCommonBorderColor, width: 2, ),
                                                                                      borderRadius: Dimensions.WordCardBR,
                                                                                      backgroundColor: AppColors.cardWidgetBackgroundColor,
                                                                                      verticalMargin: Dimensions.WordCardVerticalMargin,
                                                                                      horizontalMargin: Dimensions.WordCardHorizontalMargin,
                                                                                      trailing: snapshot.data!.docs[index].get('def') != "" ? 
                                                                                                WordCardButton(id: snapshot.data!.docs[index].id, chapter: 'udareniya') :
                                                                                                Icon(Icons.abc, size: 0),
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
                   ],
                 ),
             );
                          
          },
    );
  }
}