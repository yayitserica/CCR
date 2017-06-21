//
//  AppDelegate.swift
//  CCR
//
//  Created by Erica Millado on 2/10/17.
//  Copyright © 2017 Erica Millado. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let appearance = UITabBarItem.appearance()
        let attributes: [String: AnyObject] = [NSFontAttributeName:UIFont(name: "OpenSans-semiBold", size: 12)!, NSForegroundColorAttributeName: Constants.red]
        
        appearance.setTitleTextAttributes(attributes, for: .normal)

//        window = UIWindow(frame: UIScreen.main.bounds)
//        let sb = UIStoryboard(name: "Main" , bundle: nil)
//        
//        var initialViewController = sb.instantiateViewController(withIdentifier: "Onboarding")
//        window?.rootViewController = initialViewController
//        window?.makeKeyAndVisible()
//        
//        let userDefaults = UserDefaults.standard
//        
//        if userDefaults.bool(forKey: "onboardingComplete") {
//            initialViewController = sb.instantiateViewController(withIdentifier: "sbTaskID")
//        }
        
        return true
    }


}

