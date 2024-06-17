//
//  SceneDelegate.swift
//  OnboardingApp
//
//  Created by Anton Polovoy on 17.06.24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard (scene is UIWindowScene) else { return }
        self.setupWindow(with: scene)
        isOnboardingCompleted()
    }
    
    public func setupWindow(with scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        self.setupRootViewController(with: OnboardingBuilder.setupModule())
        self.window?.makeKeyAndVisible()
    }
    
    private func setupRootViewController(with viewController: UIViewController) {
        DispatchQueue.main.async { [weak self] in
            UIView.animate(withDuration: 0.25) {
                self?.window?.layer.opacity = 0
            } completion: { [weak self] _ in
                let navController = UINavigationController(rootViewController: viewController)
                self?.window?.rootViewController = navController
                
                UIView.animate(withDuration: 0.25) { [weak self] in
                    self?.window?.layer.opacity = 1
                }
            }
        }
    }
    
    public func isOnboardingCompleted() {
        if !UserDefaults.standard.bool(forKey: "wasEnded") {
            self.setupRootViewController(with: OnboardingBuilder.setupModule())
        }
//         else if UserDefaultsManager.isOnboardingComplete == true {
//            self.setupRootViewController(with: Mai())
//        }
    }
}

