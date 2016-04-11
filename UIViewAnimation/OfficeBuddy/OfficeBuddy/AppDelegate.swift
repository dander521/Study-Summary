//
//  AppDelegate.swift
//  OfficeBuddy
//
//  Created by 程荣刚 on 16/4/11.
//  Copyright © 2016年 rongkecloud. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        application.statusBarStyle = UIStatusBarStyle.LightContent
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let centerNav = storyboard.instantiateViewControllerWithIdentifier("CenterNav") as! UINavigationController
        let menuVC = storyboard.instantiateViewControllerWithIdentifier("SideMenu") as! SideMenuViewController
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window!.backgroundColor = UIColor.blackColor()
        self.window!.makeKeyAndVisible()
        
        return true
    }
}

