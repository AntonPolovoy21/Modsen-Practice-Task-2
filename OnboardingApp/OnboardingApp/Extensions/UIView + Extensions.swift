//
//  UIView + Extensions.swift
//  OnboardingApp
//
//  Created by Anton Polovoy on 17.06.24.
//

import UIKit

extension UIView {
    func addSubview(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}
