//
//  OnboardingSecondVC.swift
//  Kupaline
//
//  Created by Сергей Киселев on 01.03.2025.
//

import UIKit

class OnboardingSecondVC: UIViewController {
    
    private var buttonContinue = CustomButton()
    private var mainLabel = UILabel()
    private var onboardImage = UIImageView()
    private var subLabel = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "OnBoardingBackGr")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        mainLabel.text = "Take Control \nof Your Financial \nJourney"
        mainLabel.font = .systemFont(ofSize: 36, weight: .bold)
        mainLabel.textColor = .white
        mainLabel.numberOfLines = 3
        view.addSubview(mainLabel)
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        
        onboardImage.image = UIImage(named: "onBoardingImg")
        view.addSubview(onboardImage)
        onboardImage.translatesAutoresizingMaskIntoConstraints = false
        
        subLabel.image = UIImage(named: "OnBoardingSecondSub")
        view.addSubview(subLabel)
        subLabel.translatesAutoresizingMaskIntoConstraints = false
        
        buttonContinue = CustomButton(textColor: UIColor(named: "customBlack")!, background: .white, title: "Continue")
        buttonContinue.addTarget(self, action: #selector(didTapButtonContinue), for: .touchUpInside)
        view.addSubview(buttonContinue)
        buttonContinue.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            mainLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            mainLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            mainLabel.heightAnchor.constraint(equalToConstant: 147),
            
            onboardImage.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 32),
            onboardImage.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            onboardImage.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            onboardImage.heightAnchor.constraint(equalToConstant: 28),
            
            subLabel.topAnchor.constraint(equalTo: onboardImage.bottomAnchor, constant: 32),
            subLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            subLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            subLabel.heightAnchor.constraint(equalToConstant: 264),
            
            buttonContinue.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -37),
            buttonContinue.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            buttonContinue.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            buttonContinue.heightAnchor.constraint(equalToConstant: 52)
            
            ])
    }
    
    @objc func didTapButtonContinue() {
        let vc = OnboardingWallet()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
    }
}
