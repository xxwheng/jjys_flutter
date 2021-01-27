import 'dart:ffi';
import 'dart:math';
import 'dart:ui';

import 'package:adaptui/adaptui.dart';
import 'package:demo/common/color.dart';
import 'package:flutter/material.dart';

/* 月嫂能力图 顶部顶点开始 逆时针16项 */
class YsChartWidget extends StatelessWidget {
  /* 各顶点距离中心值(0-1) */
  final List<double> values;

  /* 文本样式 */
  final TextStyle _style =
      TextStyle(fontSize: AdaptUI.rpx(24), color: UIColor.hex999);

  YsChartWidget({Key key, this.values}) : super(key: key);

  /* 计算角度 */
  double angleSp(int i) {
    return 360.0 / values.length * i * (pi / 180);
  }

  @override
  Widget build(BuildContext context) {
    double size = AdaptUI.rpx(350);
    return Container(
      height: AdaptUI.rpx(430),
      margin: EdgeInsets.only(top: AdaptUI.rpx(30), bottom: AdaptUI.rpx(30)),
      child: Stack(
        children: [
          Center(
            child: Container(
              child: RepaintBoundary(
                child: CustomPaint(
                  size: Size(size, size),
                  painter: YsChartPainter(
                    values: values,
                    width: size,
                    fillColor: Color(0xffd0a1f1),
                    beginPoint: 1,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
              left: 0,
              right: 0,
              child: Text(
                "宝宝护理",
                textAlign: TextAlign.center,
                style: _style,
              )),
          Positioned(
              top: AdaptUI.rpx(20),
              right: AdaptUI.screenWidth / 2 + AdaptUI.rpx(75),
              child: Text(
                "妈妈护理",
                style: _style,
              )),
          Positioned(
              top: AdaptUI.rpx(20),
              left: AdaptUI.screenWidth / 2 + AdaptUI.rpx(75),
              child: Text(
                "教育背景",
                style: _style,
              )),
          Positioned(
              top: AdaptUI.rpx(65),
              right: AdaptUI.screenWidth / 2 + AdaptUI.rpx(135),
              child: Text(
                "常见疾病预防",
                style: _style,
              )),
          Positioned(
              top: AdaptUI.rpx(65),
              left: AdaptUI.screenWidth / 2 + AdaptUI.rpx(135),
              child: Text(
                "普通话",
                style: _style,
              )),
          Positioned(
              top: AdaptUI.rpx(130),
              right: AdaptUI.screenWidth / 2 + AdaptUI.rpx(170),
              child: Text(
                "异常问题处理",
                style: _style,
              )),
          Positioned(
              top: AdaptUI.rpx(130),
              left: AdaptUI.screenWidth / 2 + AdaptUI.rpx(170),
              child: Text(
                "形象气质",
                style: _style,
              )),
          Positioned(
              top: AdaptUI.rpx(200),
              right: AdaptUI.screenWidth / 2 + AdaptUI.rpx(185),
              child: Text(
                "母乳喂养指导",
                style: _style,
              )),
          Positioned(
              top: AdaptUI.rpx(200),
              left: AdaptUI.screenWidth / 2 + AdaptUI.rpx(185),
              child: Text(
                "证书种类",
                style: _style,
              )),
          Positioned(
              bottom: AdaptUI.rpx(130),
              right: AdaptUI.screenWidth / 2 + AdaptUI.rpx(170),
              child: Text(
                "人工喂养定制",
                style: _style,
              )),
          Positioned(
              bottom: AdaptUI.rpx(130),
              left: AdaptUI.screenWidth / 2 + AdaptUI.rpx(170),
              child: Text(
                "沟通技巧",
                style: _style,
              )),
          Positioned(
              bottom: AdaptUI.rpx(65),
              right: AdaptUI.screenWidth / 2 + AdaptUI.rpx(135),
              child: Text(
                "二便观察",
                style: _style,
              )),
          Positioned(
              bottom: AdaptUI.rpx(65),
              left: AdaptUI.screenWidth / 2 + AdaptUI.rpx(135),
              child: Text(
                "早教启蒙",
                style: _style,
              )),
          Positioned(
              bottom: AdaptUI.rpx(20),
              right: AdaptUI.screenWidth / 2 + AdaptUI.rpx(75),
              child: Text(
                "生长指标观察",
                style: _style,
              )),
          Positioned(
              bottom: AdaptUI.rpx(20),
              left: AdaptUI.screenWidth / 2 + AdaptUI.rpx(75),
              child: Text(
                "月子营养搭配",
                style: _style,
              )),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Text(
                "行业经验",
                textAlign: TextAlign.center,
                style: _style,
              )),
        ],
      ),
    );
  }
}

/* 等边多边形绘制 */
class YsChartPainter extends CustomPainter {
  YsChartPainter(
      {Key key, this.values, this.width, this.beginPoint, this.fillColor});

  List<double> values;

  /* 整体宽高 */
  double width;

  /* 方位 1 顶部 、  2 右边  、  3 下边  、  4 左边  */
  int beginPoint;

  /* 每一边对应的角度角度 */
  double _angle;

  /* 半径 */
  double _r;

  /* 填充颜色 */
  Color fillColor;

  /* 画笔 */
  Paint _paint;

  /* 初始化数据 */
  void initData() {
    _angle = 360.0 / values.length;
    _r = width / 2;
    _paint = Paint();
  }

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    initData();
    drawPathFilled(canvas);
  }

  /* 绘制路径 并填充 */
  void drawPathFilled(Canvas canvas) {
    _paint.isAntiAlias = true;
    _paint.strokeWidth = 1;
    var _pointsList = this.circleSidePoints();
    this.drawBgPie(canvas, _pointsList);
    this.drawLines(canvas, _pointsList);
    this.drawValuePie(canvas);
  }

  // 背景16边型
  void drawBgPie(Canvas canvas, List<Offset> pointList) {
    _paint.style = PaintingStyle.fill;
    _paint.color = fillColor;
    var _path = Path();
    _path.moveTo(_r, 0);
    pointList.forEach((element) {
      _path.lineTo(element.dx, element.dy);
    });
    _path.close();
    canvas.drawPath(_path, _paint);
  }

  // 放射线
  void drawLines(Canvas canvas, List<Offset> pointList) {
    _paint.style = PaintingStyle.stroke;
    _paint.color = Colors.white;
    _paint.strokeWidth = 0.8;
    var _linePath = Path();
    pointList.forEach((element) {
      _linePath.moveTo(_r, _r);
      _linePath.lineTo(element.dx, element.dy);
      canvas.drawPath(_linePath, _paint);
    });
  }

  // 能力值图
  void drawValuePie(Canvas canvas) {
    _paint.style = PaintingStyle.fill;
    _paint.color = Color.fromARGB(200, 255, 192, 1); //Color(0xaaccdd00);
    var _valuePath = Path();
    _valuePath.moveTo(_r, _r - _r * values[0]);
    var valuePointList = this.circleSideValuePoints();
    valuePointList.forEach((element) {
      _valuePath.lineTo(element.dx, element.dy);
    });
    _valuePath.close();
    canvas.drawPath(_valuePath, _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    // 由于动画需要重绘，所以返true。避免重绘，交由RepaintBoundary处理。你也可以判断动画是否执行完成来处理时候重绘
    return true;
  }

  /* 边上顶点列表
  *
  *   index: 从那个方位开始（默认1 顶部）
  *   1 顶部 、  2 右边  、  3 下边  、  4 左边
  *   sideNum: 几边形
  *   return: 边上顶点列表（Offset）
  * */
  List<Offset> circleSidePoints() {
    List<Offset> list = [];
    for (var i = 0; i < values.length; i++) {
      Offset point;
      switch (beginPoint) {
        case 1:
          point = Offset(_r - sin(angleSp(i)) * _r, _r - cos(angleSp(i)) * _r);
          break;
        case 2:
          point = Offset(_r + cos(angleSp(i)) * _r, _r - sin(angleSp(i)) * _r);
          break;
        case 3:
          point = Offset(_r + sin(angleSp(i)) * _r, _r + cos(angleSp(i)) * _r);
          break;
        case 4:
          point = Offset(_r - cos(angleSp(i)) * _r, _r + sin(angleSp(i)) * _r);
          break;
        default:
          point = Offset(_r - sin(angleSp(i)) * _r, _r - cos(angleSp(i)) * _r);
      }
      list.add(point);
    }
    return list;
  }

  /* 边上顶点列表
  *
  *   index: 从那个方位开始（默认1 顶部）
  *   1 顶部 、  2 右边  、  3 下边  、  4 左边
  *   return: 边上顶点列表（Offset）
  * */
  List<Offset> circleSideValuePoints() {
    List<Offset> list = [];
    for (var i = 0; i < values.length; i++) {
      Offset point;
      switch (beginPoint) {
        case 1:
          point = Offset(_r - sin(angleSp(i)) * _r * values[i],
              _r - cos(angleSp(i)) * _r * values[i]);
          break;
        case 2:
          point = Offset(_r + cos(angleSp(i)) * _r * values[i],
              _r - sin(angleSp(i)) * _r * values[i]);
          break;
        case 3:
          point = Offset(_r + sin(angleSp(i)) * _r * values[i],
              _r + cos(angleSp(i)) * _r * values[i]);
          break;
        case 4:
          point = Offset(_r - cos(angleSp(i)) * _r * values[i],
              _r + sin(angleSp(i)) * _r * values[i]);
          break;
        default:
          point = Offset(_r - sin(angleSp(i)) * _r * values[i],
              _r - cos(angleSp(i)) * _r * values[i]);
      }
      list.add(point);
    }
    return list;
  }

  /* 计算角度 */
  double angleSp(int i) {
    return _angle * i * (pi / 180);
  }
}
