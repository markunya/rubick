import 'package:flutter/material.dart';
import 'package:rubickk/consts.dart';
import 'package:rubickk/widgets.dart';
import 'package:rubickk/dimensions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import '../pages/word_help_page.dart';


class WordCardButton extends StatelessWidget {
  String id;
  String chapter;
 WordCardButton({Key? key, required this.id, required this.chapter } ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: AppColors.textColor,
      splashRadius: Dimensions.WordCardButtonSplashColorRadius,
      onPressed: (){
        Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => WordHelpPage(id: id, chapter: chapter,)),
  );
      },
       icon: Icon(Icons.help_outline, size: Dimensions.WordCardButtonSize,),
      
      );
  }
}