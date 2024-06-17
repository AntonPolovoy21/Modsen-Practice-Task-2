//
//  OnboardingSlideCollectionViewCell.swift
//  OnboardingApp
//
//  Created by Anton Polovoy on 17.06.24.
//

import UIKit

final class OnboardingSlideCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: OnboardingViewController.self)
    
    private lazy var slideImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.zPosition = 1
        return imageView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.numberOfLines = 2
        label.layer.zPosition = 1
        
        label.font = UIFont(name: "Abel", size: 28)
        label.textColor = .white
        
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.numberOfLines = 2
        label.layer.zPosition = 1
        
        label.font = .systemFont(ofSize: 18)
        label.textColor = .white
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with slide: OnboardingSlide) {
        DispatchQueue.main.async {
            self.slideImageView.image = slide.image
            self.titleLabel.text = slide.title
            self.descriptionLabel.text = slide.desciption
        }
    }
}

private extension OnboardingSlideCollectionViewCell {
    func setupUI() {
        self.addSubview(
            self.slideImageView,
            self.stackView
        )
        
        self.stackView.addArrangedSubviews(
            self.titleLabel,
            self.descriptionLabel
        )
        
        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(equalTo: self.topAnchor),
            self.stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.stackView.heightAnchor.constraint(equalToConstant: 150),
            
            self.slideImageView.topAnchor.constraint(equalTo: self.stackView.bottomAnchor),
            self.slideImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.slideImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.27),
            self.slideImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.0),
        ])
    }
}
