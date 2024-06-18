//
//  OnboardingRouter.swift
//  OnboardingApp
//
//  Created by Anton Polovoy on 17.06.24.
//

import UIKit

protocol OnboardingRouterInput {
    func navigateToMainScreen()
}

final class OnboardingRouter {
    
    private let viewController: OnboardingViewController
    
    init(viewController: OnboardingViewController) {
        self.viewController = viewController
    }
}

extension OnboardingRouter: OnboardingRouterInput {
    func navigateToMainScreen() {
        if self.viewController.view.window?.windowScene?.delegate is SceneDelegate {
            let vc = MainScreenViewController()
            vc.modalPresentationStyle = .fullScreen
            self.viewController.present(vc, animated: true)
        }
    }
}
