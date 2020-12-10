import 'package:adaptui/adaptui.dart';
import 'package:demo/common/color.dart';
import 'package:demo/data/global_data.dart';
import 'package:flutter/material.dart';

/* 月嫂详情服务内容模型 */
class YsServiceItemBean {
  String title;
  Widget widget;

  YsServiceItemBean(this.title, this.widget);
}

/* 详情服务内容数据 */
class YsServiceListData {
  static List<YsServiceItemBean> serviceList(JJRoleType type) {
    switch (type) {
      case JJRoleType.matron:
        return _ysServiceList;
      case JJRoleType.nurse:
        return _yyServiceList;
      default:
        return [];
    }
  }

  /* 育婴 */
  static List<YsServiceItemBean> get _yyServiceList {
    final List<String> yyServerTitles = [
      "科学喂养",
      "二便培养",
      "四浴护理",
      "动作技能训练",
      "语言表达能力",
      "社会行为训练",
      "婴幼儿感官刺激",
      "生活技能训练",
      "安全意识养成"
    ];
    return List.generate(
        yyServerTitles.length,
        (index) => YsServiceItemBean(yyServerTitles[index],
            Image.asset("images/yy_d_$index.png", fit: BoxFit.cover)));
  }

  /* 月嫂 */
  static List<YsServiceItemBean> get _ysServiceList {
    final List<String> ysServerTitles = [
      "基本护理",
      "科学喂养",
      "宝宝早教",
      "产后恢复",
      "月子餐",
      "母婴护理"
    ];
    return List.generate(
        ysServerTitles.length,
        (index) => YsServiceItemBean(ysServerTitles[index],
            Image.asset("images/ys_d_$index.png", fit: BoxFit.cover)));
  }
}

/* 服务内容 */
class YsDetailServiceWidget extends StatelessWidget {
  final VoidCallback onMoreTap;

  /* 角色 */
  final JJRoleType type;

  YsDetailServiceWidget({Key key, this.type, this.onMoreTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: AdaptUI.rpx(30)),
      padding: EdgeInsets.all(AdaptUI.rpx(30)),
      color: Colors.white,
      child: Column(children: [
        GestureDetector(
          onTap: onMoreTap,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "服务内容",
                  style: TextStyle(fontSize: AdaptUI.rpx(32)),
                ),
              ),
              Text(
                "查看更多",
                style:
                    TextStyle(fontSize: AdaptUI.rpx(30), color: UIColor.hex666),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: AdaptUI.rpx(30),
                color: UIColor.hex999,
              )
            ],
          ),
        ),
        Container(
          height: AdaptUI.rpx(30),
        ),
        Wrap(
          spacing: AdaptUI.rpx(14),
          runSpacing: AdaptUI.rpx(20),
          children: YsServiceListData.serviceList(type)
              .map((e) => Container(
                    width: AdaptUI.rpx(220),
                    height: AdaptUI.rpx(240),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: AdaptUI.rpx(10)),
                          width: AdaptUI.rpx(220),
                          height: AdaptUI.rpx(180),
                          child: e.widget,
                        ),
                        Text(
                          e.title,
                          style: TextStyle(
                              fontSize: AdaptUI.rpx(30), color: UIColor.hex666),
                        )
                      ],
                    ),
                  ))
              .toList(),
        ),
      ]),
    );
  }
}
