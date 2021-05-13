//
//  AppDelegate.swift
//  VIPER-sample
//
//  Created by Ryota Karita on 2021/05/11.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    let appPresenter = AppRouter.assembleModule(window: UIWindow())

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        appPresenter.didFinishLaunch()
        
        return true
    }

}

