//
//  AppDelegate.swift
//  News
//
//  Created by Ivan Puzanov on 06.09.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let serviceAssembly = ServiceAssembly()
        let newsListAssembly = NewsListAssembly(serviceAssembly: serviceAssembly)
        let newsListCoordinator = NewsListCoordinator(newsListAssembly: newsListAssembly,
                                                      navigationController: UINavigationController())
        newsListCoordinator.start()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = newsListCoordinator.navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
}

