import 'package:flutter/material.dart';
import 'package:rubickk/consts.dart';
import 'package:rubickk/main.dart';
import 'package:rubickk/widgets.dart';
import 'package:rubickk/dimensions.dart';


class InstructionPage extends StatelessWidget {
  InstructionPage({Key? key}) : super(key: key);
  
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
        title: MyText(text: AppStrings.instruction,
         size: Dimensions.appBarFontSize,
         weight: FontWeight.w700),
        actions: [],
        
      ),
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.instructionPageHorizontalPading, vertical: Dimensions.instructionPageVerticalPading),
            child: Container(
              width: Dimensions.screenWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                    MyText(
                      text: "Обучение",
                      size: Dimensions.instructionTitleSize,
                      weight: FontWeight.bold,
                      ),
                    SizedBox(height: Dimensions.SBHeight20),
                    Image.asset(
                      'lib/assets/instruction/study_page.png',
                      width: Dimensions.instructionCommonImageWidth,
                    ),
                    SizedBox(height: Dimensions.SBHeight10),
                    MyText(
                      text: "Страница обучения представлена базой слов и пользовательскими коллекциями. Чтобы сменить раздел обучения, используйте меню в левом верхнем углу.",
                      size: Dimensions.instructionTextSize,
                    ),
                    SizedBox(height: Dimensions.SBHeight10),
                    MyText(
                      text: "Чтобы создать коллекцию, нажмите на кнопку «Создать» внизу экрана и придумаайте название.",
                      size: Dimensions.instructionTextSize,
                    ),

                    
                    SizedBox(height: Dimensions.SBHeight20),
                    MyText(
                        text: "База слов",
                        size: Dimensions.instructionTitleSize,
                        weight: FontWeight.bold,
                    ),
                    SizedBox(height: Dimensions.SBHeight20),
                    Image.asset(
                      'lib/assets/instruction/base_button.png',
                      width: Dimensions.instructionCommonImageWidth,
                    ),
                    SizedBox(height: Dimensions.SBHeight10),
                    MyText(
                      text: "На кнопке базы есть включатель. Когда база включена, вне зависимости от положения включателей на пользовательских коллекциях, тестирование проходит по ней. То есть из всех слов приложения выбираются случайные в количестве, выбранном на странице тестирования, и добавляются в тест. Когда база выключена, тестирование происходит по включенным коллекциям.",
                      size: Dimensions.instructionTextSize,
                    ),
                    SizedBox(height: Dimensions.SBHeight10),
                    MyText(
                      text: "При нажатии на кнопку базы вы переходите на страницу базы.",
                      size: Dimensions.instructionTextSize,
                    ),
                    SizedBox(height: Dimensions.SBHeight10),
                    Image.asset(
                      'lib/assets/instruction/base.png',
                      width: Dimensions.instructionCommonImageWidth,
                    ),
                    SizedBox(height: Dimensions.SBHeight10),
                    MyText(
                      text: "На странице базы находится список всех слов представленных в приложении. У слов, значение которых может вызвать затруднение, имеется иконка с знаком вопроса. При нажатии на эту иконку откроется определение слова. Слово, которое подсвечиваются синим цветом, уже добавлено в какую-то коллекцию.",
                      size: Dimensions.instructionTextSize,
                    ),


                    SizedBox(height: Dimensions.SBHeight20),
                    MyText(
                        text: "Коллекция",
                        size: Dimensions.instructionTitleSize,
                        weight: FontWeight.bold,
                    ),
                    SizedBox(height: Dimensions.SBHeight20),
                    Image.asset(
                      'lib/assets/instruction/collection_button.png',
                      width: Dimensions.instructionCommonImageWidth,
                    ),
                    SizedBox(height: Dimensions.SBHeight10),
                    MyText(
                        text: "На кнопке коллекции есть включатель. Когда база выключена, слова из включенных коллекций объединяются и тестирование происходит по ним. Однако вы не сможете пройти тестирование более чем по 50 вопросам.",
                        size: Dimensions.instructionTextSize,
                    ),
                    SizedBox(height: Dimensions.SBHeight10),
                    MyText(
                        text: "Чтобы удалить коллекцию зажмите кнопку. При коротком нажатии на кнопку вы перейдете на страницу коллекции.",
                        size: Dimensions.instructionTextSize,
                    ),
                    SizedBox(height: Dimensions.SBHeight10),
                    Image.asset(
                      'lib/assets/instruction/collection.png',
                      width: Dimensions.instructionCommonImageWidth,
                    ),
                    SizedBox(height: Dimensions.SBHeight10),
                    MyText(
                        text: "Страница коллекции представлена списком добавленных слов и карточками. Чтобы начать обучение по карточкам, нажмите на иконку, которая на изображении обведена красным кругом.",
                        size: Dimensions.instructionTextSize,
                    ),
                    SizedBox(height: Dimensions.SBHeight10),
                    MyText(
                        text: "Чтобы добавить новых слов в коллекцию, нажмите на кнопку добавить внизу экрана.",
                        size: Dimensions.instructionTextSize,
                    ),
                    SizedBox(height: Dimensions.SBHeight10),
                    Image.asset(
                      'lib/assets/instruction/add_words_dialog.png',
                      width: Dimensions.instructionCommonImageWidth,
                    ),
                    SizedBox(height: Dimensions.SBHeight10),
                    MyText(
                        text: "Вам откроется диологовое окно, в котором вы можете выбрать слова автоматически или вручную. Для добавления слов автоматически выберите интересующее вас количество с помощью ползунка и нажмите на соответсвующую кнопку. Из базы выберутся случайные слова, которые не присутствуют ни в одной из ваших коллекций. Если таковых нашлось недостаточно, они дополнятся словами, которые не присутствуют только в данной коллекции. При нажатии на кнопку «Выбрать самостоятельно» вы перейдете на страницу выбора слов.",
                        size: Dimensions.instructionTextSize,
                    ),
                    Image.asset(
                      'lib/assets/instruction/add_words_manually_page.png',
                      width: Dimensions.instructionCommonImageWidth,
                    ),
                    SizedBox(height: Dimensions.SBHeight10),
                    MyText(
                        text: "Чтобы добавить слово в коллекцию, поставьте галочку в кружке рядом с словом. Слова, которые подсвечиваются синим цветом, уже присутствуют в какой-то из ваших коллекций. Слова, рядом с которыми стоит синяя галочка, уже добавлены в данную коллекцию.",
                        size: Dimensions.instructionTextSize,
                    ),
                    SizedBox(height: Dimensions.SBHeight10),
                    Image.asset(
                      'lib/assets/instruction/delete_word.png',
                      width: Dimensions.instructionCommonImageWidth,
                    ),
                    SizedBox(height: Dimensions.SBHeight10),
                    MyText(
                        text: "Смахните слово влево и нажмите на иконку с корзиной, чтобы удалить его из коллекции.",
                        size: Dimensions.instructionTextSize,
                    ),

                    SizedBox(height: Dimensions.SBHeight20),
                    MyText(
                        text: "Карточки",
                        size: Dimensions.instructionTitleSize,
                        weight: FontWeight.bold,
                    ),
                    SizedBox(height: Dimensions.SBHeight20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(
                          'lib/assets/instruction/card_mode_question.png',
                           width: Dimensions.instructionPairImageWidth,
                        ),
                        Image.asset(
                          'lib/assets/instruction/card_mode_answer.png',
                           width: Dimensions.instructionPairImageWidth,
                        ),
                      ],
                    ),
                    SizedBox(height: Dimensions.SBHeight10),
                    MyText(
                        text: "Карточки предназначены для быстрого и эффективного запоминания слов в коллекции. Вы читаете вопрос, делаете предположение, нажатием на карточку переворачивайте ее и сверяете ваш ответ с правильным. Если ответ совпал нажимаете кнопку «Знал», и карточка убирается из колоды. В противном случае нажимаете «Не знал», и карточка отправляется в случайное место в колоде. Вы будете встречать ее снова и снова, пока не запомните правильный ответ.",
                        size: Dimensions.instructionTextSize,
                    ),


                    SizedBox(height: Dimensions.SBHeight20),
                    MyText(
                        text: "Тестирование",
                        size: Dimensions.instructionTitleSize,
                        weight: FontWeight.bold,
                    ),
                    SizedBox(height: Dimensions.SBHeight20),
                    Image.asset(
                            'lib/assets/instruction/test_page.png',
                            width: Dimensions.instructionCommonImageWidth,
                    ),
                    SizedBox(height: Dimensions.SBHeight10),
                    MyText(
                        text: "Выберите раздел по которому вы хотите пройти тестирование в меню, расположенном в левом верхнем углу. Далее выберите интересующее количество слов и нажмите кнопку «Начать». Обратите внимание, что, если база и все коллекции выключены или включены лишь пустые коллекции, начать тестирование вы по понятным причинам не сможете. Тест представлен вопросами с вариантами ответа. Чтобы выбрать вариант нажмите на него.",
                        size: Dimensions.instructionTextSize,
                    ),
                ],
              ),
            )
          ),
        ),
      ),
      );
  }
}