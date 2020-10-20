//
//  AppDelegate.swift
//  TestTaskJson
//
//  Created by Roma on 10/16/20.
//  Copyright © 2020 Roma. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        // (2)
        
        let navController = UINavigationController()
        let viewController = ViewController()
        navController.viewControllers = [viewController]
        window?.rootViewController = navController
        // (3)
        window?.makeKeyAndVisible()
        return true
    }

    

}

