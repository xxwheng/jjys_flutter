import 'package:adaptui/adaptui.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo/components/pageList/page_dataSource.dart';
import 'package:demo/components/pageList/page_refresh_widget.dart';
import 'package:demo/data/bean_compute.dart';
import 'package:demo/data/global_data.dart';
import 'package:demo/network/manager/xx_network.dart';
import 'package:demo/utils/bus/data_bus.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

/*工作风采*/
class YsWorkShowPage extends StatefulWidget {
  final JJRoleType type;

  final String id;

  YsWorkShowPage({Key key, this.type, this.id}) : super(key: key);

  @override
  _YsWorkShowPageState createState() => _YsWorkShowPageState();
}

class _YsWorkShowPageState extends State<YsWorkShowPage>
    with MultiDataLine, PageDataSource<String> {
  final String key = "workKey";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLine<List<String>>(key).onLoading();
    onRefresh();
  }

  @override
  void loadPageData() {
    // TODO: implement loadPageData
    XXNetwork.shared.post(params: {
      "methodName": "YuesaoShowList",
      "yuesao_id": "46",
      "role": 1,
      "page": this.page,
      "size": this.size
    }).then((res) {
      var page = int.parse(res['page'].toString());
      var total = int.parse(res['total'].toString());
      parseWorkShowListCompute(res['data']).then((value) {
        addList(value, page, total);
        getLine<List<String>>(key).setData([...list]);
      });
    }).catchError((err) {
      this.endRefreshing(status: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("工作风采"),
        elevation: 0,
        centerTitle: true,
      ),
      body: getLine<List<String>>(key).addObserver(
          onRefresh: this.onRefresh,
          builder: (ctx, data, _) {
            return PageRefreshWidget(
              pageDataSource: this,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: AdaptUI.rpx(20),
                ),
                itemCount: list.length,
                itemBuilder: (ctx, index) {
                  return Container(
                    margin: EdgeInsets.only(top: AdaptUI.rpx(20)),
                    child: CachedNetworkImage(
                      imageUrl: list[index],
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            );
          }),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    dataBusDispose();
    super.dispose();
  }
}
