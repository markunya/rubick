import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rubickk/ads.dart';
import 'package:rubickk/consts.dart';
import 'package:rubickk/main.dart';
import 'package:rubickk/pages/word_help_page.dart';
import 'package:rubickk/widgets.dart';
import 'package:rubickk/dimensions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import '../../bigwidgets/appbar_actions.dart';
import '../../bigwidgets/word_card_button.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

import 'package:yandex_mobileads/mobile_ads.dart';

class ResultCard{

  String? usersAnswer;
  String rightAnswer;
  bool hasDef;
  var borderColor;
  var backgroundColor;
  var icon;
  var id;
  
  ResultCard({required this.usersAnswer,
              required this.rightAnswer,
              required this.borderColor,
              required this.backgroundColor,
              required this.icon,
              required this.id,
              required this.hasDef,
              });
}




class TestSSPage extends StatefulWidget {
  int value;
  Set idsOfTestWords;
  Set idsOfTestWordsThatHaveDefs;
  TestSSPage({Key? key,
    required this.value,
    required this.idsOfTestWords,
    required this.idsOfTestWordsThatHaveDefs}) : super(key: key);

  @override
  State<TestSSPage> createState() => _TestSSPageState(value: value,
    idsOfTestWords: idsOfTestWords,
    idsOfTestWordsThatHaveDefs: idsOfTestWordsThatHaveDefs,
    );
}

class _TestSSPageState extends State<TestSSPage> {
    var adUnitId = AddUnitIds.testSS;
    var adRequest = const AdRequest();
    var isLoaded = false;
    InterstitialAd? interstitialAd;

    int value;
    Set idsOfTestWords;
    Set idsOfTestWordsThatHaveDefs;
    _TestSSPageState({required this.value,
      required this.idsOfTestWords,
      required this.idsOfTestWordsThatHaveDefs,
    });
  
  int shuffledIndexesLength = 0;
  int _index=0;
  int _counter=0;
  bool _pageTestSS = true; 
  var resultCardsList = [];
  var shuffledIndexes = [];
  List shuffledVariants = [0,1];
  List allAddedWords = [];

    Future<InterstitialAd> _createInterstitialAd() {
      return InterstitialAd.create(
        adUnitId: adUnitId,
        onAdLoaded: () {
        
        },
        onAdFailedToLoad: (error) {
          
        },
      );
    }
    
    Future<void> _loadInterstitialAd() async {
      interstitialAd = await _createInterstitialAd();
      await interstitialAd!.load(adRequest: adRequest);
      isLoaded = true;
    }
   

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _loadInterstitialAd();
  }

  @override
  Widget build(BuildContext context) {
    shuffledVariants.shuffle();
    

    
    

    return Scaffold(
      appBar: AppBar(
      backgroundColor: AppColors.appBarBackgroudColor,
      leading: IconButton(
            onPressed: () {
            _index=0;
            _counter=0;
            resultCardsList.clear();
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textColor),
        ),
        title: MyText(text: AppStrings.TestSSAppBarTitle,
        size: Dimensions.appBarFontSize,
        weight: FontWeight.w700,
        fittedBox: true
        ),
        actions: [AppBarActions(),],      
          ),
        body: StreamBuilder<Object>(
        stream: FirebaseFirestore.instance.collection("slovarnie_slova").orderBy("word").snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
            if(!snapshot.hasData || (snapshot.data!.docs.length == 0 && bools_in_bases.get(0).baseOfSlovarnieSlovaIsAdded)){
              return Center(
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(AppColors.circularProgressIndicatorColor
                    ),
                    ),
            );
            }
            
            if(bools_in_bases.get(0).baseOfSlovarnieSlovaIsAdded == false && allAddedWords.isEmpty){
              List idsOfTestWordsList = idsOfTestWords.toList();
              for(int i = 0; i < idsOfTestWordsList.length; i++){
                  allAddedWords.add([all_added.get(0).wordsAnswers[idsOfTestWordsList[i]],
                                    all_added.get(0).wordsMistakes[idsOfTestWordsList[i]],
                                    idsOfTestWordsList[i]]);
                }
              }
              
              if(bools_in_bases.get(0).baseOfSlovarnieSlovaIsAdded == true && shuffledIndexesLength == 0){
                shuffledIndexesLength = snapshot.data!.docs.length;
              }else{
                shuffledIndexesLength =  allAddedWords.length;
              }

              if(shuffledIndexes.isEmpty){
                  for(int i=0; i < shuffledIndexesLength;i++){
                  shuffledIndexes.add(i);
                }
                shuffledIndexes.shuffle();
              }
              return _pageTestSS == true ? Center(
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.all(Dimensions.TestSSLPIPadding),
                    child: LinearProgressIndicator(
                      value: _index/value,
                      backgroundColor: AppColors.linearProgresIndicatorBacgroundColor,
                      color: AppColors.linearProgresIndicatorColor,
                      minHeight: Dimensions.TestSSLPIHeight,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.TestSSInputPadding),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: Dimensions.variantBottomMargin),
                              width: Dimensions.variantWidth,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(AppColors.collectionButtonBackgroundColor),
                                side: MaterialStateProperty.all<BorderSide>(BorderSide(color: AppColors.collectionButtonBorderColor, width: 2,)),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(       
                                    Radius.circular(Dimensions.variantBorderRadius),
                                    ),
                                )
                                )
                                 ) ,
                                onPressed: shuffledVariants[0] == 0 ? () {
                                   Future.delayed(Duration(milliseconds: _index == value - 1 ? 0 : 200), () async {
                                      _counter++;
                                  resultCardsList.add(ResultCard(id: bools_in_bases.get(0).baseOfSlovarnieSlovaIsAdded == true ? snapshot.data?.docs[shuffledIndexes[_index]].id : allAddedWords[shuffledIndexes[_index]][2],
                                  borderColor: AppColors.rightAnswerBorderColor, icon: Icons.check ,
                                  backgroundColor: AppColors.rightAnswerBackgroundColor,
                                  hasDef: bools_in_bases.get(0).baseOfSlovarnieSlovaIsAdded == true ? snapshot.data?.docs[shuffledIndexes[_index]].get('def') != "" : idsOfTestWordsThatHaveDefs.contains(allAddedWords[shuffledIndexes[_index]][2]),
                                  usersAnswer: null,
                                  rightAnswer: bools_in_bases.get(0).baseOfSlovarnieSlovaIsAdded == true ?  snapshot.data!.docs[shuffledIndexes[_index]].get('word') : allAddedWords[shuffledIndexes[_index]][0],));
                                  if(_index == value - 1) {
                                  if(isLoaded && Random().nextInt(Ads.adShowingPeriod) == 0) {
                                  await interstitialAd!.show();
                                  await interstitialAd!.waitForDismiss();
                                  }
                                  shuffledIndexes.clear();                         
                                  _index=0; 
                                  setState(() {
                                  _pageTestSS = false;
                                });

                                }else{
                                  setState(() {
                                    shuffledVariants.shuffle();
                                  _index++;
                                  });

                                }
                                   });
                                   
                                 } :(){
                                    Future.delayed(Duration(milliseconds: _index == value - 1 ? 0 : 200), () async {
                                    resultCardsList.insert(0, ResultCard( id: bools_in_bases.get(0).baseOfSlovarnieSlovaIsAdded == true ? snapshot.data?.docs[shuffledIndexes[_index]].id : allAddedWords[shuffledIndexes[_index]][2],
                                 borderColor: AppColors.wrongAnswerBorderColor,
                                 backgroundColor: AppColors.wrongAnswerBackgroundColor,
                                 icon: Icons.clear_rounded ,
                                 hasDef: bools_in_bases.get(0).baseOfSlovarnieSlovaIsAdded == true ? snapshot.data?.docs[shuffledIndexes[_index]].get('def') != "" : idsOfTestWordsThatHaveDefs.contains(allAddedWords[shuffledIndexes[_index]][2]),
                                 usersAnswer: bools_in_bases.get(0).baseOfSlovarnieSlovaIsAdded == true ? 
                                 snapshot.data!.docs[shuffledIndexes[_index]].get('mistake') :
                                 allAddedWords[shuffledIndexes[_index]][1],
                                 rightAnswer: bools_in_bases.get(0).baseOfSlovarnieSlovaIsAdded == true ?  snapshot.data!.docs[shuffledIndexes[_index]].get('word') : allAddedWords[shuffledIndexes[_index]][0],));
                                 if(_index == value - 1){
                                  if(isLoaded && Random().nextInt(Ads.adShowingPeriod) == 0) {
                                  await interstitialAd!.show();
                                  await interstitialAd!.waitForDismiss();
                                  }
                                  shuffledIndexes.clear();                        
                                  _index=0; 
                                  setState(() {
                                  _pageTestSS = false;
                                });

                                }else{
                                  setState(() {
                                        shuffledVariants.shuffle();
                                        _index++;
                                    }); 
                                }
                                });
                                 },
                                 child: Padding(
                                   padding: EdgeInsets.all(Dimensions.variantPadding),
                                   child: MyText(fittedBox: true, size: Dimensions.variantTextFontSize,
                                   text: shuffledVariants[0] == 0 ? (bools_in_bases.get(0).baseOfSlovarnieSlovaIsAdded == true ? 
                                   snapshot.data!.docs[shuffledIndexes[_index]].get('word') :
                                   allAddedWords[shuffledIndexes[_index]][0]) : 
                                   (bools_in_bases.get(0).baseOfSlovarnieSlovaIsAdded == true ? 
                                    snapshot.data!.docs[shuffledIndexes[_index]].get('mistake'):
                                    allAddedWords[shuffledIndexes[_index]][1])
                                   ),
                                 ),
                                 ),
                            ),

                            Container(
                              margin: EdgeInsets.only(bottom:  Dimensions.variantBottomMargin),
                              width: Dimensions.variantWidth,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(AppColors.collectionButtonBackgroundColor),
                                side: MaterialStateProperty.all<BorderSide>(BorderSide(color: AppColors.collectionButtonBorderColor, width: 2,)),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(       
                                    Radius.circular(Dimensions.variantBorderRadius),
                                    ),
                                )
                                )
                                 ) ,
                                onPressed:  shuffledVariants[0] == 0 ? (){
                                 Future.delayed(Duration(milliseconds: _index == value - 1 ? 0 : 200), () async {
                                    resultCardsList.insert(0, ResultCard( id: bools_in_bases.get(0).baseOfSlovarnieSlovaIsAdded == true ? snapshot.data?.docs[shuffledIndexes[_index]].id : allAddedWords[shuffledIndexes[_index]][2],
                                 borderColor: AppColors.wrongAnswerBorderColor,
                                 backgroundColor: AppColors.wrongAnswerBackgroundColor,
                                 icon: Icons.clear_rounded ,
                                 hasDef: bools_in_bases.get(0).baseOfSlovarnieSlovaIsAdded == true ? snapshot.data?.docs[shuffledIndexes[_index]].get('def') != "" : idsOfTestWordsThatHaveDefs.contains(allAddedWords[shuffledIndexes[_index]][2]),
                                 usersAnswer: bools_in_bases.get(0).baseOfSlovarnieSlovaIsAdded == true ? 
                                 snapshot.data!.docs[shuffledIndexes[_index]].get('mistake') :
                                 allAddedWords[shuffledIndexes[_index]][1],
                                 rightAnswer: bools_in_bases.get(0).baseOfSlovarnieSlovaIsAdded == true ?  snapshot.data!.docs[shuffledIndexes[_index]].get('word') : allAddedWords[shuffledIndexes[_index]][0],));
                                 if(_index == value - 1){
                                  if(isLoaded && Random().nextInt(Ads.adShowingPeriod) == 0) {
                                  await interstitialAd!.show();
                                  await interstitialAd!.waitForDismiss();
                                  }
                                  shuffledIndexes.clear();                        
                                  _index=0; 
                                  setState(() {
                                  _pageTestSS = false;
                                });

                                }else{
                                  setState(() {
                                         shuffledVariants.shuffle();
                                        _index++;
                                    }); 
                                }
                                });
                                } : (){
                                   Future.delayed(Duration(milliseconds: _index == value - 1 ? 0 : 200), () async {
                                    _counter++;
                                   resultCardsList.add(ResultCard(id: bools_in_bases.get(0).baseOfSlovarnieSlovaIsAdded == true ? snapshot.data?.docs[shuffledIndexes[_index]].id : allAddedWords[shuffledIndexes[_index]][2],
                                   borderColor: AppColors.rightAnswerBorderColor, icon: Icons.check ,
                                   backgroundColor: AppColors.rightAnswerBackgroundColor,
                                   hasDef: bools_in_bases.get(0).baseOfSlovarnieSlovaIsAdded == true ? snapshot.data?.docs[shuffledIndexes[_index]].get('def') != "" : idsOfTestWordsThatHaveDefs.contains(allAddedWords[shuffledIndexes[_index]][2]),
                                   usersAnswer: null,
                                   rightAnswer: bools_in_bases.get(0).baseOfSlovarnieSlovaIsAdded == true ?  snapshot.data!.docs[shuffledIndexes[_index]].get('word') : allAddedWords[shuffledIndexes[_index]][0],));
                                 if(_index == value - 1){
                                  if(isLoaded && Random().nextInt(Ads.adShowingPeriod) == 0) {
                                  await interstitialAd!.show();
                                  await interstitialAd!.waitForDismiss();
                                  }
                                  shuffledIndexes.clear();                         
                                  _index=0; 
                                  setState(() {
                                  _pageTestSS = false;
                                });
                                }else{
                                  setState(() {
                                   shuffledVariants.shuffle();
                                  _index++;
                                  }); 
                                }
                                   });
                                },
                                child: Padding(
                                    padding: EdgeInsets.all(Dimensions.variantPadding),
                                    child: MyText(fittedBox: true, size: Dimensions.variantTextFontSize, text: shuffledVariants[0] == 0 ? (bools_in_bases.get(0).baseOfSlovarnieSlovaIsAdded == true ? 
                                    snapshot.data!.docs[shuffledIndexes[_index]].get('mistake'):
                                    allAddedWords[shuffledIndexes[_index]][1]) : (bools_in_bases.get(0).baseOfSlovarnieSlovaIsAdded == true ? 
                                   snapshot.data!.docs[shuffledIndexes[_index]].get('word') :
                                   allAddedWords[shuffledIndexes[_index]][0])
                                    ),
                                ),
                                ),
                            ),
                          ]
                          ),
                      ),
                   SizedBox(height: Dimensions.SBHeight30),
                    ],  
                  ),
                  SizedBox(height:Dimensions.SBHeight20),
                ],
              ),
             ) : Stack(
                  alignment: Alignment.topCenter,
                  children: [  
                      ScrollConfiguration(
                        behavior: MyBehavior(),
                        child: SingleChildScrollView(
                             physics: ScrollPhysics(),
                             child: Column(
                            children: <Widget>[
                             SizedBox(height:Dimensions.screenHeight/3),
                                 ListView.builder(
                                     itemCount: resultCardsList.length,
                                     physics: NeverScrollableScrollPhysics(),
                                     shrinkWrap: true,
                                      itemBuilder: (context, i){
                                     return  Card(   
                                       shape: RoundedRectangleBorder(
                                       side: BorderSide(color: resultCardsList[i].borderColor, width: 2,),
                                       borderRadius: BorderRadius.circular(Dimensions.WordCardBR),
                                       ),
                                       margin: EdgeInsets.symmetric(horizontal: Dimensions.WordCardHorizontalMargin, vertical:Dimensions.WordCardVerticalMargin),
                                       color: resultCardsList[i].backgroundColor,
                                       child:  ListTile(
                                                leading: Icon(resultCardsList[i].icon, size: Dimensions.WordCardLeadingIconSize, color: AppColors.textColor,),
                                                trailing: resultCardsList[i].hasDef ? WordCardButton(id: resultCardsList[i].id, chapter: 'slovarnie_slova',) : Icon(Icons.abc,size: 0),
                                                title: MyText(text: resultCardsList[i].rightAnswer, size: Dimensions.wordCardFS),
                                                subtitle:  resultCardsList[i].usersAnswer == null ? null : MyText(text: AppStrings.ResultPageANE +  resultCardsList[i].usersAnswer, size: Dimensions.WordCardSubTitleFontSize),                           
                                   ),


                               );
                            } ,
                         ),
                                ],
                             ),
                                   ),
                      ),


                        Container( 
                        height: Dimensions.screenHeight/3,
                        width: Dimensions.screenWidth,
                        decoration: BoxDecoration(
                          boxShadow: [
                                  BoxShadow(
                                  color: AppColors.shadow.withOpacity(0.3),
                                  blurRadius: Dimensions.ResultPageContainerShadowBlurRadius,
                                  spreadRadius: Dimensions.ResultPageContainerShadowSpreadRadius,
                                  offset: Offset(0, 5.0,),
                                    )
                                   ],
                          color: AppColors.containerInResultPageBackgroundColor,
                          borderRadius: BorderRadius.only(
                             bottomRight: Radius.circular(Dimensions.ResultPageContainerBR),
                             bottomLeft:Radius.circular(Dimensions.ResultPageContainerBR),
                          ),
                        ),

                        child: Center(
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Container(
                                    height: Dimensions.ResultPageContainerSize,
                                    width: Dimensions.ResultPageContainerSize,
                                    child: Stack(
                                      fit: StackFit.expand,
                                      alignment: AlignmentDirectional.center,
                                      children: [
                                        TweenAnimationBuilder<double>(
                                          tween: Tween(begin: 0, end: _counter/value),
                                         duration: Duration(seconds: AppTimes.resultPageCPIAnimationTime),
                                        builder: (context, double val ,_)=> CircularProgressIndicator(
                                          strokeWidth: Dimensions.ResultPageCPIStrokeWidth,
                                          color: AppColors.circularProgressIndicatorInResultPageColor,
                                          backgroundColor: AppColors.circularProgressIndicatorInResultPageBackgroundColor,
                                          value: val,
                                        ),
                                    ),
                                        Center(child: MyText(text: (_counter/value*100).round().toString() + '%',
                                         size: Dimensions.ResultPageContainerResultFontSize ))
                                      ],
                                    ),
                                    ),
                                ),
                                SizedBox(height: Dimensions.SBHeight20),
                                MyText(text: AppStrings.ResultPageContainerSubtitile1
                                 + _counter.toString() + AppStrings.ResultPageContainerSubtitile2
                                  + value.toString() + AppStrings.ResultPageContainerSubtitile3,
                                 size: Dimensions.ResultPageContainerSubtitleFontSize,
                                  color: AppColors.grayTextColor,
                                   textAlign: TextAlign.center,),
                              ],
                            ),
                          ),
                        ),
                        ),
                        //  Center(child: MyText(text: "Ваш результат: " + (_counter/value*100).round().toString() + '%', size: 30,),)
                  ],              
             );


           },
         ),

    );
  }
}