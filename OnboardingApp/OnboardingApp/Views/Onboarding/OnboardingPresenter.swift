//
//  OnboardingPresenter.swift
//  OnboardingApp
//
//  Created by Anton Polovoy on 17.06.24.
//

import UIKit

protocol OnboardingViewOutput {
    func circleButtonTouchUpInside(_ sender: UIButton)
    func skipButtonTouchUpInside(_ sender: UIButton)
    func slideCollectionViewInput(_ scrollView: UIScrollView)
}

final class OnboardingPresenter: OnboardingViewOutput {
    
    private unowned let input: OnboardingInput
    private let router: OnboardingRouterInput
    
    init(input: OnboardingInput, router: OnboardingRouterInput) {
        self.input = input
        self.router = router
    }
    
    func circleButtonTouchUpInside(_ sender: UIButton) {
        if input.isLastSlide() {
            UserDefaults.standard.setValue(true, forKey: "wasEnded")
            router.navigateToMainScreen()
        } else {
            input.nextCollectionViewItem()
        }
    }
    
    func skipButtonTouchUpInside(_ sender: UIButton) {
        UserDefaults.standard.setValue(true, forKey: "wasEnded")
        router.navigateToMainScreen()
    }
    
    func slideCollectionViewInput(_ scrollView: UIScrollView) {
        input.slideCollectionViewItem(scrollView)
    }
}


