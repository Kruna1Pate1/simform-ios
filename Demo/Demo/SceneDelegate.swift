//
//  SceneDelegate.swift
//  Demo
//
//  Created by Krunal Patel on 14/02/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

 
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        print("SceneDelegate \(#function) State: \(UIApplication.shared.applicationState.toString())")

        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)
        let rootVC = UserDetails.isLoggedIn() ? UIStoryboard(name: "CombinedScreen", bundle: nil).instantiateViewController(withIdentifier: "CombinedVC") : UIStoryboard(name: "NavigationExercise", bundle: nil).instantiateViewController(withIdentifier: "LoginVC")
        let navigationController = UINavigationController(rootViewController: rootVC)
        navigationController.setNavigationBarHidden(true, animated: true)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
        print("SceneDelegate \(#function) State: \(UIApplication.shared.applicationState.toString())")
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
        print("SceneDelegate \(#function) State: \(UIApplication.shared.applicationState.toString())")
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
        print("SceneDelegate \(#function) State: \(UIApplication.shared.applicationState.toString())")
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
        print("SceneDelegate \(#function) State: \(UIApplication.shared.applicationState.toString())")
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        print("SceneDelegate \(#function) State: \(UIApplication.shared.applicationState.toString())")
    }
}

