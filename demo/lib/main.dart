import 'package:demo/common/color.dart';
import 'package:demo/common/common.dart';
import 'package:demo/data/corp_data.dart';
import 'package:demo/data/user_data.dart';
import 'package:demo/page/mine/login_page.dart';
import 'package:demo/page/root/tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:demo/page/root/app.dart';
import 'package:provider/provider.dart';

void main() {
  /* 初始化路由 */
  final FluroRouter router = FluroRouter();
  PageRoutes.configFluroRoutes(router);
  App.router = router;
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => CorpData()),
      ChangeNotifierProvider(create: (_) => UserData())
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData(primaryColor: UIColor.mainColor),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: App.router.generator,
      builder: (context, child) {
        return Scaffold(
          body: GestureDetector(
            /* 点击空白隐藏键盘 */
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus.unfocus();
              }
            },
            child: child,
          ),
        );
      },
      home: Scaffold(
        // appBar: AppBar(
        //   title: Text('Material App Bar'),
        // ),
        body: TabBarController(),
      ),
    );
  }
}
