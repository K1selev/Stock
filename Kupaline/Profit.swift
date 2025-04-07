//
//  Profit.swift
//  Kupaline
//
//  Created by Сергей Киселев on 01.03.2025.
//

import UIKit

struct Stock {
    let name: String
    let price: Double
    let change: Double
    let logo: UIImage?
    var quantity: Int
}
protocol StockCellDelegate: AnyObject {
        func didTapPlusButton(at indexPath: IndexPath)
        func didTapMinusButton(at indexPath: IndexPath)
    
}

class ProfitViewController: UIViewController {
    
    private let periods = ["1M", "1Y", "2Y", "3Y", "4Y", "5Y"]
    private var selectedPeriod = "1Y"
    var stocks = userStocksGlobal
    
    private let portfolioLabel: UILabel = {
        let label = UILabel()
        label.text = "Profitability"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .lightGray
        return label
    }()
    
    private let periodSegmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["1M", "1Y", "2Y", "3Y", "4Y", "5Y"])
        control.selectedSegmentIndex = 1
        control.addTarget(self, action: #selector(periodChanged), for: .valueChanged)
        return control
    }()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        table.separatorStyle = .none
        return table
    }()
    
    private let spentLabel = UILabel()
    private let amountLabel = UILabel()
    private let profitLabel = UILabel()
    
    private var headerView = UIView()
    private var mainView = UIView()
    private var headerViewLabel = UILabel()
    private let sharesEditButton = UIButton()
    private let grayline = UIView()
    
    private let graylineSecond = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "customBlack")
        
        stocks = userStocksGlobal
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(StockCell.self, forCellReuseIdentifier: "StockCell")
        
        setupUI()
//        periodChanged()
        updateProfitData(selectedPeriod: selectedPeriod)
    }
    
    private func setupUI() {
        spentLabel.textColor = .white
        amountLabel.textColor = .white
        tableView.isScrollEnabled = false
        
        sharesEditButton.setTitle("", for: .normal)
        sharesEditButton.setImage(UIImage(named: "editBtn"), for: .normal)
        sharesEditButton.tintColor = .white
        sharesEditButton.addTarget(self, action: #selector(addSharesButtonButton), for: .touchUpInside)
        mainView.addSubview(sharesEditButton)
        sharesEditButton.translatesAutoresizingMaskIntoConstraints = false
        
        mainView.backgroundColor = UIColor(named: "customDarkGray")
        view.addSubview(mainView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(portfolioLabel)
        portfolioLabel.translatesAutoresizingMaskIntoConstraints = false
        
        periodSegmentedControl.selectedSegmentTintColor = .clear
        periodSegmentedControl.tintColor = .white
        
        periodSegmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        periodSegmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)

        grayline.backgroundColor = .lightGray
        mainView.addSubview(grayline)
        grayline.translatesAutoresizingMaskIntoConstraints = false
        
        graylineSecond.backgroundColor = .lightGray
        mainView.addSubview(graylineSecond)
        graylineSecond.translatesAutoresizingMaskIntoConstraints = false
       
        view.addSubview(periodSegmentedControl)
        periodSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
       
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(spentLabel)
        spentLabel.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(amountLabel)
        amountLabel.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(profitLabel)
        profitLabel.translatesAutoresizingMaskIntoConstraints = false

        headerView.backgroundColor = UIColor(named: "customBlack")
        headerView.layer.cornerRadius = 12
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        headerViewLabel.text = "Profitability"
        headerViewLabel.textColor = .white
        headerViewLabel.textAlignment = .left
        headerViewLabel.font = .systemFont(ofSize: 32)
        headerView.addSubview(headerViewLabel)
        headerViewLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            headerView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 68),
            
            
            mainView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -12),
            mainView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            mainView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            portfolioLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 26),
            portfolioLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            portfolioLabel.rightAnchor.constraint(equalTo: sharesEditButton.rightAnchor, constant: 20),
            
            sharesEditButton.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 26),
            sharesEditButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
          
            
            periodSegmentedControl.topAnchor.constraint(equalTo: portfolioLabel.bottomAnchor, constant: 16),
            periodSegmentedControl.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            periodSegmentedControl.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            periodSegmentedControl.heightAnchor.constraint(equalToConstant: 37),
            
            tableView.topAnchor.constraint(equalTo: periodSegmentedControl.bottomAnchor, constant: 16),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tableView.heightAnchor.constraint(equalToConstant: CGFloat(userStocksGlobal.count * 50)),
            
            grayline.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 16),
            grayline.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            grayline.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            grayline.heightAnchor.constraint(equalToConstant: 1),
            
            spentLabel.topAnchor.constraint(equalTo: grayline.bottomAnchor, constant: 16),
            spentLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            spentLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            spentLabel.heightAnchor.constraint(equalToConstant: 20),
            
            amountLabel.topAnchor.constraint(equalTo: spentLabel.bottomAnchor, constant: 16),
            amountLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            amountLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            amountLabel.heightAnchor.constraint(equalToConstant: 20),
            
            profitLabel.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 16),
            profitLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            profitLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            profitLabel.heightAnchor.constraint(equalToConstant: 20),
            
            graylineSecond.topAnchor.constraint(equalTo: profitLabel.bottomAnchor, constant: 16),
            graylineSecond.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            graylineSecond.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            graylineSecond.heightAnchor.constraint(equalToConstant: 1),
            
            
            headerViewLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 10),
            headerViewLabel.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 16)
            
        ])
    }
    
    @objc private func periodChanged() {
        let selectedIndex = periodSegmentedControl.selectedSegmentIndex
        for index in 0..<periodSegmentedControl.numberOfSegments {
            periodSegmentedControl.subviews[index].layer.borderWidth = 2
            periodSegmentedControl.subviews[index].layer.cornerRadius = 8
            if index == selectedIndex {
                periodSegmentedControl.subviews[selectedIndex].layer.borderColor = UIColor.white.cgColor
            } else {
                periodSegmentedControl.subviews[index].layer.borderColor = UIColor.darkGray.cgColor
            }
        }
        selectedPeriod = periods[periodSegmentedControl.selectedSegmentIndex]
        updateProfitData(selectedPeriod: selectedPeriod)
    }
    
    private func updateProfitData(selectedPeriod: String) {
        stocks = userStocksGlobal
        switch selectedPeriod {
        case "1M":
            for i in stocks.indices {
                stocks[i].change /= 12
            }
        case "1Y":
            for i in stocks.indices {
                stocks[i].change = stocks[i].change
            }
        case "2Y":
            for i in stocks.indices {
                stocks[i].change *= 2
            }
        case "3Y":
            for i in stocks.indices {
                stocks[i].change *= 3
            }
        case "4Y":
            for i in stocks.indices {
                stocks[i].change *= 4
            }
        case "5Y":
            for i in stocks.indices {
                stocks[i].change *= 5
            }
        default:
            print("")
        }
        
        let spent = stocks.reduce(0) { $0 + ($1.price * Double($1.quantity)) }
        let profit = stocks.reduce(0) { $0 + ($1.price * $1.change / 100 * Double($1.quantity)) }
        let total = spent + profit
        
        let spentTitleLabel = UILabel()
        spentTitleLabel.text = "Was spent: "
        spentTitleLabel.textColor = .white
        
        let spentAmountLabel = UILabel()
        spentAmountLabel.text = "\(Int(spent)) $"
        spentAmountLabel.textColor = .white
        spentAmountLabel.textAlignment = .right
        
        let spentstackView = UIStackView(arrangedSubviews: [spentTitleLabel, spentAmountLabel])
        spentstackView.axis = .horizontal
        spentstackView.distribution = .equalSpacing
        spentstackView.translatesAutoresizingMaskIntoConstraints = false
        
        spentLabel.subviews.forEach { $0.removeFromSuperview() }
        spentLabel.addSubview(spentstackView)
        
        NSLayoutConstraint.activate([
            spentstackView.leadingAnchor.constraint(equalTo: spentLabel.leadingAnchor, constant: 0),
            spentstackView.trailingAnchor.constraint(equalTo: spentLabel.trailingAnchor, constant: 0),
            spentstackView.centerYAnchor.constraint(equalTo: spentLabel.centerYAnchor)
        ])
        
        
        let amountTitleLabel = UILabel()
        amountTitleLabel.text = "Amount after \(selectedPeriod): "
        amountTitleLabel.textColor = .white
        
        let amountAmountLabel = UILabel()
        amountAmountLabel.text = "\(Int(total)) $"
        amountAmountLabel.textColor = .white
        amountAmountLabel.textAlignment = .right
        
        let amountstackView = UIStackView(arrangedSubviews: [amountTitleLabel, amountAmountLabel])
        amountstackView.axis = .horizontal
        amountstackView.distribution = .equalSpacing
        amountstackView.translatesAutoresizingMaskIntoConstraints = false
        
        amountLabel.subviews.forEach { $0.removeFromSuperview() }
        amountLabel.addSubview(amountstackView)
        
        NSLayoutConstraint.activate([
            amountstackView.leadingAnchor.constraint(equalTo: amountLabel.leadingAnchor, constant: 0),
            amountstackView.trailingAnchor.constraint(equalTo: amountLabel.trailingAnchor, constant: 0),
            amountstackView.centerYAnchor.constraint(equalTo: amountLabel.centerYAnchor)
        ])
        
        let profitTitleLabel = UILabel()
        profitTitleLabel.text = "My profit: "
        profitTitleLabel.textColor = .white
        
        let profitAmountLabel = UILabel()
        profitAmountLabel.text = " \(Int(profit)) $"
        profitAmountLabel.textColor = .systemGreen
        profitAmountLabel.textAlignment = .right
        
        let profitstackView = UIStackView(arrangedSubviews: [profitTitleLabel, profitAmountLabel])
        profitstackView.axis = .horizontal
        profitstackView.distribution = .equalSpacing
        profitstackView.translatesAutoresizingMaskIntoConstraints = false
        
        profitLabel.subviews.forEach { $0.removeFromSuperview() }
        profitLabel.addSubview(profitstackView)
        
        NSLayoutConstraint.activate([
            profitstackView.leadingAnchor.constraint(equalTo: profitLabel.leadingAnchor, constant: 0),
            profitstackView.trailingAnchor.constraint(equalTo: profitLabel.trailingAnchor, constant: 0),
            profitstackView.centerYAnchor.constraint(equalTo: profitLabel.centerYAnchor)
        ])
        
        tableView.reloadData()
    }
    
    @objc func addSharesButtonButton() {
        let vc = CollectNewViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
    }
}

extension ProfitViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StockCell", for: indexPath) as! StockCell
        let stock = stocks[indexPath.row]
        cell.configure(with: stock)
        return cell
    }
}

class StockCell: UITableViewCell {
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .white
        return label
    }()
    
    private let percentageLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .white
        return label
    }()
    
    private let progressView: UIProgressView = {
        let progress = UIProgressView(progressViewStyle: .default)
        progress.tintColor = .systemGreen
        progress.layer.cornerRadius = 4
        progress.clipsToBounds = true
        return progress
    }()
    
    private let containerView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView(arrangedSubviews: [nameLabel, percentageLabel])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        containerView.addSubview(stackView)
        containerView.addSubview(progressView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.layer.cornerRadius = 4
        progressView.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            progressView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 4),
            progressView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            progressView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            progressView.heightAnchor.constraint(equalToConstant: 8)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with stock: Collect) {
        nameLabel.text = stock.name
        percentageLabel.text = "\(Int(stock.change))%"
        let progress = max(0, min(Float(stock.change / 100), 1.0))
        progressView.progress = progress
    }
}

