import 'package:adaptui/adaptui.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo/common/color.dart';
import 'package:demo/data/global_data.dart';
import 'package:demo/utils/ys_level.dart';
import 'package:flutter/material.dart';

/* 月嫂头像 等级 */
class YuesaoHeadLevelWidget extends StatelessWidget {
  final String headUrl;
  final String level;

  /// 角色
  final JJRoleType type;
  final String careType;

  YuesaoHeadLevelWidget(
      {Key key,
      @required this.headUrl,
      @required this.level,
      this.type = JJRoleType.matron,
      this.careType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (type == JJRoleType.matron || type == JJRoleType.nurse) {
      return hasLevelWidget();
    } else {
      return otherWidget();
    }
  }

  /* 月嫂 育婴师  有等级的 */
  Widget hasLevelWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(AdaptUI.rpx(8)),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Color(0xaacc3399), width: 1),
          ),
          child: Container(
            width: AdaptUI.rpx(140),
            height: AdaptUI.rpx(140),
            child: ClipOval(
              child: //headUrl == null || headUrl.isEmpty ? Image(image: AssetImage("images/place_head.png")) :
                  CachedNetworkImage(
                placeholder: (context, url) =>
                    Image(image: AssetImage("images/place_head.png")),
                imageUrl: headUrl ?? '',
                fit: BoxFit.cover,
                errorWidget: (context, url, error) =>
                    Image(image: AssetImage("images/place_head.png")),
              ),
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: UIColor.fontLevel, width: 1),
            ),
          ),
        ),
        Container(
            margin: EdgeInsets.only(top: AdaptUI.rpx(12)),
            width: AdaptUI.rpx(12),
            height: AdaptUI.rpx(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xB2cc3399),
            ),
        ),
         Container(
            margin: EdgeInsets.only(top: AdaptUI.rpx(8)),
            width: AdaptUI.rpx(10),
            height: AdaptUI.rpx(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0x7fcc3399),
            ),
        ),
        Container(
            margin: EdgeInsets.only(top: AdaptUI.rpx(8)),
            width: AdaptUI.rpx(8),
            height: AdaptUI.rpx(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0x4ccc3399),
            ),
        ),
        Container(
          margin: EdgeInsets.only(top: AdaptUI.rpx(10)),
          child: Text(
            type == JJRoleType.matron
                ? YsLevel.getYuesaoLevel(level)
                : YsLevel.getYuyingLevel(level, type: careType),
            style: TextStyle(
                fontSize: AdaptUI.rpx(28),
                fontWeight: FontWeight.w500,
                color: Color(0xffcc3399)),
          ),
        )
      ],
    );
  }

  /* 催乳、摄影、短单   无技师 无等级的 ，只有头像 */
  Widget otherWidget() {
    return Container(
      width: AdaptUI.rpx(148),
      height: AdaptUI.rpx(148),
      child: ClipOval(
        child: //headUrl == null || headUrl.isEmpty ? Image(image: AssetImage("images/place_head.png")) :
            CachedNetworkImage(
          placeholder: (context, url) =>
              Image(image: AssetImage("images/place_head.png")),
          imageUrl: headUrl ?? '',
          fit: BoxFit.cover,
          errorWidget: (context, url, error) =>
              Image(image: AssetImage("images/place_head.png")),
        ),
      ),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: UIColor.hexEEE, width: 1),
      ),
    );
  }
}
