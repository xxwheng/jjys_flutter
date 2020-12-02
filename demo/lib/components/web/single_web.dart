import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/* 单一网页浏览 */
class SingleWebPage extends StatelessWidget {

  final String url;

  final String title;

  SingleWebPage({Key key, this.title, this.url}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title ?? "家家月嫂"),),
      body: Container(
        child: WebView(
          initialUrl: url,
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    ) ;
  }
}
