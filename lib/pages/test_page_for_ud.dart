import 'package:flutter/material.dart';
import 'package:rubickk/consts.dart';
import 'package:rubickk/main.dart';
import 'package:rubickk/slovarnie_slova/tests/test_slovarnie_slova_page.dart';
import '../dimensions.dart';
import '../udarenia/tests/test_udarenia.dart';
import '../widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class TestsPageForUd extends StatefulWidget {
  const TestsPageForUd({Key? key}) : super(key: key);

  @override
  State<TestsPageForUd> createState() => _TestsPageForUdState();
}

class _TestsPageForUdState extends State<TestsPageForUd> {
  double counterOfEnabledWordsUd = 0.0;
  late double _value = (bools_in_bases.get(0).baseOfUdareniaIsAdded ? SliderConsts.defaultValue :
  (counterOfEnabledWordsUd > SliderConsts.maxValue ? SliderConsts.maxValue : counterOfEnabledWordsUd));
  @override
  Widget build(BuildContext context) {
    Set idsOfTestWordsUd = {};
    Set idsOfTestWordsThatHaveDefs = {};
    if(bools_in_bases.get(0).baseOfUdareniaIsAdded == false){
              for(int i = 0; i < udarenia_box.length;i++){
                  if(udarenia_box.getAt(i).isAdded == true){
                    for(int j = 0; j < udarenia_box.getAt(i).words.length; j++){
                      idsOfTestWordsUd.add(udarenia_box.getAt(i).words[j][0]);
                      if (udarenia_box.getAt(i).words[j][4]) {
                        idsOfTestWordsThatHaveDefs.add(udarenia_box.getAt(i).words[j][0]);
                      }
                    }
                   
                  }              
              }
             }
    counterOfEnabledWordsUd = idsOfTestWordsUd.length.toDouble();
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
          min: (bools_in_bases.get(0).baseOfUdareniaIsAdded ? SliderConsts.minValue : 0),
          max: (bools_in_bases.get(0).baseOfUdareniaIsAdded ? SliderConsts.maxValue :
          (counterOfEnabledWordsUd > SliderConsts.maxValue ? SliderConsts.maxValue : counterOfEnabledWordsUd)),
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
                  MaterialPageRoute(builder: (context) => TestUdareniaPage(value: _value.round(),
                    idsOfTestWords: idsOfTestWordsUd,
                    idsOfTestWordsThatHaveDefs: idsOfTestWordsThatHaveDefs,
                    )),);
              }        
            },
            ),
          ],
        ),),
    );
  }
}