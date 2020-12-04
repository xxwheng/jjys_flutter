import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/* 单独下拉刷新 页 */
class HomeRefreshPage extends StatelessWidget {

  final Widget child;

  final VoidCallback onRefresh;

  final RefreshController controller;

  HomeRefreshPage({Key key, this.controller, this.onRefresh, this.child}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: true,
      controller: controller,
      onRefresh: onRefresh,
      header: WaterDropHeader(),
      child: child,
    );
  }
}
