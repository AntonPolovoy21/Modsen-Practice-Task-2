//
//  MainScreenRouter.swift
//  OnboardingApp
//
//  Created by Влад Рожко on 18.06.24.
//

import UIKit

protocol MainScreenRouterInput {
    func returnToOnboarding()
}

final class MainScreenRouter {
    
    private let viewController: MainScreenViewController
    
    init(viewController: MainScreenViewController) {
        self.viewController = viewController
    }
}

extension MainScreenRouter: MainScreenRouterInput {
    func returnToOnboarding() {
//        some
    }
}
