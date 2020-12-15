/* 页面状态 */
import 'package:demo/common/common.dart';
import 'package:demo/components/empty/error_page.dart';
import 'package:demo/components/empty/loading_page.dart';
import 'package:flutter/cupertino.dart';

enum PageDoneState {
  onLoading,
  onSuccess,
  onFailure,
  onNetError,
}

class PageLoading {

  Future<PageDoneState> future;

  final Widget _loadingPage = LoadingPage();

  Future<PageDoneState> startLoading() async {
  }

  Widget viewDidLoad({Future<PageDoneState> future, Widget Function(BuildContext context) builder, Widget loading}) {
    return FutureBuilder<PageDoneState>(
      future: future,
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
