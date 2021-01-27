import 'package:adaptui/adaptui.dart';
import 'package:demo/common/color.dart';
import 'package:demo/common/common.dart';
import 'package:demo/network/manager/xx_network.dart';
import 'package:demo/utils/multi_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/*提交订单 联系人信息 */
// ignore: must_be_immutable
class OrderContactYsWidget extends StatefulWidget {

  String getNickName = "";
  String getMobile = "";
  String getProvince = "";
  String getCity = "";
  String getTown = "";
  String getAddress = "";

  @override
  _OrderContactYsWidgetState createState() => _OrderContactYsWidgetState();
}

class _OrderContactYsWidgetState extends State<OrderContactYsWidget> {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _telController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  ProvinceData _data;
  ProvincePicker _picker;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _data = ProvinceData()..initData().then((_)=>loadAddressLast());
    _nameController.addListener(() {
      widget.getNickName = _nameController.text;
    });
    _telController.addListener(() {
      widget.getMobile = _telController.text;
    });
    _addressController.addListener(() {
      widget.getAddress = _addressController.text;
    });
  }

  void loadAddressLast() {
    XXNetwork.shared.post(params: {
      "methodName":"AddressLast"
    }).then((value) {
      var nickName = value['nickname'].toString();
      var mobile = value['mobile'].toString();
      var province = value['provice'].toString();
      var city = value['city'].toString();
      var town = value['town'].toString();
      var address = value['address'].toString();
      _nameController.text = nickName;
      _telController.text = mobile;
      _addressController.text = address;
      widget.getProvince = province;
      widget.getCity = city;
      widget.getTown = town;

      var areaInfo = _data.searchPCTItemFromCode(province, city, town);
      _areaController.text = areaInfo.map((e) => e.cityName).toList().join("   ");
    });
  }

  /* 选择省市区 */
  void chooseAreaPicker(_) {
    if (_picker == null) {
      _picker = ProvincePicker(context, _data, (list) {
        var text = list.map((e) => e.cityName).toList().join(" ");
        widget.getProvince = list[0].cityCode;
        widget.getCity = list[1].cityCode;
        widget.getTown = list[2].cityCode;
        _areaController.text = text;
      });
    }
    _picker.show();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(top: AdaptUI.rpx(30), left: AdaptUI.rpx(30), bottom: AdaptUI.rpx(20)),
          child: Text("联系信息", style: TextStyle(color: UIColor.hex666, fontSize: AdaptUI.rpx(30)),),
        ),
        rowInputWidget("联系人", _nameController, "请填写联系人姓名"),
        rowInputWidget("联系电话", _telController, "请填写联系人电话", keyboardType: TextInputType.phone),
        GestureDetector(
          onTapUp: chooseAreaPicker,
          child: rowInputWidget("选择地区", _areaController, "请选择省市地区", enabled: false),
        ),
        rowInputWidget("详细地址", _addressController, "请填写详细地址")
      ],
    );
  }

  Widget rowInputWidget(String title, TextEditingController controller, String placeholder, {bool enabled = true, TextInputType keyboardType = TextInputType.text}) {
    return Container(
      padding: EdgeInsets.only(left: AdaptUI.rpx(30), right: AdaptUI.rpx(30)),
      height: AdaptUI.rpx(110),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: UIColor.hexEEE))
      ),
      child: Row(
        children: [
          Container(
            width: AdaptUI.rpx(150),
            child: Text(title, style: TextStyle(fontSize: AdaptUI.rpx(30)),),
          ),
          Expanded(child: CupertinoTextField(
            enabled: enabled,
            controller: controller,
            decoration: null,
            placeholder: placeholder,
            keyboardType: keyboardType,
            style: TextStyle(fontSize: AdaptUI.rpx(30)),
          ))
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _nameController.dispose();
    _telController.dispose();
    _areaController.dispose();
    _addressController.dispose();
    super.dispose();
  }
}
