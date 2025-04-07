//
//  Bank.swift
//  Kupaline
//
//  Created by Сергей Киселев on 01.03.2025.
//

import UIKit

struct Transaction {
    let date: String
    let amount: Int
}

class BankViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    private var headerView = UIView()
    private var mainView = UIView()
    private var headerViewLabel = UILabel()
    
    private let minTextField = UITextField()
    private let maxTextField = UITextField()
    
    private let randomizeButton = UIButton(type: .system)
    private let resetButton = UIButton(type: .system)
    
    private let tableView = UITableView()
    private let totalLabel = UILabel()
    
    private let leftViewMinTextField = UILabel()
    private let rightViewMinTextField = UILabel()
    private let leftViewMaxTextField = UILabel()
    private let rightViewMaxTextField = UILabel()
    
    private let historyLabel = UILabel()
    private let randomizeLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "customBlack")
        setupUI()
    }
    
    private func setupUI() {
        
        
        leftViewMinTextField.text = "    Min  "
        leftViewMinTextField.textColor = .white
        leftViewMinTextField.font = .systemFont(ofSize: 16)
        
        rightViewMinTextField.text = "  $    "
        rightViewMinTextField.textColor = .lightGray
        rightViewMinTextField.font = .systemFont(ofSize: 16)
        
        
        minTextField.attributedPlaceholder = NSAttributedString(string: "0", attributes: [
            .foregroundColor: UIColor.lightGray,
            .font: UIFont.systemFont(ofSize: 16.0)
        ])
        minTextField.textColor = .lightGray
        minTextField.leftView = leftViewMinTextField
        minTextField.rightView = rightViewMinTextField
        minTextField.textAlignment = .right
        minTextField.leftViewMode = .always
        minTextField.rightViewMode = .always
        minTextField.layer.cornerRadius = 16
        minTextField.layer.borderWidth = 1
        minTextField.layer.borderColor = UIColor.lightGray.cgColor
        minTextField.keyboardType = .asciiCapableNumberPad
        minTextField.keyboardType = .numberPad
        view.addSubview(minTextField)
        minTextField.translatesAutoresizingMaskIntoConstraints = false
        
        leftViewMaxTextField.text = "    Max  "
        leftViewMaxTextField.textColor = .white
        leftViewMaxTextField.font = .systemFont(ofSize: 16)
        
        rightViewMaxTextField.text = "  $    "
        rightViewMaxTextField.textColor = .lightGray
        rightViewMaxTextField.font = .systemFont(ofSize: 16)
        
        
        maxTextField.attributedPlaceholder = NSAttributedString(string: "0", attributes: [
            .foregroundColor: UIColor.lightGray,
            .font: UIFont.systemFont(ofSize: 16.0)
        ])
        maxTextField.textColor = .lightGray
        maxTextField.leftView = leftViewMaxTextField
        maxTextField.rightView = rightViewMaxTextField
        maxTextField.textAlignment = .right
        maxTextField.leftViewMode = .always
        maxTextField.rightViewMode = .always
        maxTextField.layer.cornerRadius = 16
        maxTextField.layer.borderWidth = 1
        maxTextField.layer.borderColor = UIColor.lightGray.cgColor
        maxTextField.keyboardType = .asciiCapableNumberPad
        maxTextField.keyboardType = .numberPad
        view.addSubview(maxTextField)
        maxTextField.translatesAutoresizingMaskIntoConstraints = false
         
        view.backgroundColor = UIColor(named: "customBlack")
        
        mainView.backgroundColor = UIColor(named: "customDarkGray")
        view.addSubview(mainView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        
        historyLabel.text = "Replenishment history"
        historyLabel.textColor = .white
        historyLabel.font = .systemFont(ofSize: 16)
        view.addSubview(historyLabel)
        historyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        randomizeLabel.text = "Piggy bank settings"
        randomizeLabel.textColor = .white
        randomizeLabel.font = .systemFont(ofSize: 16)
        view.addSubview(randomizeLabel)
        randomizeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(minTextField)
        minTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(maxTextField)
        maxTextField.translatesAutoresizingMaskIntoConstraints = false
      
        
        headerView.backgroundColor = UIColor(named: "customBlack")
        headerView.layer.cornerRadius = 12
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        headerViewLabel.text = "My piggy bank"
        headerViewLabel.textColor = .white
        headerViewLabel.textAlignment = .left
        headerViewLabel.font = .systemFont(ofSize: 32)
        headerView.addSubview(headerViewLabel)
        headerViewLabel.translatesAutoresizingMaskIntoConstraints = false
        
        randomizeButton.setTitle("Randomize", for: .normal)
        randomizeButton.backgroundColor = .white
        randomizeButton.setTitleColor(UIColor(named: "customBlack"), for: .normal)
        randomizeButton.layer.cornerRadius = 16
        randomizeButton.addTarget(self, action: #selector(randomizeAmount), for: .touchUpInside)
        
        view.addSubview(randomizeButton)
        randomizeButton.translatesAutoresizingMaskIntoConstraints = false
        
        resetButton.setImage(UIImage(systemName: "arrow.2.circlepath"), for: .normal)
        resetButton.backgroundColor = .white
        resetButton.tintColor = .black
        resetButton.layer.cornerRadius = 16
        resetButton.addTarget(self, action: #selector(resetFields), for: .touchUpInside)
        
        view.addSubview(resetButton)
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .black
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isScrollEnabled = false
        tableView.clipsToBounds = true
        tableView.layer.cornerRadius = 16
        tableView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        totalLabel.font = UIFont.boldSystemFont(ofSize: 20)
        totalLabel.textColor = .white
        totalLabel.backgroundColor = .systemGreen
        view.addSubview(totalLabel)
        totalLabel.clipsToBounds = true
        totalLabel.layer.cornerRadius = 16
        totalLabel.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
                
        updateTotal()
        
        totalLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ])
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            headerView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 68),
            
            mainView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -12),
            mainView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            mainView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            headerViewLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 10),
            headerViewLabel.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 16),
            
            historyLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 28),
            historyLabel.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 20),
            historyLabel.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -20),
            historyLabel.heightAnchor.constraint(equalToConstant: 24),
            
            tableView.topAnchor.constraint(equalTo: historyLabel.bottomAnchor, constant: 16),
            tableView.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 20),
            tableView.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -20),
            tableView.heightAnchor.constraint(equalToConstant: CGFloat(transactions.count * 45)),
            
            totalLabel.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 0),
            totalLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            totalLabel.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 20),
            totalLabel.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -20),
            totalLabel.heightAnchor.constraint(equalToConstant: 35),
            
            randomizeLabel.topAnchor.constraint(equalTo: totalLabel.bottomAnchor, constant: 24),
            randomizeLabel.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 20),
            randomizeLabel.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -20),
            randomizeLabel.heightAnchor.constraint(equalToConstant: 24),
            
            minTextField.topAnchor.constraint(equalTo: randomizeLabel.bottomAnchor, constant: 16),
            minTextField.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -8),
            minTextField.widthAnchor.constraint(equalToConstant: 167),
            minTextField.heightAnchor.constraint(equalToConstant: 56),
            
            maxTextField.topAnchor.constraint(equalTo: randomizeLabel.bottomAnchor, constant: 16),
            maxTextField.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 8),
            maxTextField.widthAnchor.constraint(equalToConstant: 167),
            maxTextField.heightAnchor.constraint(equalToConstant: 56),
            
            randomizeButton.topAnchor.constraint(equalTo: minTextField.bottomAnchor, constant: 20),
            randomizeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            randomizeButton.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 20),
            randomizeButton.rightAnchor.constraint(equalTo: resetButton.leftAnchor, constant: -16),
            randomizeButton.heightAnchor.constraint(equalToConstant: 50),
            
            resetButton.topAnchor.constraint(equalTo: minTextField.bottomAnchor, constant: 20),
            resetButton.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -20),
            resetButton.widthAnchor.constraint(equalToConstant: 50),
            resetButton.heightAnchor.constraint(equalToConstant: 50),
            
        ])
    }
    
    @objc private func randomizeAmount() {
        guard let minText = minTextField.text, let maxText = maxTextField.text,
              let minValue = Int(minText), let maxValue = Int(maxText), minValue < maxValue else { return }
        let randomAmount = Int.random(in: minValue...maxValue)
        
        let vc = BankRandomize()
        vc.modalPresentationStyle = .fullScreen
        vc.randomBank = randomAmount
        present(vc, animated: true)
    }
    
    @objc private func resetFields() {
        minTextField.text = ""
        maxTextField.text = ""
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.layoutIfNeeded()
        tableView.heightAnchor.constraint(equalToConstant: tableView.contentSize.height).isActive = true
    }
       
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let transaction = transactions[indexPath.row]
        
        cell.textLabel?.text = nil
        cell.backgroundColor = indexPath.row % 2 == 0 ? .darkGray : .black
        
        let dateLabel = UILabel()
        dateLabel.text = transaction.date
        dateLabel.textColor = .white
        
        let amountLabel = UILabel()
        amountLabel.text = "+ \(transaction.amount) $"
        amountLabel.textColor = .white
        amountLabel.textAlignment = .right
        
        let stackView = UIStackView(arrangedSubviews: [dateLabel, amountLabel])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        cell.contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -8)
        ])
        
        return cell
    }
       
    private func updateTotal() {
        let total = transactions.reduce(0) { $0 + $1.amount }
                
                let totalTitleLabel = UILabel()
                totalTitleLabel.text = "Total:"
                totalTitleLabel.textColor = .white
                
                let totalAmountLabel = UILabel()
                totalAmountLabel.text = "\(total) $"
                totalAmountLabel.textColor = .white
                totalAmountLabel.textAlignment = .right
                
                let stackView = UIStackView(arrangedSubviews: [totalTitleLabel, totalAmountLabel])
                stackView.axis = .horizontal
                stackView.distribution = .equalSpacing
                stackView.translatesAutoresizingMaskIntoConstraints = false
                
                totalLabel.subviews.forEach { $0.removeFromSuperview() }
                totalLabel.addSubview(stackView)
                
                NSLayoutConstraint.activate([
                    stackView.leadingAnchor.constraint(equalTo: totalLabel.leadingAnchor, constant: 16),
                    stackView.trailingAnchor.constraint(equalTo: totalLabel.trailingAnchor, constant: -16),
                    stackView.centerYAnchor.constraint(equalTo: totalLabel.centerYAnchor)
                ])
    }
       
    func addTransaction(date: String, amount: Int) {
        transactions.append(Transaction(date: date, amount: amount))
        tableView.reloadData()
        updateTotal()
    }
}
