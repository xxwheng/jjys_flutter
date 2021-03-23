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

class _TabBarControllerState extends State<TabBarController> {

  final List<Widget> _tabPagesList = [PageHome(), PageArticle(), PageOrder(), PageMine()];

  int _selectedIndex = 0;

  double alpha = 1.0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    App.switchIndex = _tabBarDidTap;
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
    super.dispose();
  }
}
