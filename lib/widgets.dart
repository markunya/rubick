import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:rubickk/consts.dart';
import 'package:rubickk/dimensions.dart';



//MyText(text: 'abcdfghijklm', color: AppColors.lightBlueColor, size: 15, weight: FontWeight.w900)

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

class MyText extends StatelessWidget {
  final Color color;
  final String text; 
  double size;
  FontWeight weight;
  var textAlign;
  bool fittedBox;

  MyText({Key? key,
                required this.text,                
                this.color = const Color.fromARGB(255, 223, 223, 226),
                this.size = 22,
                this.weight = FontWeight.w400,
                this.textAlign = TextAlign.left,
                this.fittedBox = false,
                 }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return fittedBox == true ? FittedBox(
      child: Text(
        text,       
        textAlign:textAlign ,
        style: TextStyle(
          color: color,
          fontSize: size,
          fontFamily: 'Roboto',
          fontWeight: weight,
       
        )),
    )
    :  Text(
        text,
        softWrap:true,
        textAlign:textAlign ,
        style: TextStyle(
          color: color,
          fontSize: size,
          fontFamily: 'Roboto',
          fontWeight: weight,
       
        ));

  }
}


class MyCard extends StatelessWidget {
  String text;
  double textFontSize;
  Widget trailing;
  Color backgroundColor;
  double verticalMargin;
  double horizontalMargin;
  double borderRadius;
  BorderSide side;
  MyCard({
    required this.text,
    required this.textFontSize,
    required this.trailing,
    required this.backgroundColor,
    required this.verticalMargin,
    required this.horizontalMargin,
    required this.borderRadius,
    required this.side,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(                   
                shape: RoundedRectangleBorder(
                      side: side,
                      borderRadius: BorderRadius.circular(borderRadius),
                ),
                margin: EdgeInsets.symmetric(horizontal: horizontalMargin, vertical: verticalMargin),
                color: backgroundColor,
                child: ListTile(
                title: MyText(text: text,
                size: textFontSize,                                                                       
                ),
                trailing: trailing, 
                ),
                );
  }
}

void ToastNotification(String message, context) {
    showToast(
                            message,
                            context: context,
                            backgroundColor: AppColors.alertDialogBackgroundColor,
                            borderRadius: BorderRadius.circular(Dimensions.toastNotificationBorderRadius),
                            animation: StyledToastAnimation.slideFromTop,
                            reverseAnimation: StyledToastAnimation.slideToTop,
                            startOffset: Offset(0.0, -2.0),
                            reverseEndOffset: Offset(0.0, -5.0),
                            position: StyledToastPosition.top,
                            duration: Duration(milliseconds: 2500),
                            animDuration: Duration(seconds: 1),
                            textPadding: EdgeInsets.symmetric(
                            horizontal: Dimensions.toastNotificationHorizontalPadding,
                            vertical: Dimensions.toastNotificationVerticalPadding,
                            ),
                            toastHorizontalMargin: Dimensions.toastNotificationHorizontalMargin,
                            textStyle: TextStyle(
                              fontSize: Dimensions.toastNotificationFontSize,
                              color: AppColors.textColor,
                            ),
                            fullWidth: true,
                            curve: Curves.elasticOut,
                            reverseCurve: Curves.fastOutSlowIn
                            );
}

class NotFound extends StatelessWidget {
  const NotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  SizedBox(height: Dimensions.SBHeight120),
                  Image.asset('lib/assets/icons/not_found.png',
                  width: Dimensions.baseOfWordsSearchNFIconFontSize,
                  color: AppColors.notFoundIconColor),
                  // Icon(Icons.search_off, color:AppColors.grayTextColor,
                  // size: Dimensions.baseOfWordsSearchNFIconFontSize),
                  SizedBox(height: Dimensions.SBHeight30),
                  MyText(text: AppStrings.BaseOfWordsSearchNFLabel,
                  color:AppColors.notFoundTextColor,
                  size: Dimensions.baseOfWordsSearchNFLabelFontSize),
                  ],
                  );
  }
}