//
//  OnboardingBuilder.swift
//  OnboardingApp
//
//  Created by Anton Polovoy on 17.06.24.
//

import Foundation

enum OnboardingBuilder {
    static func setupModule() -> OnboardingViewController {
        let viewController = OnboardingViewController()
        let router = OnboardingRouter(viewController: viewController)
        let presenter = OnboardingPresenter(input: viewController, router: router)
        viewController.output = presenter
        return viewController
    }
}
