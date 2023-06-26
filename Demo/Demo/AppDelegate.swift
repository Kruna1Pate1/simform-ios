//
//  AppDelegate.swift
//  Demo
//
//  Created by Krunal Patel on 14/02/23.
//

import UIKit
import Kingfisher

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    override init() {
        super.init()
        print("AppDelegate \(#function)")
    }

    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("AppDelegate \(#function) State: \(UIApplication.shared.applicationState.toString())")
        return true
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        print("AppDelegate \(#function) State: \(UIApplication.shared.applicationState.toString())")
        
        // Configure Kingfisher's Cache
        let cache = ImageCache.default

        // Constrain Memory Cache to 10 MB
        cache.memoryStorage.config.totalCostLimit = 1024 * 1024 * 10

        // Constrain Disk Cache to 100 MB
        cache.diskStorage.config.sizeLimit = 1024 * 1024 * 100
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        print("AppDelegate \(#function) State: \(UIApplication.shared.applicationState.toString())")
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
        print("AppDelegate \(#function) State: \(UIApplication.shared.applicationState.toString())")
    }

    func applicationWillTerminate(_ application: UIApplication) {
        print("AppDelegate \(#function) State: \(UIApplication.shared.applicationState.toString())")
    }
    
    var backgroundSessionCompletionHandler: (() -> Void)?
    
    func application(
      _ application: UIApplication,
      handleEventsForBackgroundURLSession
        handleEventsForBackgroundURLSessionidentifier: String,
      completionHandler: @escaping () -> Void) {
        backgroundSessionCompletionHandler = completionHandler
    }

}

extension UIApplication.State {
    
    func toString() -> String {
        switch self {
            case .active: return "active"
            case .inactive: return "inactive"
            case .background: return "background"
            default: return "none"
        }
    }
}

