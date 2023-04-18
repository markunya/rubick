import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:rubickk/consts.dart';
import 'package:rubickk/udarenia/study/collection_page_udarenia.dart';
import 'package:rubickk/widgets.dart';
import 'package:rubickk/udarenia/study/base_of_udarenia_button.dart';
import '../../dimensions.dart';
import '../../hive_files/hive_collection.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import '../../main.dart';

class UdareniaPage extends StatefulWidget {
  const UdareniaPage({Key? key}) : super(key: key);
  
  @override
  State<UdareniaPage> createState() => _UdareniaPageState();
}

class _UdareniaPageState extends State<UdareniaPage> {
  bool valuem = false;
  final TextEditingController controller = TextEditingController();
  String inputTask = '';

  @override
  Widget build(BuildContext context) {

    void changeIsAdded(
     Collection collection,
     bool isAdded,
    ){
        collection.isAdded = isAdded;
        collection.save();
    }
     

    containAndDelete(a,b){
         for(int j = 0; j < a.length; j++){
          b.words[a[j][0]]--;
          if(b.words[a[j][0]] <= 0){
            b.words.remove(a[j][0]);
            all_added_udarenia.get(0).wordsVariants.remove(a[j][0]);
            all_added_udarenia.get(0).wordsAnswers.remove(a[j][0]);
            all_added_udarenia.get(0).wordsWords.remove(a[j][0]);
          }
          all_added_udarenia.get(0).save();
         }
        }

    Future reallyWantDeleteCollectionDialog(i) => showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: AppColors.alertDialogBackgroundColor,
      title: MyText(text: AppStrings.reallyWantDeleteCollectionDialogTitle,
      size: Dimensions.reallyWantDeleteCollectionDialogTitleFS,
      ),
      actions: [
        TextButton(
          child: Padding(
            padding: EdgeInsets.all(Dimensions.addCollectionAlertDialogButtonPadding),
            child: MyText(text: AppStrings.reallyWantDeleteCollectionButtonTitle,
            size: Dimensions.reallyWantDeletteCollectionButtonFS,
            color: AppColors.reallyWantDeleteCollectionButtonColor,
            ),
          ),
           onPressed: (){
            Navigator.pop(context);
            containAndDelete(udarenia_box.getAt(i).words, all_added_udarenia.get(0));
            udarenia_box.deleteAt(i); 
            setState(() {});
           }),
      ],
    ) 
    );     

    Future openDialog() => showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: AppColors.alertDialogBackgroundColor,
      title: MyText(text: AppStrings.addCollectionAllertDialogTitle,
      size: Dimensions.addCollectionAlertDialogTitleSize),
      content: TextField(
        controller: controller,
        style: TextStyle(color: AppColors.textColor),
        decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.textFormFieldUnderlineColor),
            ), 
          hintText: AppStrings.addCollectionAllertDialogInputHint,
          hintStyle: TextStyle(
            color: AppColors.grayTextColor,
          ),
        )
      ),
      actions: [
        ElevatedButton(
          child: Padding(
            padding: EdgeInsets.all(Dimensions.addCollectionAlertDialogButtonPadding),
            child: MyText(text: AppStrings.addCollectionAllertDialogButtonTitle,
            size: Dimensions.addCollectionAlertDialogButtonFS),
          ),
          style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(AppColors.buttonBackgroundColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.addCollectionAlertDialogButtonBR),
       ),
          ),
          ),
           onPressed: (){
            String emptyCheckerString = controller.text;
            int emptyCheckerCounter = 0;
            for(int i=0; i<emptyCheckerString.length; i++){
              if(emptyCheckerString[i]==' '){
                     emptyCheckerCounter++;
              }
            }
            if(emptyCheckerString.length - emptyCheckerCounter > 0){
                 String collectionsFutureName = controller.text;
                 controller.clear();
                 Collection collection = Collection(name: collectionsFutureName, words: [], isAdded: true );
                 udarenia_box.add(collection);
                 setState(() {});               
                 Navigator.pop(context);
                //  box.clear();
            }
           })
      ],
    ) 
    );
    return Stack(
      // alignment: Alignment.topCenter,
      // fit: StackFit.expand,
           children: [
            //  FindCollectionInput(),                
             Align(
              alignment: Alignment.topCenter,
               child: ScrollConfiguration(
                 behavior: MyBehavior(),
                 child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                     child: Padding(
                       padding: EdgeInsets.symmetric(horizontal: Dimensions.SSPagePaddingHorizontal),
                       child: Column(
                         children: [
                           SizedBox(height: Dimensions.SBHeight20),

                           BaseOfUdareniaButton(), //////////////////////////////_______BaseOfUdareniaButton_______////////////////////////////////////
                           
                           SizedBox(height: Dimensions.SBHeight20),

                           ValueListenableBuilder(

                            valueListenable: udarenia_box.listenable(),
                            builder: (context,Box _someBox,_){
                              List<int> keys = _someBox.keys.cast<int>().toList();
                             
                             return LayoutGrid(
                             columnSizes: [1.fr, 1.fr],
                  
                             rowSizes: [
                                    for(int i = 0; i < (keys.length /2).round()+1; i++)
                                     IntrinsicContentTrackSize(),                 
                                     ],
                                  columnGap: Dimensions.CollectionsColumnGap,
                                     rowGap: Dimensions.CollectionsRowGap,
                                      children: [                    
                               for(int i = keys.length-1; i >= 0; i--)                           
                                       Container(
                                       child: ElevatedButton(
                                       style: ButtonStyle(
                                       side: MaterialStateProperty.all<BorderSide>(BorderSide(color: AppColors.collectionButtonBorderColor, width: 2)),
                                       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                       RoundedRectangleBorder(
                                       borderRadius: BorderRadius.only(       
                                       topRight:Radius.circular(Dimensions.CollectionBRTopRight),
                                       topLeft: Radius.circular(Dimensions.CollectionBRTopLeft),
                                       bottomRight: Radius.circular(Dimensions.CollectionBRBottomRight),
                                       bottomLeft:Radius.circular(Dimensions.CollectionBRBottomLeft),
                                      ),
                                   ),
                              ),
                               ) ,
                                      onLongPress: (){
                                       reallyWantDeleteCollectionDialog(i);        
                                      },
                                      onPressed: () {
                                        Navigator.push(
                                                      context,
                                                      MaterialPageRoute(builder: (context) => CollectionPageUdarenia(index: keys[i]),
                                                      ),
                                                     );
                                      },
                                   child: Padding(
                                   padding:EdgeInsets.symmetric(
                                      vertical:  Dimensions.collectionButtonVerticalPadding,
                                      horizontal:  Dimensions.collectionButtonHorizontalPadding,
                                       ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            child: Row(   
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,                                      
                                            children: [
                                              Flexible(child: MyText(text: udarenia_box.get(keys[i]).name,
                                               textAlign: TextAlign.center,
                                               size: Dimensions.collectionNameFS),
                                               ),
                                               Switch(
                                                 value: udarenia_box.get(keys[i]).isAdded,
                                                 activeColor: AppColors.switchThumbColor,
                                                 inactiveThumbColor: AppColors.switchInactiveThumbColor,
                                                 activeTrackColor: AppColors.switchActiveTrackColor,
                                                 onChanged: (value) {      
                                                  changeIsAdded(udarenia_box.get(keys[i]), value);                                 
                                                  },
                                                       ),
                                                  ],
                                              ),

                                          ),
                                        ],
                                      ),  
                            ),
    ),
                                   ),
                                    
                                 
         ],
      );
                            },
                           ),
                           SizedBox(height: Dimensions.SBHeight60),
                         ],
                       ),
                     ),
                   ),
               ),
             ),
      
      Align(
        alignment: Alignment.bottomCenter,
        child: Visibility(
          visible: udarenia_box.isEmpty,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MyText(text: AppStrings.createYourFirstCollection,
                      color: AppColors.collectionIsEmptyIconColor,
                      size: Dimensions.createFirstCollectionTextFontSize,
                      textAlign: TextAlign.center,),
              SizedBox(height: Dimensions.SBHeight10,),
              Image.asset(
                'lib/assets/icons/arrow_icon.png',
                width: Dimensions.createFirstCollectionIconWidth,
                color: AppColors.collectionIsEmptyIconColor,
              ),
              SizedBox(height: Dimensions.SBHeight70,),
            ],
          ),
        ),
      ),

      Align(
        alignment: Alignment.bottomCenter,
        child: Container(                   
                         width: Dimensions.screenWidth,
                         decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                                AppColors.invisible,
                                AppColors.backgroundColor,
                                AppColors.backgroundColor,
                            ],
                          ), 
                         ),
                         child: Padding(
                         padding: EdgeInsets.symmetric(vertical: Dimensions.screenHeight*5/926, horizontal: Dimensions.screenWidth*10/428),
                         child: ElevatedButton(
                         child: Padding(
                                  padding:EdgeInsets.symmetric(vertical: Dimensions.screenHeight*10/926),
                                  child: MyText(text: AppStrings.addCollectionButtonText, size: Dimensions.buttonFontSize),
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
               openDialog();
            },
                          ),
                          ),
                       ),
      ),       
      ],
      );
  }
}