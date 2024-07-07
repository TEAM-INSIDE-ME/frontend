import UIKit
import Flutter
import NaverThirdPartyLogin

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    
      NaverThirdPartyLoginConnection.getSharedInstance()?.isNaverAppOauthEnable = true
      NaverThirdPartyLoginConnection.getSharedInstance()?.isInAppOauthEnable = true

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

}
