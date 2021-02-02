import 'package:demo/common/color.dart';
import 'package:demo/data/corp_data.dart';
import 'package:demo/data/user_data.dart';
import 'package:demo/page/pay/xx_wxpay.dart';
import 'package:demo/page/root/tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:demo/page/root/app.dart';
import 'package:provider/provider.dart';
import 'package:xx_pay/xx_pay.dart';

void main() {
  /* 初始化路由 */
  final FluroRouter router = FluroRouter();
  PageRoutes.configFluroRoutes(router);
  App.router = router;
  App.tabBarController = TabBarController();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => CorpData()),
      ChangeNotifierProvider(create: (_) => UserData()),
    ],
    child: MyApp(),
  ));
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    ///  universalLink不能为空
    XxPay.wxRegisterApp("wx4ac4c47ec2e975db", "https://m.jjys168.com/userclient/");

    return MaterialApp(
      title: 'Material App',
      theme: ThemeData(primaryColor: UIColor.mainColor),
      /// debug标识
//      debugShowCheckedModeBanner: true,
      /// 网格调试
//      debugShowMaterialGrid: true,
      /// 性能检测
//      showPerformanceOverlay: true,

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
        body: App.tabBarController,
      ),
    );
  }
}
