//
//  SceneDelegate.swift
//  Locations
//
//  Created by Fady Yecob on 19/09/2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
      
        self.window = makeWindow(windowScene: windowScene)
    }
    
    private func makeWindow(windowScene: UIWindowScene) -> UIWindow {
        let window = UIWindow(windowScene: windowScene)
        
        let navigationController = UINavigationController(rootViewController: LocationsListViewController())
        navigationController.navigationBar.prefersLargeTitles = true
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        return window
    }
}
