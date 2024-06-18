//
//  MainScreenPresenter.swift
//  OnboardingApp
//
//  Created by Влад Рожко on 18.06.24.
//

import UIKit

protocol MainScreenViewOutput {
    func screenTouchUpInside() 
}

final class MainScreenPresenter: MainScreenViewOutput {
    
    private unowned let input: MainScreenInput
    private let router: MainScreenRouterInput
    
    init(input: MainScreenInput, router: MainScreenRouterInput) {
        self.input = input
        self.router = router
    }
    
    func screenTouchUpInside() {
        //touch on screen gesture
    }
}
