
import 'package:url_launcher/url_launcher.dart';

class HelperTool {

  static makeCall(String tel) async {

    if (await canLaunch("tel:$tel")) {
      await launch("tel:$tel");
    } else {
      print("异常");
    }
  }
}