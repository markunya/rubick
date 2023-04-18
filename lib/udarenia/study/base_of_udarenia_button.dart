import 'package:flutter/material.dart';
import 'package:rubickk/hive_files/bools_in_bases.dart';
import 'package:rubickk/consts.dart';
import 'package:rubickk/main.dart';
import 'package:rubickk/widgets.dart';
import 'package:rubickk/udarenia/study/base_of_udarenia_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rubickk/dimensions.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

class BaseOfUdareniaButton extends StatelessWidget {
  const BaseOfUdareniaButton({Key? key}) : super(key: key);
   
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Dimensions.baseOfWordsButtonWidth,
      child: ElevatedButton(
      style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(AppColors.collectionButtonBackgroundColor),
      side: MaterialStateProperty.all<BorderSide>(BorderSide(color: AppColors.collectionButtonBorderColor, width: 2,)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
          borderRadius: BorderRadius.only(       
          topRight:Radius.circular(Dimensions.baseOfWordsCollectionBRTopRight),
          topLeft: Radius.circular(Dimensions.baseOfWordsCollectionBRTopLeft),
          bottomRight: Radius.circular(Dimensions.baseOfWordsCollectionBRBottomRight),
          bottomLeft:Radius.circular(Dimensions.baseOfWordsCollectionBRBottomLeft),
           ),
       )
      )
               ) ,
        onPressed: () {
          Navigator.pushNamed(context, '/baseOfUdarenia');
        },
        child: Padding(
          padding:EdgeInsets.symmetric(
            vertical:  Dimensions.baseOfWordsCollectionVerticalPadding,
            horizontal:  Dimensions.baseOfWordsCollectionHorizontalPadding,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText(text: 'База слов с\nтрудным ударением',
                     color: AppColors.textColor,
                     size: Dimensions.baseOfWordsCollectionFontSize,
                     weight: FontWeight.w700),
              ValueListenableBuilder(
                valueListenable: bools_in_bases.listenable(),
                builder: (context, Box _someBox, _){
                  return Switch(
                   value: bools_in_bases.get(0).baseOfUdareniaIsAdded,
                   activeColor: AppColors.switchThumbColor,
                   inactiveThumbColor: AppColors.switchInactiveThumbColor,
                   activeTrackColor: AppColors.switchActiveTrackColor,
                   onChanged: (value) {      
                     bools_in_bases.get(0).baseOfUdareniaIsAdded = value;      
                     bools_in_bases.get(0).save();                          
                   },
                                                     );
                                                     }
              ),
              ],
      ),
        ),
    ),
    );
  }
}