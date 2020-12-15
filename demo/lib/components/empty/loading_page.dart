import 'package:demo/common/color.dart';
import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(UIColor.mainColor),
          strokeWidth: 2,
        ),
      ),
    );
  }
}
