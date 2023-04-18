import 'package:get/get.dart';

class Dimensions{ 
    static double screenHeight = Get.context!.height;
    static double screenWidth = Get.context!.width;

    //genral
    static double buttonFontSize = screenWidth*20/428;

    
    //sizedBox
    static double SBHeight1 = screenHeight*1/926;
    static double SBHeight10 = screenHeight*10/926;
    static double SBHeight20 = screenHeight*20/926;
    static double SBHeight30 = screenHeight*30/926;
    static double SBHeight40 = screenHeight*40/926;
    static double SBHeight50 = screenHeight*50/926;
    static double SBHeight60 = screenHeight*60/926;
    static double SBHeight80 = screenHeight*80/926;
    static double SBHeight120 = screenHeight*120/926;
    static double SBHeight70 = screenHeight*70/926;
 

   //DEFAULT
   static double defaultFontSize = screenWidth*22/428;
   static double appBarFontSize = screenWidth*22/428;
   static double inputFontSize = screenWidth*22/428;
   static double tabBarHeight = screenHeight*60/926;
   
   //PREMIUM
   static double premiumButtonPadding = screenWidth*8/428;
   static double premiumButtonFontSize = screenWidth*17/428;
   static double premiumButtonBorderRadius = screenWidth*10/428;
   
   //slovarnie_slova
   static double addCollectionButtonBR = screenWidth*50/428;
   static double collectionButtonVerticalPadding = screenHeight*30/926;
   static double collectionButtonHorizontalPadding = screenWidth*0/428;
   static double SSPagePaddingHorizontal = screenWidth*20/428;
   static double addCollectionButtonWidth = screenWidth-SSPagePaddingHorizontal*2;
   static double addCollectionButtonHeight = screenHeight*50/926;
   static double addCollectionButtonIconSize = addCollectionButtonHeight*0.95;
   static double baseOfWordsButtonWidth = screenWidth-SSPagePaddingHorizontal*2;
   static double baseOfWordsCollectionVerticalPadding = screenHeight*20/926;
   static double baseOfWordsCollectionHorizontalPadding = screenWidth*5/428;
   static double baseOfWordsCollectionFontSize = screenWidth*24/428;
   static double baseOfWordsCollectionBRBottomLeft = screenWidth*20/428;
   static double baseOfWordsCollectionBRBottomRight = screenWidth*20/428;
   static double baseOfWordsCollectionBRTopLeft = screenWidth*20/428;
   static double baseOfWordsCollectionBRTopRight = screenWidth*20/428;
   static double baseOfWordsSearchIconSize = screenWidth*25/428;
   static double baseOfWordsSearchNFLabelFontSize= screenWidth*18/428;
   static double baseOfWordsSearchNFIconFontSize= screenWidth*120/428;
   static double baseOfWordsWordsAmountFS = screenWidth*14/428;
   static double createFirstCollectionTextFontSize = screenWidth*16/428;
   static double createFirstCollectionIconWidth = screenWidth*18/428;

   //CPI
   static double CPIFontSize = screenWidth*14/428;

   //testPage
   static double testPagePadding = screenWidth*10/428;
   static double TestSliderTrackHeight = screenWidth*10/428;
   static double TestSliderenabledThumbRadius = screenWidth*14/428;
   static double TestSlideroverlayRadius = screenWidth*30/428;
   static double TestPageButtonFontSize = screenWidth*24/428;
   static double TestPageButtonPadding = screenWidth*15/428;
   static double TestPageButtonBR = screenWidth*50/428;
   static double TestPageTitleFontSize = screenWidth*28/428;

   //CollectionPage
   static double WordCardVerticalMargin = screenHeight*7/926;
   static double WordCardHorizontalMargin = screenWidth*10/428;
   static double WordCardPadding = screenWidth*15/428;
   static double WordCardButtonSize = screenWidth*35/428;
   static double WordCardButtonSplashColorRadius = screenWidth*30/428;
   static double WordCardBR = screenWidth*40/428;
   
   //TestSS
   static double TestSliderLabelFontSize = screenWidth*18/428;
   static double TestSliderFontSize = screenWidth*20/428;
   static double TestSSQuestionFontSize = screenWidth*30/428;
   static double TestSSInputHintFontSize = screenWidth*22/428;
   static double TestSSInputPadding = screenWidth*60/428;
   static double TestSSButtonPadding = screenWidth*15/428;
   static double TestSSButtonBR = screenWidth*50/428;
   static double TestSSButtonFontSize  = screenWidth*24/428;
   static double WordCardSubTitleFontSize  = screenWidth*15/428;
   static double WordCardLeadingIconSize  = screenWidth*35/428;
   static double TestSSLPIPadding  = screenWidth*10/428;
   static double TestSSLPIHeight = screenWidth*4/428;
   static double variantBottomMargin = screenHeight*12/926;
   static double variantWidth = screenWidth*2/3;
   static double variantBorderRadius = screenWidth*100/428;
   static double variantPadding = screenWidth*12/428;
   static double variantTextFontSize = screenWidth*27/428;

   

   //resultPage
    static double ResultPageContainerBR = screenHeight*40/926;
    static double ResultPageContainerResultFontSize  = screenWidth*30/428;
    static double ResultPageCPIStrokeWidth = screenWidth*15/428;
    static double ResultPageContainerSize = screenWidth*150/428;
    static double ResultPageContainerSubtitleFontSize = screenWidth*15/428;
    static double ResultPageContainerShadowBlurRadius = screenWidth*5/428;
    static double ResultPageContainerShadowSpreadRadius = screenWidth*2.5/428;
    static double wordCardFS = screenWidth*22/428;

    
    //wordHelpPage
    static double wordHPDefTitleFontSize = screenWidth*22/428;
    static double wordHPDefFontSize = screenWidth*20/428;
    static double wordHPBodyPaddingHorizontal = screenWidth*15/428;
    static double wordHPBodyPaddingVertical = screenWidth*40/926;
    

    //addCollectionAlertDialog
    static double addCollectionAlertDialogTitleSize = screenWidth*22/428;
    static double addCollectionAlertDialogButtonBR = screenWidth*30/428;
    static double addCollectionAlertDialogButtonPadding = screenWidth*8/428;
    static double addCollectionAlertDialogButtonFS = screenWidth*18/428;

    //UsersCollections
    static double CollectionsColumnGap = screenWidth*12/428;
    static double CollectionsRowGap = screenWidth*12/428;
    static double CollectionBRBottomLeft = screenWidth*20/428;
    static double CollectionBRBottomRight = screenWidth*20/428;
    static double CollectionBRTopLeft = screenWidth*20/428;
    static double CollectionBRTopRight = screenWidth*20/428;
    static double collectionNameFS = screenWidth*20/428;

    //CollectionsPage
    static double collectionPageABTitle = screenWidth*22/428;
    static double collectionAlertDialogTitleFS = addCollectionAlertDialogTitleSize;
    static double collectionSliderLabelFontSize = TestSliderLabelFontSize;
    static double collectionAlertDialogButton2BorderSide = screenWidth*1/428;
    static double collectionAlertDialogButtonFS = screenWidth*18/428;
    static double collectionIsEmptyTextFontSize = screenWidth*16/428;
    static double collectionIsEmptyIconSize = screenWidth*150/428;

    //CardMode
    static double cardFontSize = screenWidth*27/428;
    static double cardModeButtonsFontSizes = screenWidth*22/428;
    static double cardHorizontalMargin = screenWidth*15/428;
    static double cardVerticalMargin = screenWidth*12/428;
    static double iconButtonToCardModeSize = screenWidth*30/428; 
    static double cardModePageAlreadyDoneTitleFontSize = screenWidth*24/428;
    static double cardModeAlreadyDoneTitleHorizontalPadding = screenWidth*30/428;
    static double cardModeAlreadyDoneTitleVerticalPadding = screenWidth*10/428;
    static double cardModeButtonPadding = screenWidth*8/428;
    static double cardModeCardWidth = screenWidth*2/3;
    static double cardModeCardHeight = screenWidth*50/428;
    static double cardModeButtonWidth = screenWidth/2;
    static double cardModeAlreadyDoneButtonBR = screenWidth*30/428;
    static double cardModeAlreadyDoneButtonPadding = screenWidth*8/428;
    static double cardModeAlreadyDoneButtonFS = screenWidth*24/428;
    static double cardModeAlreadyDoneIconSize = screenWidth*130/428;

    //addWordsManually
    static double addWordsManuallyButtonMarginBottom = screenWidth*5/428;
    static double addWordsManuallyButtonMarginHorizontal = screenWidth*10/428;
    static double addWordsManuallyButtonPaddingVerical = screenWidth*10/428;
    
    //search
    static double searchMarginHorizontal = screenWidth*20/428;
    static double searchMarginTop = screenWidth*10/428;

    //reallyWantDeleteCollection
    static double reallyWantDeleteCollectionDialogTitleFS = screenWidth*22/428;
    static double reallyWantDeletteCollectionButtonFS = screenWidth*20/428;

    //toastNotification
    static double toastNotificationFontSize = screenWidth*18/428;
    static double toastNotificationHorizontalMargin = screenWidth*20/428;
    static double toastNotificationVerticalPadding = screenWidth*7/428;
    static double toastNotificationHorizontalPadding = screenWidth*10/428;
    static double toastNotificationBorderRadius = screenWidth*10/428;

    //menu
    static double menuItemFontSize = screenWidth*16/428;

    //instruction
    static double instructionTitleSize = screenWidth*24/428;
    static double instructionTextSize = screenWidth*18/428;
    static double instructionCommonImageWidth = screenWidth/2;
    static double instructionPairImageWidth = screenWidth/2.5;
    static double instructionPageHorizontalPading = screenWidth*15/428;
    static double instructionPageVerticalPading = screenWidth*10/428;
  }




