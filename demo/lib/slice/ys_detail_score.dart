import 'package:adaptui/adaptui.dart';
import 'package:demo/common/color.dart';
import 'package:demo/model/xx_int_title.dart';
import 'package:demo/slice/heart_row.dart';
import 'package:flutter/material.dart';

/* 用户评分 */
class YsDetailScoreWidget extends StatelessWidget {

  final int commentNum;
  final double avg;
  final List<XXDoubleTitleBean> scoreList;
//  final int babyNurse;
//  final int babyEdu;
//  final int food;
//  final int science;
//  final int momNurse;
//  final int communicate;
//  ["宝宝护理", "宝宝早教", "膳食搭配", "科学素养", "产妇护理", "沟通技巧"]
  YsDetailScoreWidget({Key key, this.commentNum, this.avg, this.scoreList}): super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: AdaptUI.rpx(20)),
      padding: EdgeInsets.all(AdaptUI.rpx(30)),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: Text("用户评价($commentNum)", style: TextStyle(fontSize: AdaptUI.rpx(32)),)),
              heartLineWidget("综合评分", avg, MainAxisAlignment.end)
            ],
          ),
          Container(height: AdaptUI.rpx(30),),
          Wrap(
            spacing: AdaptUI.rpx(20),
            runSpacing: AdaptUI.rpx(20),
            children: scoreList.map((e) => heartLineWidget(e.title, e.num))
                .toList(),
          )
        ],
      ),
    );
  }

  /* 评分widget title+heart+score */
  Widget heartLineWidget(String title, double score, [MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start]) {
    return
      Container(
        width: AdaptUI.rpx(335),
        child:
        Row(
          mainAxisAlignment: mainAxisAlignment,
          children: [
            Container(
              margin: EdgeInsets.only(right: AdaptUI.rpx(10)),
              child: Text(title, style: TextStyle(fontSize: AdaptUI.rpx(28)),),
            ),
            HeartScoreRow(score: score,)
          ],
        ),
      );
  }
}
