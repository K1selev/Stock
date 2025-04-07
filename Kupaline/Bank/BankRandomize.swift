//
//  BankRandomize.swift
//  Kupaline
//
//  Created by Сергей Киселев on 05.03.2025.
//

import UIKit

class BankRandomize: UIViewController {
    
    private var buttonYes = CustomButton()
    private var buttonCancel = CustomButton()
    private var mainLabel = UILabel()
    private var subLabel = UILabel()
    private let mainView = UIView()
    
    var randomBank = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "OnBoardingBackGr")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        mainLabel.text = "\(randomBank) $"
        mainLabel.font = .systemFont(ofSize: 36, weight: .bold)
        mainLabel.textColor = .systemGreen
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        
        subLabel.text = "Put in a piggy bank?"
        subLabel.font = .systemFont(ofSize: 20)
        subLabel.textColor = .white
        subLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        mainView.layer.cornerRadius = 16
        blurEffectView.layer.cornerRadius = 16
        blurEffectView.clipsToBounds = true
        blurEffectView.frame = mainView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mainView.addSubview(blurEffectView)
        view.addSubview(mainView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        
        buttonYes = CustomButton(textColor: UIColor(named: "customBlack")!, background: .white, title: "Continue")
        buttonYes.addTarget(self, action: #selector(didTapButtonContinue), for: .touchUpInside)
        mainView.addSubview(buttonYes)
        buttonYes.translatesAutoresizingMaskIntoConstraints = false
        
        buttonCancel = CustomButton(textColor: .white, background: .lightGray, title: "Cancel")
        buttonCancel.addTarget(self, action: #selector(didTapButtonCancel), for: .touchUpInside)
        mainView.addSubview(buttonCancel)
        buttonCancel.translatesAutoresizingMaskIntoConstraints = false
        
        mainView.addSubview(mainLabel)
        mainView.addSubview(subLabel)
        
        NSLayoutConstraint.activate([
            mainView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mainView.heightAnchor.constraint(equalToConstant: 200),
            mainView.widthAnchor.constraint(equalToConstant: 343),
            
            mainLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 16),
            mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            subLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 16),
            subLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            buttonYes.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -16),
            buttonYes.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -16),
            buttonYes.heightAnchor.constraint(equalToConstant: 52),
            buttonYes.widthAnchor.constraint(equalToConstant: 151),
            
            buttonCancel.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -16),
            buttonCancel.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 16),
            buttonCancel.heightAnchor.constraint(equalToConstant: 52),
            buttonCancel.widthAnchor.constraint(equalToConstant: 151),
            
        ])
    }
    
    @objc func didTapButtonContinue() {
        let vc = TabBar()
        var todaysDate = NSDate()
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        var dateInFormat = dateFormatter.string(from: todaysDate as Date)
        transactions.append(Transaction(date: dateInFormat, amount: randomBank))
        vc.selectedIndex = 3
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)

    }
    @objc func didTapButtonCancel() {
        let vc = TabBar()
        vc.selectedIndex = 3
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}
