import 'package:demo/components/singlePage/single_dataSource.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/* 单刷新页面（如 首页） */
class SingleRefreshWidget extends StatelessWidget {

  final Widget child;

  final SingleDataSource dataSource;

  SingleRefreshWidget({Key key, this.dataSource, this.child}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: true,
      controller: dataSource.refreshController,
      onRefresh: dataSource.onRefresh,
      header: WaterDropHeader(),
      child: child,
    );
  }
}
