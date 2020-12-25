import 'package:demo/common/common.dart';
import 'package:demo/utils/v_toast.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastRow {
  bool verify;
  String hint;
  ToastRow(this.verify, this.hint);

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'verify': this.verify,
      'hint': this.hint,
    };
  }
}

class ToastUtil {
  /* 校验一系列验证 */
  static bool judgeList(List<ToastRow> tipList) {
    for (int i = 0; i < tipList.length; i++) {
      if (!tipList[i].verify) {
        VToast.show(tipList[i].hint);
        return false;
      }
    }
    return true;
  }
}
