import 'package:flutter/material.dart';
import 'package:rubickk/consts.dart';
import 'package:rubickk/main.dart';
import 'package:rubickk/widgets.dart';
import 'package:rubickk/dimensions.dart';


class AboutAppPage extends StatelessWidget {
  AboutAppPage({Key? key}) : super(key: key);
  
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
        title: MyText(text: AppStrings.aboutApp,
         size: Dimensions.appBarFontSize,
         weight: FontWeight.w700),
        actions: [],
        
      ),
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.instructionPageHorizontalPading, vertical: Dimensions.instructionPageVerticalPading),
            child: Column(
              children: [
                MyText(
                  text: "Приложение предназначено для тех, кто хочет улучшить свой уровень знания русского языка или подготовиться к сдаче таких экзаменов, как ОГЭ, ЕГЭ, ЦТ или ЦЭ. Я разработал удобную систему, которая позволяет учить словарные слова и ударения в комфортном лично для вас темпе.",
                  size: Dimensions.instructionTextSize,
                  ),
                SizedBox(height: Dimensions.SBHeight10,),
                MyText(
                  text: "В каждом разделе есть большая база слов, которую пользователь может разбить на коллекции и учить по частям. Это поможет запомнить слова более эффективно и быстро.",
                  size: Dimensions.instructionTextSize,
                  ),
                SizedBox(height: Dimensions.SBHeight10,),
                MyText(
                  text: "Кроме того, в каждой коллекции есть режим карточек. Который позволяет удобно и быстро учить словарные слова.",
                  size: Dimensions.instructionTextSize,
                  ),
                SizedBox(height: Dimensions.SBHeight10,),
                MyText(
                  text: "Также в приложение есть тестирование, чтобы проверить свой прогресс и закрепить свои знания. Вы можете выбрать количество вопросов и проходить его в любое время. Рекомендую переодически проходить тестирование по коллекциям, слова в которых вы уже выучили. Это поможет не забыть выученную информацию.",
                  size: Dimensions.instructionTextSize,
                  ),
                SizedBox(height: Dimensions.SBHeight10,),
                MyText(
                  text: "Более того, я уделил особое внимание удобству использования приложения. Интерфейс приложения интуитивно понятен и удобен в использовании. Вы сможете быстро найти нужное слово или коллекцию и начать учиться.",
                  size: Dimensions.instructionTextSize,
                  ),
              ],
            ),
          ),
        ),
      ),
      );
  }
}