
import 'package:demo/common/common.dart';
import 'package:demo/components/empty/empty.dart';
import 'package:demo/components/empty/error_page.dart';
import 'package:demo/components/empty/loading_page.dart';
import 'package:flutter/cupertino.dart';

mixin BasePageFutureInterface {

  bool first = true;

  Future<PageDoneState> future;

  final Widget _loadingPage = LoadingPage();

  void createFuture() {
    future = initFuture();
  }

  void resetFuture(setState) {
    setState((){
      future = initFuture();
    });
  }

  @required
  Future<PageDoneState> initFuture() async {

  }

  Widget futureBuilder({Future<PageDoneState> future, Widget Function(BuildContext context) builder, Widget loading}) {
    return FutureBuilder<PageDoneState>(
      future: future ?? this.future,
      initialData: PageDoneState.onLoading,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          logger.i("连接完成");
          switch (snapshot.data) {
            case PageDoneState.onSuccess:
              return builder(context);
              break;
            case PageDoneState.onFailure:
              return ErrorPage();
              break;
            case PageDoneState.onNetError:
              return ErrorPage();
              break;
            default:
              return ErrorPage();
              break;
          }
        } else {
          logger.i("正在连接");
          return loading ?? _loadingPage;
        }
      },
    );
  }
}