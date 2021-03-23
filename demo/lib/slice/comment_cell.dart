import 'package:adaptui/adaptui.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo/common/color.dart';
import 'package:demo/slice/heart_row.dart';
import 'package:flutter/material.dart';

class YsCommentCell extends StatelessWidget {

  final String headIcon;
  final String name;
  final String service;
  final double score;
  final String time;
  final String desc;
  final List<String> pics;

  YsCommentCell({Key key, this.headIcon, this.name, this.service, this.score, this.time, this.desc, this.pics}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(AdaptUI.rpx(30)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(right: AdaptUI.rpx(20)),
            child: ClipOval(
              child: Container(
                width: AdaptUI.rpx(90),
                height: AdaptUI.rpx(90),
                child: CachedNetworkImage(imageUrl: headIcon),
              ),
            ),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
    name,
                  style: TextStyle(
                      fontSize: AdaptUI.rpx(30), color: Colors.black),
                ),

                Container(
                  padding: EdgeInsets.only(top: AdaptUI.rpx(8)),
                  child: Row(
                    children: [
                      Text(
                        service,
                        style: TextStyle(
                            fontSize: AdaptUI.rpx(28), color: UIColor.hex666),
                      ),
                      HeartScoreRow(score: score),
                      Spacer(),
                      Text(
                        time,
                        style: TextStyle(
                            fontSize: AdaptUI.rpx(28), color: UIColor.hex999),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: AdaptUI.rpx(14)),
                  child: Text(desc,
                      style: TextStyle(
                          fontSize: AdaptUI.rpx(28), color: UIColor.hex333)),
                ),
                pics.length > 0 ? Container(
                  margin: EdgeInsets.only(top: AdaptUI.rpx(20)),
                  child: Wrap(
                    spacing: AdaptUI.rpx(10),
                    runSpacing: AdaptUI.rpx(10),
                    children: pics.map((e) => CachedNetworkImage(imageUrl: e, width: AdaptUI.rpx(186),
                        height: AdaptUI.rpx(186),),
                    ).toList(),
                  ),
                ) : Row()

//               Column(
//                 children: [
//                   GridView(
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 3,
//                       crossAxisSpacing: AdaptUI.rpx(10),
//                       mainAxisSpacing: AdaptUI.rpx(10),
//                     ),
//                     children: List.generate(
//                         3,
//                             (index) => Container(
//                           color: Colors.red,
//                         )),
//                   )
//                 ],
//               )
              ],
            ),
          )
        ],
      ),
    );
  }
}
