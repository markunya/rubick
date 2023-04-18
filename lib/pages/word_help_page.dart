import 'package:flutter/material.dart';
import 'package:rubickk/bigwidgets/appbar_actions.dart';
import 'package:rubickk/consts.dart';
import 'package:rubickk/widgets.dart';
import 'package:rubickk/dimensions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class WordHelpPage extends StatelessWidget {

  String id;
  String chapter;

  WordHelpPage({Key? key, required this.id,required this.chapter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection(chapter).snapshots(),
      builder:(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
           var fields;
              if(!snapshot.hasData || snapshot.data?.docs.length == 0) {  
              return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(AppColors.circularProgressIndicatorColor),),
                SizedBox(height: Dimensions.SBHeight20),
              ],
            )
            );
              }
            dynamic z =  snapshot.data?.docs.length;
            for(int i = 0; i < z; i++){
                if(snapshot.data!.docs[i].id == id){
                  fields = snapshot.data!.docs[i].data() as Map;
                  break;
                }
            }
            return Scaffold(
                     appBar: AppBar(
                     title: MyText(text: fields["word"],
                     size: Dimensions.appBarFontSize, weight: FontWeight.w700
                     ),
                     leading: IconButton(
                                          icon: Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textColor),
                                          onPressed: (){
                                            Navigator.pop(context);
                                          }
                                        ),
                     actions: [
                      AppBarActions(),
                     ],
                     ),

                     body: Padding(
                       padding: EdgeInsets.symmetric(horizontal: Dimensions.wordHPBodyPaddingHorizontal, vertical: Dimensions.wordHPBodyPaddingVertical),
                       child: Column(       
                        children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: MyText(text: 'Определение',
                                                size: Dimensions.wordHPDefTitleFontSize,
                                                weight: FontWeight.bold,
                                                textAlign: TextAlign.start,),
                                ),
                                SizedBox(height: Dimensions.SBHeight10,),
                                Container(
                                  child: MyText(text: fields["def"], size: Dimensions.wordHPDefFontSize,),
                                ),
                              ],
                            ),
                            
                       ],),
                     )
            );
      }
      );
  }
}