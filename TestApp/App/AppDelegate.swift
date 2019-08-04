//
//  AppDelegate.swift
//  TestApp
//
//  Created by Sergey Koriukin on 24/06/2019.
//  Copyright © 2019 Sergey Koriukin. All rights reserved.
//

import UIKit
import CocoaLumberjack
import IQKeyboardManagerSwift


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    static let noteBook = FileNotebook()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        DDLog.add(DDOSLogger.sharedInstance)
        IQKeyboardManager.shared.enable = true
        return true
    }

}

