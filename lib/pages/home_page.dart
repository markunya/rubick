import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:rubickk/consts.dart';
import 'package:rubickk/main.dart';
import 'package:rubickk/pages/test_page_for_ud.dart';
import 'package:rubickk/udarenia/study/udarenia.dart';
import 'package:rubickk/widgets.dart';
import 'package:rubickk/slovarnie_slova/study/slovarnie_slova.dart';
import 'package:rubickk/pages/tests_page_for_ss.dart';
import 'package:rubickk/bigwidgets/appbar_actions.dart';
import 'package:rubickk/dimensions.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>  with SingleTickerProviderStateMixin{
  int _selectedIndex = 0;

  List<Widget> _widgetOptions_ss = <Widget>[
    SlovarnieSlovaPage(),
    TestsPageForSS(),
  ];
   
  List<Widget> _widgetOptions_ud = <Widget>[
    UdareniaPage(),
    TestsPageForUd(),
  ];

   void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Tab> myTabs = <Tab>[
    Tab(text: AppStrings.tabBarChapter1,),
    Tab(text: AppStrings.tabBarChapter2,),
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      vsync: this,
      animationDuration: Duration.zero,
      length: myTabs.length,
      initialIndex: bools_in_bases.get(0).currentStudyPage == true ? 0 : 1);
  }


  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: BackdropScaffold(
          resizeToAvoidBottomInset : false,
          stickyFrontLayer: true,
          appBar: BackdropAppBar(
          backgroundColor: AppColors.appBarBackgroudColor,
          title: _selectedIndex == 0 ? MyText(text: AppStrings.ABStudy,
                          color: AppColors.textColor,
                          size: Dimensions.appBarFontSize,
                          weight: FontWeight.w700
                          ) : Container(
                            child: MyText( text: _tabController.index == 0 ? AppStrings.ABTestsSS : AppStrings.ABTestsUd,
                            color: AppColors.textColor,
                            size: Dimensions.appBarFontSize,
                            weight: FontWeight.w700),
                          ),
              actions: [
                      AppBarActions(),
                  ],   
              ),
           
          backLayerBackgroundColor: AppColors.appBarBackgroudColor,
          backLayer: Container(
            height: Dimensions.tabBarHeight,
            child: TabBar(
              onTap: (a) {
                setState((){});
                bools_in_bases.get(0).currentStudyPage = _tabController.index == 0 ? true : false;
                bools_in_bases.get(0).save();
              },
              indicatorColor: AppColors.tabBarIndicatorColor,
              controller: _tabController,
              tabs: myTabs,
              ),
          ),
          frontLayerShape: RoundedRectangleBorder(),
          frontLayerScrim: AppColors.invisible,
          frontLayer: Container(
            color: AppColors.backgroundColor,
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: [
                  Center(
                        child: _widgetOptions_ss.elementAt(_selectedIndex),
                  ),
                  Center(
                        child: _widgetOptions_ud.elementAt(_selectedIndex),
                  ),
              ]
            ),
          ),
        bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: const Icon(Icons.school),
                label: AppStrings.BNBLabelStudy,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.checklist),
                label: AppStrings.BNBLabelTests,
              ),
            ],
            backgroundColor: AppColors.bottomNavigationBarBackgroundColor,
            currentIndex: _selectedIndex,
            unselectedItemColor: AppColors.bottomNavigationBarNotSelectedItemColor,
            selectedItemColor: AppColors.bottomNavigationBarSelectedItemColor,
            onTap: _onItemTapped,
          ),
        ),
    );
  }
}