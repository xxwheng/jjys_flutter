import 'package:adaptui/adaptui.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo/common/color.dart';
import 'package:demo/slice/ys_name_auth.dart';
import 'package:flutter/material.dart';

/* 详情 头部 */
class YsDetailHeader extends StatelessWidget {

  final String nickName;

  final String headPhoto;

  final bool isCredit;

  final String provinceAgeText;

  final String price;

  final String service;

  final String levelText;

  YsDetailHeader({Key key, this.nickName, this.headPhoto, this.levelText, this.price, this.service, this.provinceAgeText, this.isCredit}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AdaptUI.rpx(470),
      child: Stack(
        children: [
          headPhoto!=null&&headPhoto.isNotEmpty ? CachedNetworkImage(
            imageUrl: headPhoto,
            fit: BoxFit.cover,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (ctx, url, err) => Icon(Icons.error)
          ) : Offstage(),
          Container(
            padding: EdgeInsets.only(
                left: AdaptUI.rpx(30), bottom: AdaptUI.rpx(50)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: AdaptUI.rpx(20)),
                  child: Text(
                    nickName,
                    style: TextStyle(
                        fontSize: AdaptUI.rpx(46),
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: AdaptUI.rpx(20)),
                  child: Text(
                    levelText,
                    style: TextStyle(
                        fontSize: AdaptUI.rpx(30),
                        color: UIColor.levelYellow),
                  ),
                ),
                isCredit
                    ? Container(
                  padding: EdgeInsets.only(bottom: AdaptUI.rpx(20)),
                  child: YsAuthWidget(),
                )
                    : Offstage(),
                Container(
                  padding: EdgeInsets.only(bottom: AdaptUI.rpx(20)),
                  child: Text(
                    provinceAgeText,
                    style: TextStyle(fontSize: AdaptUI.rpx(32)),
                  ),
                ),
                Container(
                  height: AdaptUI.rpx(10),
                ),
                RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: price,
                          style: TextStyle(
                              fontSize: AdaptUI.rpx(38),
                              fontWeight: FontWeight.bold,
                              color: UIColor.fontLevel)),
                      TextSpan(
                          text: service,
                          style: TextStyle(
                              fontSize: AdaptUI.rpx(28),
                              color: UIColor.hex666))
                    ]))
              ],
            ),
          )
        ],
      ),
    );
  }
}
