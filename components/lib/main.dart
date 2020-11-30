import 'package:components/components/menu_scroll.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: MenuScrollWidget(
          menuList: ["","","","","","","","","","",],
          child:Container(
              color: Colors.lightBlue,
            ),
        ),
      ),
    );
  }
}