import 'package:adaptui/adaptui.dart';
import 'package:demo/common/color.dart';
import 'package:flutter/material.dart';

/* 用户评分 */
class YsDetailScoreWidget extends StatelessWidget {
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
              Expanded(child: Text("用户评价(10)", style: TextStyle(fontSize: AdaptUI.rpx(32)),)),
              heartLineWidget("综合评分", 5, MainAxisAlignment.end)
            ],
          ),
          Container(height: AdaptUI.rpx(30),),
          Wrap(
            spacing: AdaptUI.rpx(20),
            runSpacing: AdaptUI.rpx(20),
            children: ["宝宝护理", "宝宝早教", "膳食搭配", "科学素养", "产妇护理", "沟通技巧"]
                .map((e) => heartLineWidget(e, 5))
                .toList(),
          )
        ],
      ),
    );
  }

  /* 评分widget title+heart+score */
  Widget heartLineWidget(String title, int score, [MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start]) {
    return
      Container(
        width: AdaptUI.rpx(335),
        child:
        Row(
          mainAxisAlignment: mainAxisAlignment,
          children: [
            Container(
              margin: EdgeInsets.only(right: AdaptUI.rpx(10)),
              child: Text(title, style: TextStyle(fontSize: AdaptUI.rpx(30)),),
            ),
            Row(
              children: List.generate(
                score,
                    (index) => Container(
                  margin: EdgeInsets.only(left:AdaptUI.rpx(5)),
                  child: Image.asset(
                    "images/ys_heart.png",
                    width: AdaptUI.rpx(20),
                    height: AdaptUI.rpx(20),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: AdaptUI.rpx(10)),
              child: Text("$score分", style: TextStyle(fontSize: AdaptUI.rpx(28), color: UIColor.hex666),),
            )
          ],
        ),
      );
  }
}
