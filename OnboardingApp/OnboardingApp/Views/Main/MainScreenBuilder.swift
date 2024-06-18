//
//  MainScreenBuilder.swift
//  OnboardingApp
//
//  Created by Влад Рожко on 18.06.24.
//

import UIKit

enum MainScreenBuilder {
    static func setupModule() -> MainScreenViewController {
        let viewController = MainScreenViewController()
        let router = MainScreenRouter(viewController: viewController)
        let presenter = MainScreenPresenter(input: viewController as! MainScreenInput, router: router as! MainScreenRouterInput)
        viewController.output = presenter
        return viewController
    }
}
