import 'package:demo/page/article/page_article.dart';
import 'package:demo/page/home/page_home.dart';
import 'package:demo/page/mine/page_mine.dart';
import 'package:demo/page/order/page_order.dart';
import 'package:demo/page/root/app.dart';
import 'package:flutter/material.dart';

import '../../common/color.dart';


class TabBarController extends StatefulWidget {

  @override
  _TabBarControllerState createState() => _TabBarControllerState();
}

class _TabBarControllerState extends State<TabBarController> with WidgetsBindingObserver {

  final List<Widget> _tabPagesList = [PageHome(), PageArticle(), PageOrder(), PageMine()];

  int _selectedIndex = 0;

  double alpha = 1.0;


  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    App.switchIndex = _tabBarDidTap;
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
  }

  void insertOverlayEntity() async {
    Future.delayed(Duration(seconds: 2), (){
      OverlayEntry _entry = OverlayEntry(
          builder: (context) {
            return Positioned(
                bottom: 150,
                right: 30,
                width: 80,
                height: 80,
                child: Offstage(
                  offstage: alpha==1.0 ? false : true,
                  child:  GestureDetector(
                  child: ClipOval(
                      child: Image.asset("", fit: BoxFit.cover,)
                  ),
                  onTapUp: (tap) {
                    print("float");
                  },
                ),
              ),);
          }
      );
      Overlay.of(context).insert(_entry);
    });

  }

  void _tabBarDidTap(index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  
  BottomNavigationBar createTabBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: UIColor.mainColor,
      unselectedItemColor: Color(0xff9d9d9d),
      backgroundColor: Colors.white,
      items: [
        BottomNavigationBarItem(icon: Image.asset("images/tab_home_n.png"), activeIcon: Image.asset("images/tab_home_s.png"), label: "首页"),
        BottomNavigationBarItem(icon: Image.asset("images/tab_article_n.png"), activeIcon: Image.asset("images/tab_article_s.png"), label: "文章"),
        BottomNavigationBarItem(icon: Image.asset("images/tab_order_n.png"), activeIcon: Image.asset("images/tab_order_s.png"), label: "订单"),
        BottomNavigationBarItem(icon: Image.asset("images/tab_mine_n.png"), activeIcon: Image.asset("images/tab_mine_s.png"), label: "我的"),
    ],
    currentIndex: _selectedIndex,
    onTap: _tabBarDidTap,);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
//      _tabPagesList[_selectedIndex],
      IndexedStack(
        index: _selectedIndex,
        children: _tabPagesList,
      ),
      bottomNavigationBar: createTabBar(),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
