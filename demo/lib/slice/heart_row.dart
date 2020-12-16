import 'package:adaptui/adaptui.dart';
import 'package:demo/common/color.dart';
import 'package:flutter/material.dart';

class HeartScoreRow extends StatelessWidget {

  final double score;

  HeartScoreRow({Key key, this.score}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: List.generate(
            score.toInt(),
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
    );
  }
}
