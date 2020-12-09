import 'package:adaptui/adaptui.dart';
import 'package:demo/common/color.dart';
import 'package:flutter/material.dart';

/* 技能信息 雇主评分、认证信息 */
class YsDetailSkillWidget extends StatelessWidget {
  final int score;

  final String experience;

  final String services;

  final String duration;
  /* 认证信息点击 */
  final VoidCallback authInfoRowTap;

  YsDetailSkillWidget({Key key, this.score, this.experience, this.services, this.duration, this.authInfoRowTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        this.rowBottomBorder(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "雇主评分",
                style: TextStyle(
                    color: UIColor.hex333,
                    fontSize: AdaptUI.rpx(32),
                    fontWeight: FontWeight.w500),
              ),
              Container(
                child: Row(
                  children: [
                    ...List.generate(
                      score,
                      (index) => Container(
                        margin: EdgeInsets.only(left: 2),
                        width: AdaptUI.rpx(26),
                        height: AdaptUI.rpx(26),
                        child: Image.asset(
                          "images/ys_heart.png",
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: AdaptUI.rpx(10)),
                      child: Text("$score分"),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        this.rowBottomBorder(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              this.ysExperienceRowWidget(
                  "护理经验 ", "${experience ?? 0}年"),
              this.ysExperienceRowWidget(
                  "服务家庭数 ", "${services ?? 0}个"),
              this.ysExperienceRowWidget(
                  "培训课时 ", "${duration ?? 0}个"),
            ],
          ),
        ),
        GestureDetector(
          onTap: this.authInfoRowTap,
          child: this.rowBottomBorder(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "认证信息",
                  style: TextStyle(
                      color: UIColor.hex333,
                      fontSize: AdaptUI.rpx(32),
                      fontWeight: FontWeight.w500),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: UIColor.hex999,
                  size: AdaptUI.rpx(40),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /* 护理经验 单个 */
  Widget ysExperienceRowWidget(String title, String content) {
    return RichText(
        text: TextSpan(children: [
          TextSpan(
              text: title,
              style: TextStyle(color: UIColor.hex333, fontSize: AdaptUI.rpx(30))),
          TextSpan(
              text: content,
              style: TextStyle(color: UIColor.mainColor, fontSize: AdaptUI.rpx(30)))
        ]),);
  }

  /* 底部有下划线的横向栏 */
  Widget rowBottomBorder({Widget child}) {
    return Container(
      padding: EdgeInsets.only(left: AdaptUI.rpx(30), right: AdaptUI.rpx(30)),
      height: AdaptUI.rpx(90),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: UIColor.hexEEE)),
      ),
      child: child,
    );
  }
}
