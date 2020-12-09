import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {

  static void show(BuildContext context) {
    showDialog(context: context, builder: (ctx) => Loading());
  }

  static void dismiss(context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Center(
        child: Container(
          width: 60,
          height: 60,
          child: SpinKitCircle(color: Colors.grey,),
        ),
      ),
    );
  }
}
