//
//  AppDelegate.swift
//  LiftingLog
//
//  Created by TSS on 2020/7/29.
//  Copyright © 2020 TSS. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    let titleFontAttrs = [ NSAttributedString.Key.font: UIFont(name: "AvenirNext-HeavyItalic", size: 18)!, NSAttributedString.Key.foregroundColor: UIColor.white ]
    let barButtonFontAttrs = [ NSAttributedString.Key.font: UIFont(name: "AvenirNext-DemiBold", size: 14)! ]

    UINavigationBar.appearance().tintColor = UIColor.white // bar icons

    if #available(iOS 13.0, *) {
      let appearance = UINavigationBarAppearance()
      appearance.backgroundColor = .darkGray
      appearance.titleTextAttributes = titleFontAttrs
      appearance.largeTitleTextAttributes = titleFontAttrs
      UINavigationBar.appearance().isTranslucent = false
      appearance.buttonAppearance.normal.titleTextAttributes = barButtonFontAttrs
      appearance.buttonAppearance.highlighted.titleTextAttributes = barButtonFontAttrs
      UINavigationBar.appearance().standardAppearance = appearance
      UINavigationBar.appearance().compactAppearance = appearance
      UINavigationBar.appearance().scrollEdgeAppearance = appearance
    } else {
      UINavigationBar.appearance().barTintColor = .darkGray // bar background
      UINavigationBar.appearance().titleTextAttributes = titleFontAttrs
      UINavigationBar.appearance().isTranslucent = false
      UIBarButtonItem.appearance().setTitleTextAttributes(barButtonFontAttrs, for: .normal)
      UIBarButtonItem.appearance().setTitleTextAttributes(barButtonFontAttrs, for: .highlighted)
    }
    // Override point for customization after application launch.
    return true
  }

  // MARK: UISceneSession Lifecycle

  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }

  func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
  }
  
  

}

