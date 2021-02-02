import UIKit
import Flutter
import SwiftyJSON

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {

    var nav: UINavigationController?

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    let controller: FlutterViewController = self.window.rootViewController as! FlutterViewController
//    let controller: FlutterViewController = FlutterViewController()
//    self.nav = UINavigationController.init(rootViewController: controller)
//    self.nav?.isNavigationBarHidden = true
//    self.window = UIWindow.init(frame: UIScreen.main.bounds)
//    self.window.rootViewController = self.nav
//    self.window.makeKeyAndVisible()

    let channel = FlutterMethodChannel.init(name: "com.jjys.ios", binaryMessenger: controller.binaryMessenger)
    channel.setMethodCallHandler { (call, result) in
        switch (call.method) {
        case FlutterCallMethod.gotoAbout:
            FlutterNativeBridge.gotoAbout(fromFlutter: controller)
            result(true)
            break;
        case FlutterCallMethod.gotoArticleWeb:
            let dic = JSON.init(call.arguments as Any)
            let id = dic["id"].stringValue
            let title = dic["title"].stringValue
            FlutterNativeBridge.gotoArticleWeb(id, title: title, fromFlutter: controller)
            break;
        default:
            result(FlutterMethodNotImplemented)
            break;
        }
    }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
