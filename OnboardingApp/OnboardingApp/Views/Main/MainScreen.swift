//
//  MainScreen.swift
//  OnboardingApp
//
//  Created by Anton Polovoy on 17.06.24.
//

import UIKit

class MainScreen: UIViewController {
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        
        label.text = "You are a clever person!"
        label.font = UIFont(name: "Abel", size: 30)
        label.textColor = .white
        
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .color4
        
        view.addSubview(textLabel)
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
