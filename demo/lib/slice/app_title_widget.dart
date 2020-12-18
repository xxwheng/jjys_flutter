import 'package:demo/data/corp_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppTitleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CorpData>(
        builder: (context, corp, _) => Text(corp.corpBean.titleJiaJia));
  }
}
