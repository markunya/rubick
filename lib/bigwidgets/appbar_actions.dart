import 'package:flutter/material.dart';
import 'package:rubickk/consts.dart';
import 'package:rubickk/dimensions.dart';
import 'package:rubickk/widgets.dart';
import 'package:rubickk/bigwidgets/premium_button.dart';
import 'package:rubickk/bigwidgets/instruction_button.dart';

import '../pages/about_app_page.dart';
import '../pages/instruction_page.dart';
enum MenuItem {
  instruction,
  aboutApp,
  premium,
}
class AppBarActions extends StatelessWidget {
  const AppBarActions({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: PopupMenuButton(
        color: AppColors.alertDialogBackgroundColor,
        onSelected: (value) {
          if (value == MenuItem.instruction) {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InstructionPage(),));
          } else if (value == MenuItem.aboutApp) {
              Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) => AboutAppPage(),));
          } else if (value == MenuItem.premium) {

          }
        },
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              value: MenuItem.instruction,
              child: MyText(text: AppStrings.instruction, size: Dimensions.menuItemFontSize,
              ),
              ),
            PopupMenuItem(
              value: MenuItem.aboutApp,
              child: MyText(text: AppStrings.aboutApp, size: Dimensions.menuItemFontSize,
              ),
              ),
          ];
        },
      ),
    );
    
  }
}