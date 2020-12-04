import 'package:demo/data/corp_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


/// 订单-tab
class PageOrder extends StatefulWidget {
  @override
  _PageOrderState createState() => _PageOrderState();
}

class _PageOrderState extends State<PageOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<CorpData>(
            builder: (context, corp, _) => Text(corp.corpBean.titleJiaJia)
        ),
        centerTitle: true,
        elevation: 0,
      ),
    );
  }
}
