
import 'package:fluttertoast/fluttertoast.dart';

class ToastRow {
  bool verify;
  String hint;
  ToastRow(this.verify, this.hint);
}

class ToastUtil {

  /* 校验一系列验证 */
  static bool judgeList(List<ToastRow> tipList) {
    tipList.forEach((element) {
      if (!element.verify) {
        Fluttertoast.showToast(msg: element.hint);
        return false;
      }
    });
    return true;
  }
}