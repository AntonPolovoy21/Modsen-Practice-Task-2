//
//  OnboardingViewController.swift
//  OnboardingApp
//
//  Created by Anton Polovoy on 17.06.24.
//

import UIKit

protocol OnboardingInput: AnyObject {
    func changeButtonBackgroundColorWithAlpha(_ sender: UIButton, color: UIColor, alpha: CGFloat)
    func nextCollectionViewItem()
    func slideCollectionViewItem(_ scrollView: UIScrollView)
    func isLastSlide() -> Bool
}

final class OnboardingViewController: UIViewController {
    
    var output: OnboardingViewOutput?
    
    var currentPage = 0 {
        didSet {
            self.updatePageControl()
        }
    }
    
    private let pageColors: [UIColor] = [.color1, .color2, .color3, .color4]
    
    private enum ButtonImages: String, CaseIterable {
        case btn1 = "btn1"
        case btn2 = "btn2"
        case btn3 = "btn3"
        case btn4 = "btn4"
    }
    
    private var slides: [OnboardingSlide] = [
        OnboardingSlide(
            title: "Your first car without\na driver's license",
            desciption: "Goes to meet people who just got \ntheir license",
            image: UIImage(named: Image.Onboarding.first)
        ),
        OnboardingSlide(
            title: "Always there: more than\n1000 cars in Tbilisi",
            desciption: "Our company is a leader by the\nnumber of cars in the fleet",
            image: UIImage(named: Image.Onboarding.second)
        ),
        OnboardingSlide(
            title: "Do not pay for parking,\nmaintenance and gasoline",
            desciption: "We will pay for you, all expenses\nrelated to the car",
            image: UIImage(named: Image.Onboarding.third)
        ),
        OnboardingSlide(
            title: "29 car models: from Skoda\nOctavia to Porsche 911",
            desciption: "Choose between regular car models\nor exclusive ones",
            image: UIImage(named: Image.Onboarding.fourth)
        )
    ]
    
    private lazy var circleButton: UIButton = {
        let button = UIButton()
        button.imageView?.image = UIImage(named: ButtonImages.btn1.rawValue)
        button.setImage(UIImage(named: ButtonImages.btn1.rawValue)?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        
        button.addTarget(self, action: #selector(circleButtonTouchUpInside), for: .touchUpInside)
        return button
    }()
    
    private lazy var skipButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitle("Skip", for: .normal)
        button.titleLabel?.font = UIFont(name: "Abel", size: 18)
        button.setTitleColor(.gray, for: .normal)
        button.backgroundColor = .clear
        
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(skipButtonTouchUpInside), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.numberOfPages = self.slides.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .systemGray5
        pageControl.currentPageIndicatorTintColor = .white
        return pageControl
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(OnboardingSlideCollectionViewCell.self, forCellWithReuseIdentifier: OnboardingSlideCollectionViewCell.identifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .color1
        self.setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
}

private extension OnboardingViewController {
    @objc private func circleButtonTouchUpInside() {
        output?.circleButtonTouchUpInside(circleButton)
    }
    
    @objc private func skipButtonTouchUpInside() {
        output?.skipButtonTouchUpInside(skipButton)
    }
}

extension OnboardingViewController: OnboardingInput {
    func isLastSlide() -> Bool {
        self.currentPage == self.slides.count - 1
    }
    
    func changeButtonBackgroundColorWithAlpha(_ sender: UIButton, color: UIColor, alpha: CGFloat) {
        sender.backgroundColor = color.withAlphaComponent(alpha)
    }
    
    func nextCollectionViewItem() {
        self.currentPage = min(self.currentPage + 1, self.slides.count - 1)
        let indexPath = IndexPath(item: self.currentPage, section: 0)
        self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func slideCollectionViewItem(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        self.currentPage = Int(scrollView.contentOffset.x / width)
        self.pageControl.currentPage = self.currentPage
    }
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingSlideCollectionViewCell.identifier, for: indexPath) as! OnboardingSlideCollectionViewCell
        cell.configure(with: self.slides[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        output?.slideCollectionViewInput(scrollView)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}

private extension OnboardingViewController {
    func setupUI() {
        self.view.addSubview(
            self.circleButton,
            self.skipButton,
            self.pageControl,
            self.collectionView
        )
        
        NSLayoutConstraint.activate([
            self.circleButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.circleButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
            self.circleButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.15466),
            self.circleButton.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.15466),
            
            self.pageControl.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.pageControl.topAnchor.constraint(equalTo: self.circleButton.topAnchor, constant: -20),
            self.pageControl.widthAnchor.constraint(equalToConstant: 150),
            self.pageControl.heightAnchor.constraint(equalToConstant: 30),
            
            self.skipButton.centerXAnchor.constraint(equalTo: self.pageControl.centerXAnchor),
            self.skipButton.centerYAnchor.constraint(equalTo: self.circleButton.centerYAnchor),
            self.skipButton.widthAnchor.constraint(equalToConstant: 100),
            self.skipButton.heightAnchor.constraint(equalToConstant: 50),
            
            self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.pageControl.topAnchor, constant: -40),
        ])
    }
    
    private func updatePageControl() {
        self.pageControl.currentPage = self.currentPage
        let buttonImage = ButtonImages.allCases[self.currentPage].rawValue
        self.circleButton.setImage(UIImage(named: buttonImage)?.withRenderingMode(.alwaysOriginal), for: .normal)
        
        let pageColor = pageColors[self.currentPage]
        self.view.backgroundColor = pageColor
    }
}
