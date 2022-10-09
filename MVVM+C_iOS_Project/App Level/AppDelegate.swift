//
//  AppDelegate.swift
//  MVVM+C_iOS_Project
//
//  Created by PaulmaX on 13.07.22.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        appCoordinator = AppCoordinator(window: window)
        appCoordinator?.start()
        
        return true
    }
}
