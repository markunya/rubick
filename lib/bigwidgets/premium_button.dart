import 'package:flutter/material.dart';
import 'package:rubickk/consts.dart';
import 'package:rubickk/widgets.dart';
import 'package:rubickk/dimensions.dart';

class PremiumButton extends StatelessWidget {
  const PremiumButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
      
  }
}


// TextButton(
//                             onPressed: (){},
//                            child: Container(
//                              child: Padding(
//                                    padding: EdgeInsets.all(Dimensions.premiumButtonPadding),
//                                    child: MyText(text: AppStrings.premium, size: Dimensions.premiumButtonFontSize, color: AppColors.mainColor, weight: FontWeight.w900),
//                                    ),
                           
//                               decoration:  BoxDecoration(                         
//                                borderRadius: BorderRadius.all(Radius.circular(Dimensions.premiumButtonBorderRadius)),
//                                  gradient: LinearGradient(
//                                colors: <Color>[
//                                       Color.fromARGB(255, 221, 223, 58),
//                                         Color.fromARGB(255, 226, 149, 50),
//                   ],
//                    ),
//                  ),
//                 ),   
//                         );