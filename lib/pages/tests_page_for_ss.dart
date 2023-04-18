import 'package:flutter/material.dart';
import 'package:rubickk/consts.dart';
import 'package:rubickk/main.dart';
import 'package:rubickk/slovarnie_slova/tests/test_slovarnie_slova_page.dart';
import '../dimensions.dart';
import '../udarenia/tests/test_udarenia.dart';
import '../widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';


class TestsPageForSS extends StatefulWidget {
  const TestsPageForSS({Key? key}) : super(key: key);

  @override
  State<TestsPageForSS> createState() => _TestsPageForSSState();
}

class _TestsPageForSSState extends State<TestsPageForSS> {
  double counterOfEnabledWordsSS = 0.0;
  late double _value = (bools_in_bases.get(0).baseOfSlovarnieSlovaIsAdded ? SliderConsts.defaultValue :
  (counterOfEnabledWordsSS > SliderConsts.maxValue ? SliderConsts.maxValue : counterOfEnabledWordsSS));
  @override
  Widget build(BuildContext context) {
    Set idsOfTestWordsSS = {};
    Set idsOfTestWordsThatHaveDefs = {};
    if(bools_in_bases.get(0).baseOfSlovarnieSlovaIsAdded == false){
              for(int i = 0; i < slovarnie_slova_box.length;i++){
                  if(slovarnie_slova_box.getAt(i).isAdded == true){
                    for(int j = 0; j < slovarnie_slova_box.getAt(i).words.length; j++){
                      idsOfTestWordsSS.add(slovarnie_slova_box.getAt(i).words[j][2]);
                      if (slovarnie_slova_box.getAt(i).words[j][4]) {
                        idsOfTestWordsThatHaveDefs.add(slovarnie_slova_box.getAt(i).words[j][2]);
                      }
                    }           
                  }              
              }
            }
    counterOfEnabledWordsSS = idsOfTestWordsSS.length.toDouble();
    return Padding(
      padding: EdgeInsets.all(Dimensions.testPagePadding),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Container(
              child: MyText(text: AppStrings.testPageTitle, size: Dimensions.TestPageTitleFontSize, textAlign: TextAlign.center,),
              ),
             SizedBox(height: Dimensions.SBHeight40),
            SliderTheme(
      data: SliderTheme.of(context).copyWith(
      trackHeight: Dimensions.TestSliderTrackHeight,
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
      children: [
        Slider(
          min: (bools_in_bases.get(0).baseOfSlovarnieSlovaIsAdded ? SliderConsts.minValue : 0),
          max: (bools_in_bases.get(0).baseOfSlovarnieSlovaIsAdded ? SliderConsts.maxValue :
          (counterOfEnabledWordsSS > SliderConsts.maxValue ? SliderConsts.maxValue : counterOfEnabledWordsSS)),
          value: _value,
          divisions: (SliderConsts.maxValue - SliderConsts.minValue).round(),
          label: '${_value.round()}',
          onChanged: (value) {
            setState(() {
              _value = value;
            });
          },
        ),
        MyText(text: AppStrings.testPageSliderLabel + _value.round().toString(),
         size: Dimensions.TestSliderLabelFontSize,
         color: AppColors.grayTextColor),
      ],
  ),
),

            SizedBox(height: Dimensions.SBHeight40),
            ElevatedButton(
            child: Padding(
              padding:EdgeInsets.all(Dimensions.TestPageButtonPadding),
              child: MyText(text: AppStrings.testPageButtonTitle,
               size: Dimensions.TestPageButtonFontSize),
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
              if(_value.round() == 0){
                ToastNotification(AppStrings.toastNotificationMessageIfZeroWordsChosed, context);
              }else{
                   Navigator.push(
                   context,
                   MaterialPageRoute(builder: (context) => TestSSPage(value: _value.round(),
                   idsOfTestWords: idsOfTestWordsSS,
                   idsOfTestWordsThatHaveDefs: idsOfTestWordsThatHaveDefs)),);
              }        
            },
            ),
          ],
        ),),
    );
  }
}