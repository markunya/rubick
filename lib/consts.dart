import 'package:flutter/material.dart';



class SliderConsts{
  static const double maxValue = 50;
  static const double minValue = 5;
  static const double defaultValue = 20;
}

class Ads{
  static const int adShowingPeriod = 3;
}

class Palette{
static final Color lightBlueColor = const Color(0xFF3B73AA);
static final Color almostBlack = Color(0xff191919);
static final Color mainBlue = Color.fromARGB(255, 16, 81, 171);
static final Color darkGray = Color.fromARGB(255, 37, 37, 37);
static final Color textColor = Color.fromARGB(255, 223, 223, 226);
static final Color grayTextColor = Color.fromARGB(173, 223, 223, 226);
static final Color red = Color(0xffC41e3a);
static final Color green = Color(0xff40826D);
static final Color shadow = Color.fromARGB(0, 0, 0, 0);
static final Color lightGray = Color(0xff708090);
static final Color gold = Color(0xffffed00);
}

class AppColors{

//general
static final Color grayTextColor = Palette.grayTextColor;
static final Color textColor = Palette.textColor;
static final Color invisible = Palette.almostBlack.withOpacity(0);
static final Color shadow = Palette.shadow;
static final Color backgroundColor = Palette.almostBlack;
static final Color lightBlueColor = Palette.lightBlueColor;
static final Color mainColor = Palette.darkGray;

//home_page
static final Color bottomNavigationBarSelectedItemColor = Palette.mainBlue;
static final Color bottomNavigationBarBackgroundColor = Palette.darkGray;
static final Color bottomNavigationBarNotSelectedItemColor = Palette.grayTextColor;
static final Color appBarBackgroudColor = Palette.darkGray;

//slider
static final Color sliderActiveTrackColor = Palette.mainBlue;
static final Color sliderInActiveTrackColor = Palette.mainBlue.withOpacity(0.2);
static final Color sliderThumbColor = Palette.mainBlue;
static final Color sliderOverlayColor = Palette.mainBlue.withOpacity(0.15);
static final Color sliderActiveTickMarkColor = Palette.mainBlue.withOpacity(0);
static final Color sliderInActiveTickMarkColor = Palette.mainBlue.withOpacity(0);
static final Color sliderValueIndicatorColor = Palette.mainBlue;

//NotFound
static final Color notFoundIconColor = Palette.grayTextColor.withOpacity(0.3);
static final Color notFoundTextColor = Palette.grayTextColor.withOpacity(0.4);

//button
static final Color buttonBackgroundColor = Palette.mainBlue;

//checkbox
static final Color checkBoxActiveColor = Palette.mainBlue.withOpacity(0);

//text_form_field
static final Color textFormFieldHintColor = Palette.grayTextColor.withOpacity(0.8);
static final Color textFormFieldSearchIconColor = Palette.grayTextColor.withOpacity(0.8);
static final Color textFormFieldUnderlineColor = Palette.mainBlue;

//card_widget
static final Color cardWidgetBackgroundColor = Palette.darkGray;
static final Color cardWidgetCommonBorderColor = Palette.lightGray.withOpacity(0.1);
static final Color cardWidgetAddedBorderColor = Palette.mainBlue.withOpacity(0.5);

//collection_button
static final Color collectionButtonBackgroundColor = Palette.darkGray;
static final Color collectionButtonBorderColor = Palette.lightGray.withOpacity(0.1);
static final Color reallyWantDeleteCollectionButtonColor = Palette.red;

//linear_progress_indicator
static final Color linearProgresIndicatorColor = Palette.mainBlue;
static final Color linearProgresIndicatorBacgroundColor = Palette.mainBlue.withOpacity(0.2);

//card
static final Color frontOfCardColor = Palette.darkGray;
static final Color backOfCardColor = Palette.mainBlue.withOpacity(0.5);


//alert_dialog
static final Color alertDialogBackgroundColor = Palette.almostBlack;

//collection
static final Color deleteFromCollectionButtonBackgroundColor = Palette.red.withOpacity(0.4);
static final Color collectionIsEmptyTextColor = Palette.grayTextColor.withOpacity(0.4);
static final Color collectionIsEmptyIconColor = Palette.grayTextColor.withOpacity(0.3);

//cicular_progress_indecator
static final Color circularProgressIndicatorColor = Palette.mainBlue;

//cards_in_test
static final Color rightAnswerBorderColor = Palette.green.withOpacity(1);
static final Color wrongAnswerBorderColor = Palette.red.withOpacity(0.5);
static final Color rightAnswerBackgroundColor = Palette.darkGray;
static final Color wrongAnswerBackgroundColor = Palette.darkGray;

//result_page
static final Color containerInResultPageBackgroundColor = Palette.darkGray;
static final Color circularProgressIndicatorInResultPageColor = Palette.mainBlue;
static final Color circularProgressIndicatorInResultPageBackgroundColor = Palette.mainBlue.withOpacity(0.2);

//switch
static final Color switchThumbColor = Palette.mainBlue;
static final Color switchActiveTrackColor = Palette.mainBlue.withOpacity(0.3);
static final Color switchInactiveThumbColor = Palette.textColor;

//addWordsManuallyPages
static final Color alreadyAddedCheckBoxColor = Palette.mainBlue;

//tab_bar
static final Color tabBarIndicatorColor = Palette.mainBlue;

//premium
static final Color premiumColor = Palette.textColor;
}


class AppTimes{
  static const int resultPageCPIAnimationTime = 1;
}



// Color.fromARGB(0, 38, 156, 12)

class AppStrings{
  static const String collectionsBoxName = 'nameoretr';
  static const String boolsInBasesName = 'namefdatfdasfwo';
  static const String allAddedName = 'namethreddfasfse';
  static const String allAddedUdareniaName = 'namfdaefdasfoursa';
  static const String udareniaBoxName = 'namefdfaivfdfdse';


  static const String baseOfWordsAppBarTitle = 'База слов';
  static const String baseOfWordsWaitingPage = 'Долгая загрузка? \nПроверьте подключение \nк интернету.';
  static const String  BNBLabelStudy =  'Обучение';
  static const String BNBLabelTests = 'Тесты';
  static const String ABTestsUd = 'Тесты (ударения)';
  static const String ABTestsSS = 'Тесты (орфогарафия)';
  static const String  ABStudy =  'Обучение';
  static const String  premium =  'Отключить рекламу';
  static const String SPBaseOfWordsButtonName = 'База слов с\nтрудной орфографией';
  static const String instruction =  'Инструкция';
  static const String aboutApp = 'О приложении';
  static const String testPageButtonTitle = 'Начать';
  static const String testPageTitle = 'Выберите количество \nвопросов в тесте';
  static const String testPageSliderLabel = 'Вопросов в тесте: ';
  static const String TestSSInputHint = 'Введите пропущенные буквы'; 
  static const String TestSSButtonText = 'Ответить'; 
  static const String TestSSAppBarTitle = 'Словарный диктант'; 
  static const String ResultPageANE = 'А не ';
  static const String ResultPageContainerSubtitile1 = 'Вы ответили правильно на\n ' ;
  static const String ResultPageContainerSubtitile2 = ' из ';
  static const String ResultPageContainerSubtitile3 = ' вопросов';
  static const String BaseOfWordsSearch = 'Введите слово';
  static const String BaseOfWordsSearchNFLabel = 'Ничего не найдено';
  static const String wordHPDefTitle = 'Определение:';
  static const String addCollectionAllertDialogTitle = 'Создать коллекцию';
  static const String addCollectionAllertDialogInputHint = 'Придумайте название';
  static const String addCollectionAllertDialogButtonTitle = 'Создать';
  static const String collectionAllertDialogTitle = 'Выберите количество слов';
  static const String collectionSliderLabel1 = 'Будет добавлено ';
  static const String collectionSliderLabel2 = ' слов';
  static const String collectionAlertDialogButton1 = 'Добавить автоматически';
  static const String collectionAlertDialogButton2 = 'Выбрать самостоятельно';
  static const String BaseOfWordsAmountOfWordsFP = 'Всего в базе ';
  static const String BaseOfWordsAmountOfWordsSP = ' слов';
  static const String CollectionAmountOfWordsFP = 'В данной коллекции ';
  static const String CollectionAmountOfWordsSP = ' слов';
  static const String AddWordsManuallyPageTitle = 'Выберите слова';
  static const String addWordsManuallyPage1ButtonTitle = 'Далее';
  static const String addWordsManuallyPage2ButtonTitle = 'Готово';
  static const String collectionPageButtonTitle = 'Добавить';
  static const String addWordsManuallyPage2AppBarTitle = 'Будут добавлены';
  static const String cardsModeAppBarTitle = 'Карточки';
  static const String cardsModeKnowButtonTitle = 'Знал';
  static const String cardsModeDidntKnowButtonTitle = 'Не знал';
  static const String cardsModeAlreadyDoneTitleFirstPart = 'Вы повторили\n';
  static const String cardsModeAlreadyDoneTitleSecondPart = ' словарных слов';
  static const String cardModeAlreadyDoneButtonText = 'Еще раз';
  static const String reallyWantDeleteCollectionDialogTitle = 'Вы действительно хотите удалить эту коллекцию?';
  static const String reallyWantDeleteCollectionButtonTitle = 'Удалить';
  static const String collectionIsEmptyWarning = 'Коллекция пуста';
  static const String errorMessage = 'Произошла ошибка';
  static const String toastNotificationMessageIfZeroWordsChosed = 'Выберите больше вопросов';
  static const String collectionIsEmptyText = "Коллекция пустует.\nДобавьте слова и начните обучение";
  static const String youHaveAddedAllWordsFromBase = "Вы добавили все слова из базы";
  static const String addCollectionButtonText = "Создать";
  static const String baseOfUdareniaAppBarTitle = "База слов";
  static const String tabBarChapter1 = "Орфография";
  static const String tabBarChapter2 = "Ударения";
  static const String createYourFirstCollection = "Создайте свою первую коллекцию";
}


