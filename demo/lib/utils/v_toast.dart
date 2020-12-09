
import 'dart:async';
import 'dart:ffi';

import 'package:fluttertoast/fluttertoast.dart';

class VToast {

  static show(String msg) {
    Fluttertoast.showToast(msg: msg, toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.CENTER);
  }

  static Future<void> showThen(String msg) async {
    Completer completer = Completer();
    Fluttertoast.showToast(msg: msg, gravity: ToastGravity.CENTER);
    Future.delayed(Duration(milliseconds: 1500), (){
      Fluttertoast.cancel();
      completer.complete();
    });
    return completer.future;
  }
}