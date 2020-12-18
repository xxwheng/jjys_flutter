import 'package:adaptui/adaptui.dart';
import 'package:demo/common/color.dart';
import 'package:demo/data/global_data.dart';
import 'package:demo/network/manager/xx_network.dart';
import 'package:demo/slice/safe_bottom_control.dart';
import 'package:flutter/material.dart';

class YsDetailBottomWidget extends StatefulWidget {

  final String id;
  final JJRoleType type;
  final bool isCollect;
  final VoidCallback onChat;
  final VoidCallback onMake;

  YsDetailBottomWidget({Key key, this.id, this.type, this.isCollect, this.onChat, this.onMake}): super(key: key);

  @override
  _YsDetailBottomWidgetState createState() => _YsDetailBottomWidgetState();
}

class _YsDetailBottomWidgetState extends State<YsDetailBottomWidget> {

  bool isLike;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLike = widget.isCollect;
  }

  void collectDidTap() {
    isLike ? collectCancel() : collectInsert();
  }

  void collectInsert() async {
    XXNetwork.shared.post(params: {
      "methodName":"YuesaoCollectInsert"
      ,"yuesao_id":widget.id,
      "role":widget.type.index
    }).then((value) {
      setState(() {
        isLike = true;
      });
    });
  }

  void collectCancel() async {
    XXNetwork.shared.post(params: {
      "methodName":"YuesaoCollectCancel"
      ,"yuesao_id":widget.id,
      "role":widget.type.index
    }).then((value) {
      setState(() {
        isLike = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeBottomControlWidget(
      height: AdaptUI.rpx(110),
      children: [
        Expanded(
            flex: 3,
            child: GestureDetector(
              onTapUp: (tag) => this.collectDidTap(),
              child: Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(isLike?"images/like_1.png":"images/like_0.png", width: AdaptUI.rpx(35), height: AdaptUI.rpx(35), fit: BoxFit.contain,),
                Text(isLike?" 已关注":" 关注", style: TextStyle(fontSize: AdaptUI.rpx(28)),)
              ],
            ),),
            ),
        ),

        Expanded(
            flex: 3,
            child: GestureDetector(
              onTapUp: (_)=> widget.onChat(),
                child: Container(
              color: UIColor.kOrange,
              child: Center(child: Text("在线咨询", style: TextStyle(color: Colors.white, fontSize: AdaptUI.rpx(28)),),) ,
            )),
            ),
         Expanded(
              flex: 5,
              child: GestureDetector(
                  onTapUp: (_) => widget.onMake(),
                  child: Container(
                color: UIColor.mainColor,
                child: Center(child: Text("立即预约", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: AdaptUI.rpx(32)),),) ,
              )),
        )
        ,
      ],
    );
  }
}
