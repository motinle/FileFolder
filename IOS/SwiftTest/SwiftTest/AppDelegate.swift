//
//  AppDelegate.swift
//  SwiftTest
//
//  Created by Motinle on 2021/10/8.
//

import UIKit
import FlutterPluginRegistrant

@main
class AppDelegate: FlutterAppDelegate {
    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let options = NSMutableDictionary.init(dictionary: launchOptions ?? [:])
        options.setValue(NSNumber.init(value:true), forKey: "debug")
        DCUniMPSDKEngine.initSDKEnvironment(launchOptions: options as! [AnyHashable : Any]);
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    override func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    override func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}

