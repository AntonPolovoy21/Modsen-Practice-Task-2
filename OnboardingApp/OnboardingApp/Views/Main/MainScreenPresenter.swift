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
    
    private unowned let input: MainScreenViewController
    private let router: MainScreenRouter
    
    init(input: MainScreenViewController, router: MainScreenRouter) {
        self.input = input
        self.router = router
    }
    
    func screenTouchUpInside() {
        //touch on screen gesture
    }
}
