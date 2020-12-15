
import 'package:demo/components/singlePage/single_refresh_interface.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SingleDataSource implements SingleRefreshInterface {

  /* 刷新加载 */
  final RefreshController refreshController = RefreshController();

  @override
  void onRefresh() {
    // TODO: implement onRefresh
  }

  /* 结束刷新/加载  status 成功/失败 */
  void endRefreshing({bool status = true}) {
    if (status) {
      if (refreshController.isRefresh) {
        /// 正在刷新
        refreshController.refreshCompleted();
      }
    } else {
      if (refreshController.isRefresh) {
        refreshController.refreshFailed();
      }

    }
  }
}