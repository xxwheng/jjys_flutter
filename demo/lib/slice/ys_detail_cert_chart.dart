import 'package:adaptui/adaptui.dart';
import 'package:demo/common/color.dart';
import 'package:demo/slice/ys_chart.dart';
import 'package:flutter/material.dart';

/* 详情 证书、标签、能力图 */
class YsDetailCertChartWidget extends StatelessWidget {

  /* 证书 */
  final List<String> certTitles;
  /* 介绍 */
  final String introduce;
  /* 标签 */
  final List<String> label;
  /* 能力值 */
  final List<String> charts;

  YsDetailCertChartWidget({Key key, this.certTitles, this.introduce, this.label, this.charts}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
          left: AdaptUI.rpx(30),
          bottom: AdaptUI.rpx(30),
          top: AdaptUI.rpx(30)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: AdaptUI.rpx(20),
            runSpacing: AdaptUI.rpx(20),
            children: certTitles?.map(
                    (e) => Container(
                  padding: EdgeInsets.only(
                      left: AdaptUI.rpx(30),
                      top: AdaptUI.rpx(10),
                      bottom: AdaptUI.rpx(10),
                      right: AdaptUI.rpx(30)),
                  decoration: BoxDecoration(
                      color: UIColor.mainColor,
                      borderRadius: BorderRadius.all(
                          Radius.circular(AdaptUI.rpx(30)))),
                  child: Text(
                    e,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: AdaptUI.rpx(26)),
                  ),
                ),
              )?.toList() ?? [],
          ),
          Container(
            height: AdaptUI.rpx(30),
          ),
          Container(
            padding: EdgeInsets.only(right: AdaptUI.rpx(30)),
            child: Text(
              introduce ?? "",
              style: TextStyle(
                  color: UIColor.hex666, fontSize: AdaptUI.rpx(28)),
            ),
          ),
          Container(
            height: AdaptUI.rpx(30),
          ),
          Wrap(
            spacing: AdaptUI.rpx(20),
            runSpacing: AdaptUI.rpx(20),
            children: label?.map((e) => Container(
              padding: EdgeInsets.only(
                  left: AdaptUI.rpx(15),
                  right: AdaptUI.rpx(15),
                  top: AdaptUI.rpx(5),
                  bottom: AdaptUI.rpx(5)),
              decoration: BoxDecoration(
                  border: Border.all(color: UIColor.hex999),
                  borderRadius: BorderRadius.all(
                      Radius.circular(20))),
              child: Text(
                e,
                style: TextStyle(color: UIColor.mainColor),
              ),
            ))
                ?.toList() ??
                [],
          ),
          charts==null ? Offstage() : YsChartWidget(
            values: charts
                .map((e) => int.parse(e) / 100.0)
                .toList(),
          )
        ],
      ),
    );
  }
}
