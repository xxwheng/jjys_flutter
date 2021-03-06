import 'package:demo/components/pageList/page_interface.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PageDataSource<T> implements PageInterface {
  /* 页码 */
  int page = 1;
  /* 是否更多 */
  bool hasMore = true;
  /* 每页数据量 */
  int size = 20;
  /* 列表数据 */
  List<T> list = [];
  /* 刷新加载 */
  final RefreshController refreshController = RefreshController();

  /// 是否可以上拉加载（第一页、有数据 true）
  bool enablePullUp = false;

  @override
  void onRefresh() async {
    // TODO: implement _onRefresh
    page = 1;
    loadPageData();
  }

  @override
  void onLoadMore() async {
    // TODO: implement _onLoadMore
    if (hasMore) {
      loadPageData();
    }
  }

  @override
  void loadPageData() async {
    // TODO: implement _loadPageData
  }

  void addList(List<T> list, int page, int total) {

    var tempList = this.list;
    if (this.page == 1) {
      enablePullUp = list.length > 0;
      tempList = [];
    }

    tempList.addAll(list);

    // 有时会出现数量异常，这里加入新返回列表不为空判断
    hasMore = (tempList.length < total) && list.isNotEmpty;

    if (hasMore) {
      page += 1;
    }
    this.page = page;

    this.list = tempList;
    endRefreshing();
  }


  /* 结束刷新/加载  status 成功/失败 */
  void endRefreshing({bool status = true}) {
    if (status) {
      if (refreshController.isRefresh) {
        /// 正在刷新
        refreshController.refreshCompleted(resetFooterState: true);
      } else if (refreshController.isLoading) {
        /// 正在加载
        if (hasMore) {
          refreshController.loadComplete();
        } else {
          refreshController.loadNoData();
        }
      }
      /// 第一页刚加载
      if (hasMore) {
        refreshController.loadComplete();
      } else {
        refreshController.loadNoData();
      }
    } else {
      if (refreshController.isRefresh) {
        refreshController.refreshFailed();
      }
      if (refreshController.isLoading) {
        refreshController.loadFailed();
      }
    }
  }
}