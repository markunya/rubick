import 'package:flip_card/flip_card_controller.dart';
import 'package:rubickk/ads.dart';
import 'package:rubickk/bigwidgets/appbar_actions.dart';
import 'package:yandex_mobileads/mobile_ads.dart';
import '../../dimensions.dart';
import '../../hive_files/hive_collection.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import '../../main.dart';
import 'package:rubickk/consts.dart';
import 'package:rubickk/widgets.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'dart:math';
import 'package:flip_card/flip_card.dart';


class CardsModePage extends StatefulWidget {
  List listOfWords;
  CardsModePage({
    Key? key,
    required this.listOfWords}) : super(key: key);
  @override
  State<CardsModePage> createState() => _CardsModePageState(listOfWords: listOfWords);
}




final _random = new Random();
int randomIndex(int min, int max) => min + _random.nextInt(max - min);

class _CardsModePageState extends State<CardsModePage> {
  var adUnitId = AddUnitIds.studySS;
  var adRequest = const AdRequest();
  var isLoaded = false;
  InterstitialAd? interstitialAd;

  List listOfWords;
  _CardsModePageState({required this.listOfWords});
  int border = 0;
  bool isAlreadyDone = false;

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
    int index;
    String cardWord = listOfWords[border][0];
    String cardQuestion = listOfWords[border][1];
    GlobalKey<FlipCardState> keyOfCard = GlobalKey<FlipCardState>();
    return Scaffold(
      appBar: AppBar(
         leading: IconButton(
                            icon: Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textColor),
                            onPressed: (){
                                          Navigator.pop(context);
                                         }
                            ),
         title: MyText(
         text: AppStrings.cardsModeAppBarTitle,
         size: Dimensions.collectionPageABTitle,  
         ),
         actions: [
                AppBarActions(),
           ],
      ),
      body: !isAlreadyDone ? Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           Padding(
                    padding: EdgeInsets.all(Dimensions.TestSSLPIPadding),
                    child: LinearProgressIndicator(
                    value: border/listOfWords.length,
                    backgroundColor: AppColors.linearProgresIndicatorBacgroundColor,
                    color: AppColors.linearProgresIndicatorColor,
                    minHeight: Dimensions.TestSSLPIHeight,
                    ),
                  ),
          FlipCard(
            speed: 500,
            key: keyOfCard,
            front: Card(   
                       shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(Dimensions.WordCardBR),
                       ),
                       margin: EdgeInsets.symmetric(horizontal: Dimensions.cardHorizontalMargin,
                                                    vertical: Dimensions.cardVerticalMargin),
                       color: AppColors.frontOfCardColor,
                       child: Container(
                       width: Dimensions.cardModeCardWidth,
                       height: Dimensions.cardModeCardHeight,
                       child: Center(child: Padding(
                         padding: EdgeInsets.symmetric(horizontal: Dimensions.variantPadding),
                         child: MyText(text: cardQuestion, size: Dimensions.cardFontSize, fittedBox: true,),
                       ))),                        
                      ),
            back: Card(   
                       shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(Dimensions.WordCardBR),
                       ),
                       margin: EdgeInsets.symmetric(horizontal: Dimensions.cardHorizontalMargin,
                                                    vertical:Dimensions.cardVerticalMargin),
                       color: AppColors.backOfCardColor,
                       child: Container(
                       width: Dimensions.cardModeCardWidth,
                       height: Dimensions.cardModeCardHeight,
                       child: Center(child: Padding(
                         padding: EdgeInsets.symmetric(horizontal: Dimensions.variantPadding),
                         child: MyText(text: cardWord, size: Dimensions.cardFontSize, fittedBox: true,),
                       ))),                         
                      ),
          ),
          Row(children: [
              Container(
                width: Dimensions.cardModeButtonWidth,
                child: Padding(
                  padding: EdgeInsets.all(Dimensions.cardModeButtonPadding),
                  child: ElevatedButton( 
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: Dimensions.addCollectionAlertDialogButtonPadding),
                    child: MyText(text: AppStrings.cardsModeKnowButtonTitle, size: Dimensions.cardModeButtonsFontSizes),
                  ),
                  style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(AppColors.buttonBackgroundColor),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                   RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(Dimensions.addCollectionAlertDialogButtonBR),
                    ),
                  ),
                  ),
                   onPressed: () async {
                     border++;
                      if(border >= listOfWords.length){
                        border = 0;
                        if (!keyOfCard.currentState!.isFront) {
                                keyOfCard.currentState!.toggleCard();
                                }
                        await Future.delayed(Duration(milliseconds: 0));
                        if(isLoaded && Random().nextInt(Ads.adShowingPeriod) == 0) {
                                  await interstitialAd!.show();
                                  await interstitialAd!.waitForDismiss();
                                  isLoaded = false;
                                  }
                        setState(() {
                          isAlreadyDone = true;
                        });
                      }else{
                      if (!keyOfCard.currentState!.isFront) {
                                keyOfCard.currentState!.toggleCard();
                                }
                      await Future.delayed(Duration(milliseconds: 250), () {
                          setState((){
                            index = border+1 < listOfWords.length ? randomIndex(border+1, listOfWords.length) : border;
                            List remember = listOfWords[border];
                            listOfWords[border] = listOfWords[index];
                            listOfWords[index] = remember;
                            cardWord = listOfWords[border][0];
                            cardQuestion = listOfWords[border][1];
                      });
                      });    
                      }
                   }),
                )),
                Container(
                  width: Dimensions.screenWidth/2,
                  child: Padding(
                  padding: EdgeInsets.all(Dimensions.cardModeButtonPadding),
                  child: ElevatedButton(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: Dimensions.addCollectionAlertDialogButtonPadding),
                    child: MyText(text: AppStrings.cardsModeDidntKnowButtonTitle,
                     size: Dimensions.cardModeButtonsFontSizes,
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
                   onPressed: () async{
                     if (!keyOfCard.currentState!.isFront) {
                          keyOfCard.currentState!.toggleCard();
                    }
                     await Future.delayed(Duration(milliseconds: 250), () {
                     setState(() {
                      index = border+1 < listOfWords.length ? randomIndex(border+1, listOfWords.length) : border;
                      List remember = listOfWords[border];
                      listOfWords[border] = listOfWords[index];
                      listOfWords[index] = remember;
                      cardWord = listOfWords[border][0];
                      cardQuestion = listOfWords[border][1];
                      });
                     });
                   }),
                )),
          ],)
        ],
        ) : Container(
            width: Dimensions.screenWidth,
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'lib/assets/icons/well_done.png',
                 width: Dimensions.cardModeAlreadyDoneIconSize,
                 color: AppColors.textColor,
              ),
              SizedBox(height: Dimensions.SBHeight30),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.cardModeAlreadyDoneTitleHorizontalPadding,
                vertical: 0),
                child: Column(
                  children: [
                    MyText(text: AppStrings.cardsModeAlreadyDoneTitleFirstPart
                     + listOfWords.length.toString()
                     + AppStrings.cardsModeAlreadyDoneTitleSecondPart,
                     size: Dimensions.cardModePageAlreadyDoneTitleFontSize,
                     color: AppColors.textColor,
                     textAlign: TextAlign.center,),
                  ],
                ),
              ),
              SizedBox(height: Dimensions.SBHeight30),
              ElevatedButton(
                onPressed: (){
                listOfWords.shuffle();
                setState(() {
                  isAlreadyDone = false;
                });
              },
              child: Padding(
              padding: EdgeInsets.all(Dimensions.cardModeAlreadyDoneButtonPadding ),
              child: MyText(text: AppStrings.cardModeAlreadyDoneButtonText,
              size: Dimensions.cardModeAlreadyDoneButtonFS),
              ),
              style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(AppColors.buttonBackgroundColor),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Dimensions.cardModeAlreadyDoneButtonBR),
              ),
              ),
             ),
              ),
              SizedBox(height: Dimensions.SBHeight30),
            ],
            ),
        ),
    );
  }
}