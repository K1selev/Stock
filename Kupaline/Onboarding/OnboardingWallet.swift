//
//  OnboardingWallet.swift
//  Kupaline
//
//  Created by Сергей Киселев on 01.03.2025.
//

import UIKit

class OnboardingWallet: UIViewController {
    
    private var buttonStart = CustomButton()
    private var mainLabel = UILabel()
    private var textField = UITextField()
    private let leftViewTextField = UILabel()
    private let rightViewTextField = UILabel()
    private let userBalance = UserDefaults.standard.string(forKey: "Wallet")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "OnBoardingBackGr")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        mainLabel.text = "Enter Your \nAccount Balance"
        mainLabel.font = .systemFont(ofSize: 36, weight: .bold)
        mainLabel.textColor = .white
        mainLabel.numberOfLines = 2
        view.addSubview(mainLabel)
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        
        leftViewTextField.text = "    Wallet  "
        leftViewTextField.textColor = .white
        leftViewTextField.font = .systemFont(ofSize: 16)
        
        rightViewTextField.text = "  $    "
        rightViewTextField.textColor = .lightGray
        rightViewTextField.font = .systemFont(ofSize: 16)
        
        textField.attributedPlaceholder = NSAttributedString(string: userBalance ?? "", attributes: [
            .foregroundColor: UIColor.lightGray,
            .font: UIFont.systemFont(ofSize: 16.0)
        ])
        textField.textColor = .lightGray
        textField.leftView = leftViewTextField
        textField.rightView = rightViewTextField
        textField.textAlignment = .right
        textField.leftViewMode = .always
        textField.rightViewMode = .always
        textField.layer.cornerRadius = 16
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.white.cgColor
        textField.keyboardType = .asciiCapableNumberPad
        view.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        
        buttonStart = CustomButton(textColor: UIColor(named: "customBlack")!, background: .white, title: "Let’s start")
        buttonStart.addTarget(self, action: #selector(didTapButtonContinue), for: .touchUpInside)
        view.addSubview(buttonStart)
        buttonStart.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            mainLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            mainLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            mainLabel.heightAnchor.constraint(equalToConstant: 98),
            
            textField.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 24),
            textField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            textField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            textField.heightAnchor.constraint(equalToConstant: 56),
            
            buttonStart.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -37),
            buttonStart.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            buttonStart.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            buttonStart.heightAnchor.constraint(equalToConstant: 52)
            ])
    }
    
    @objc func didTapButtonContinue() {
        UserDefaults.standard.set(textField.text, forKey: "Wallet")
        UserDefaults.standard.set(true, forKey: "isFirstOpen")
        let vc = TabBar()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}
