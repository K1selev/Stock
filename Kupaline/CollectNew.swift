//
//  CollectNew.swift
//  Kupaline
//
//  Created by Сергей Киселев on 04.03.2025.
//

import UIKit

struct Collect {
    let name: String
    let price: Double
    var change: Double
    let logo: UIImage?
    var quantity: Int
}
protocol CollectCellDelegate: AnyObject {
        func didTapPlusButton(at indexPath: IndexPath)
        func didTapMinusButton(at indexPath: IndexPath)
    
}

class CollectNewViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    private let userBalance = UserDefaults.standard.string(forKey: "Wallet")
    var walletAmount: Double = 15731.0
    var stocks: [Collect] = []
    var filteredStocks: [Collect] = []
    
    let searchBar = UISearchBar()
    let collectionView: UICollectionView
    let walletLabel = UILabel()
    let walletTitleLabel = UILabel()
    var saveButton = CustomButton()
    var cancelButton = CustomButton()
    
    private var headerView = UIView()
    private var mainView = UIView()
    private var headerViewLabel = UILabel()
    private let headerButton = UIButton()
    private let grayline = UIView()
    
    private let sharesTitleLabel = UILabel()

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
                
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder: NSCoder) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "customDarkGray")
        setupData()
        setupUI()
    }
    
    func setupData() {
        stocks = [
            Collect(name: "Apple", price: 2850, change: 11.2, logo: UIImage(named: "apple"), quantity: 0),
            Collect(name: "Amazon", price: 2100, change: 8.6, logo: UIImage(named: "amazon"), quantity: 0),
            Collect(name: "KFC", price: 3400, change: 21.5, logo: UIImage(named: "kfc"), quantity: 0),
            Collect(name: "Raiffeisen", price: 3120, change: 15.3, logo: UIImage(named: "raiffeisen"), quantity: 0),
            Collect(name: "Google", price: 996, change: 6.6, logo: UIImage(named: "google"), quantity: 0),
            Collect(name: "Lays", price: 544, change: 4.5, logo: UIImage(named: "lays"), quantity: 0),
            Collect(name: "Google", price: 996, change: 6.6, logo: UIImage(named: "google"), quantity: 0),
            Collect(name: "BMW", price: 3400, change: 21.5, logo: UIImage(named: "BMW"), quantity: 0),
            Collect(name: "Vkontakte", price: 3120, change: 15.3, logo: UIImage(named: "Vkontakte"), quantity: 0),
            Collect(name: "Tik Tok", price: 2850, change: 11.2, logo: UIImage(named: "TikTok"), quantity: 0),
            Collect(name: "Netflix", price: 2100, change: 8.6, logo: UIImage(named: "Netflix"), quantity: 0),
            Collect(name: "Xiaomi", price: 996, change: 6.6, logo: UIImage(named: "Xiaomi"), quantity: 0),
            Collect(name: "Samsung", price: 554, change: 4.5, logo: UIImage(named: "Samsung"), quantity: 0)
        ]
        filteredStocks = stocks
    }
    
    func setupUI() {
        
        view.backgroundColor = UIColor(named: "customBlack")
        
        mainView.backgroundColor = UIColor(named: "customDarkGray")
        view.addSubview(mainView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        
        headerView.backgroundColor = UIColor(named: "customBlack")
        headerView.layer.cornerRadius = 12
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        headerViewLabel.text = "Collect a briefcase"
        headerViewLabel.textColor = .white
        headerViewLabel.textAlignment = .left
        headerViewLabel.font = .systemFont(ofSize: 24)
        headerView.addSubview(headerViewLabel)
        headerViewLabel.translatesAutoresizingMaskIntoConstraints = false
        
        headerButton.setImage(UIImage(named: "chevron-left-b"), for: .normal)
        headerView.addSubview(headerButton)
        headerButton.addTarget(self, action: #selector(didTapButtonCancel), for: .touchUpInside)
        headerButton.translatesAutoresizingMaskIntoConstraints = false
        
        grayline.backgroundColor = .lightGray
        mainView.addSubview(grayline)
        grayline.translatesAutoresizingMaskIntoConstraints = false
        
        walletTitleLabel.text = "Wallet"
        walletTitleLabel.textColor = .lightGray
        walletTitleLabel.font = UIFont.systemFont(ofSize: 16)
        walletTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(walletTitleLabel)
        
        walletLabel.text = "\(userBalance ?? "") $"
        walletLabel.textColor = .white
        walletLabel.font = UIFont.boldSystemFont(ofSize: 32)
        walletLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(walletLabel)
        
        sharesTitleLabel.text = "Shares"
        sharesTitleLabel.textColor = .lightGray
        sharesTitleLabel.font = UIFont.systemFont(ofSize: 16)
        sharesTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(sharesTitleLabel)
        
        searchBar.delegate = self
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = ""
        searchBar.tintColor = .white
        searchBar.searchTextField.textColor = .white
        searchBar.layer.borderColor = UIColor.lightGray.cgColor
        searchBar.layer.borderWidth = 1
        searchBar.layer.cornerRadius = 16
        searchBar.clipsToBounds = true
        searchBar.searchTextField.leftView?.tintColor = .white
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBar)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.register(CollectNewCell.self, forCellWithReuseIdentifier: "CollectNewCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        
//        cancelButton.setTitle("Cancel", for: .normal)
//        cancelButton.backgroundColor = .darkGray
//        cancelButton.layer.cornerRadius = 10
        
        cancelButton = CustomButton(textColor: .white, background: .lightGray, title: "Cancel")
        cancelButton.addTarget(self, action: #selector(didTapButtonCancel), for: .touchUpInside)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cancelButton)
        
//        saveButton.setTitle("Save", for: .normal)
//        saveButton.backgroundColor = .white
//        saveButton.setTitleColor(UIColor(named: "customBlack"), for: .normal)
//        saveButton.layer.cornerRadius = 10
        saveButton = CustomButton(textColor: UIColor(named: "customBlack")!, background: .white, title: "Save")
        saveButton.addTarget(self, action: #selector(didTapButtonSave), for: .touchUpInside)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            walletTitleLabel.topAnchor.constraint(equalTo:mainView.topAnchor, constant: 28),
            walletTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            walletLabel.topAnchor.constraint(equalTo: walletTitleLabel.bottomAnchor, constant: 16),
            walletLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            grayline.topAnchor.constraint(equalTo: walletLabel.bottomAnchor, constant: 26),
            grayline.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 16),
            grayline.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -16),
            grayline.heightAnchor.constraint(equalToConstant: 1),
            
            sharesTitleLabel.topAnchor.constraint(equalTo: grayline.bottomAnchor, constant: 16),
            sharesTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            searchBar.topAnchor.constraint(equalTo: sharesTitleLabel.bottomAnchor, constant: 16),
            searchBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            searchBar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: saveButton.topAnchor, constant: -16),
            
            cancelButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            cancelButton.heightAnchor.constraint(equalToConstant: 52),
            cancelButton.widthAnchor.constraint(equalToConstant: 168),
            
            saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            saveButton.heightAnchor.constraint(equalToConstant: 52),
            saveButton.widthAnchor.constraint(equalToConstant: 168),
            
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            headerView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 68),
            
            
            mainView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -12),
            mainView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            mainView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            headerButton.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 10),
            headerButton.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 16),
            headerButton.widthAnchor.constraint(equalToConstant: 32),
            headerButton.heightAnchor.constraint(equalToConstant: 32),
            
            headerViewLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 10),
            headerViewLabel.leftAnchor.constraint(equalTo: headerButton.rightAnchor, constant: 16),
            
        ])
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredStocks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectNewCell", for: indexPath) as! CollectNewCell
        cell.configure(with: filteredStocks[indexPath.row], at: indexPath)
        cell.plusBtn.addTarget(self, action: #selector(didTapPlusButton(_:)), for: .touchUpInside)
        cell.minusBtn.addTarget(self, action: #selector(didTapMinusButton(_:)), for: .touchUpInside)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 32, height: 42)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredStocks = searchText.isEmpty ? stocks : stocks.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        collectionView.reloadData()
    }
    
    @objc func didTapPlusButton(_ sender: UIButton) {
        let index = sender.tag
        var stock = filteredStocks[index]
        stock.quantity += 1
        filteredStocks[index] = stock
        let indexPath = IndexPath(row: index, section: 0)
        collectionView.reloadItems(at: [indexPath])
    }

    @objc func didTapMinusButton(_ sender: UIButton) {
        let index = sender.tag
        var stock = filteredStocks[index]
        if stock.quantity > 0 {
            stock.quantity -= 1
        }
        filteredStocks[index] = stock
        let indexPath = IndexPath(row: index, section: 0)
        collectionView.reloadItems(at: [indexPath])
    }
    
    @objc func didTapButtonCancel() {
        let vc = TabBar()
        vc.selectedIndex = 0
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
//    @objc func didTapButtonSave() {
//        let vc = TabBar()
//        for stock in filteredStocks {
//            if stock.quantity > 0 {
//                userStocks.append(stock)
//            }
//        }
//        vc.selectedIndex = 0
//        vc.modalPresentationStyle = .fullScreen
//        present(vc, animated: true)
//    }
    @objc func didTapButtonSave() {
        let vc = TabBar()
        let stocksToAppend = filteredStocks.filter { $0.quantity > 0 }
//        HomeViewController().userStocks.append(contentsOf: stocksToAppend)
        userStocksGlobal.append(contentsOf: stocksToAppend)
        vc.selectedIndex = 0
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }

}

class CollectNewCell: UICollectionViewCell {
    weak var delegate: CollectCellDelegate?

    let logoImageView = UIImageView()
    let nameLabel = UILabel()
    let priceLabel = UILabel()
    let changeLabel = UILabel()
    let plusBtn = UIButton()
    let minusBtn = UIButton()
    let quantityLabel = UILabel()

    var stock: Collect?
    var indexPath: IndexPath?
    
    func configure(with stock: Collect, at indexPath: IndexPath) {
        self.stock = stock
        self.indexPath = indexPath  // Сохраняем индекс в ячейке
        
        backgroundColor = .clear
        nameLabel.text = stock.name
        nameLabel.textColor = .white
        priceLabel.text = "\(stock.price) $"
        priceLabel.textColor = .white
        changeLabel.text = stock.change > 0 ? "+ " + "\(stock.change) %" : "- " + "\(stock.change) %"
        changeLabel.textColor = stock.change > 0 ? .green : .red
        logoImageView.image = stock.logo
        quantityLabel.text = "\(stock.quantity)"
        quantityLabel.textColor = .white
        
        plusBtn.setImage(UIImage(systemName: "plus"), for: .normal)
        plusBtn.tintColor = .white
        plusBtn.tag = indexPath.row
        plusBtn.addTarget(self, action: #selector(didTapPlusButton), for: .touchUpInside)
        
        minusBtn.setImage(UIImage(systemName: "minus"), for: .normal)
        minusBtn.tintColor = .white
        minusBtn.tag = indexPath.row
        
        minusBtn.addTarget(self, action: #selector(didTapMinusButton), for: .touchUpInside)
        setupLayout()
    }

    @objc func didTapPlusButton() {
            if let indexPath = indexPath {
                delegate?.didTapPlusButton(at: indexPath)
            }
        }

        @objc func didTapMinusButton() {
            if let indexPath = indexPath {
                delegate?.didTapMinusButton(at: indexPath)
            }
        }
    
    private func setupLayout() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        changeLabel.translatesAutoresizingMaskIntoConstraints = false
        plusBtn.translatesAutoresizingMaskIntoConstraints = false
        minusBtn.translatesAutoresizingMaskIntoConstraints = false
        quantityLabel.translatesAutoresizingMaskIntoConstraints = false

        addSubview(logoImageView)
        addSubview(nameLabel)
        addSubview(priceLabel)
        addSubview(changeLabel)
        addSubview(plusBtn)
        addSubview(minusBtn)
        addSubview(quantityLabel)

        NSLayoutConstraint.activate([
            logoImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            logoImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.leftAnchor.constraint(equalTo: logoImageView.rightAnchor, constant: 8),

            plusBtn.centerYAnchor.constraint(equalTo: centerYAnchor),
            plusBtn.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            plusBtn.widthAnchor.constraint(equalToConstant: 24),
            plusBtn.heightAnchor.constraint(equalToConstant: 24),

            quantityLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            quantityLabel.rightAnchor.constraint(equalTo: plusBtn.leftAnchor),
            quantityLabel.widthAnchor.constraint(equalToConstant: 24),
            quantityLabel.heightAnchor.constraint(equalToConstant: 24),

            minusBtn.centerYAnchor.constraint(equalTo: centerYAnchor),
            minusBtn.rightAnchor.constraint(equalTo: quantityLabel.leftAnchor, constant: -16),
            minusBtn.widthAnchor.constraint(equalToConstant: 24),
            minusBtn.heightAnchor.constraint(equalToConstant: 24),

            priceLabel.bottomAnchor.constraint(equalTo: centerYAnchor, constant: 2),
            priceLabel.rightAnchor.constraint(equalTo: minusBtn.leftAnchor, constant: -24),
            changeLabel.topAnchor.constraint(equalTo: centerYAnchor, constant: -2),
            changeLabel.rightAnchor.constraint(equalTo: minusBtn.leftAnchor, constant: -24),
        ])
    }
}





//    private var headerView = UIView()
//    private var mainView = UIView()
//    private var headerViewLabel = UILabel()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = UIColor(named: "customBlack")
//
//        mainView.backgroundColor = UIColor(named: "customDarkGray")
//        view.addSubview(mainView)
//        mainView.translatesAutoresizingMaskIntoConstraints = false
//
//        headerView.backgroundColor = UIColor(named: "customBlack")
//        headerView.layer.cornerRadius = 12
//        view.addSubview(headerView)
//        headerView.translatesAutoresizingMaskIntoConstraints = false
//
//        headerViewLabel.text = "Profitability"
//        headerViewLabel.textColor = .white
//        headerViewLabel.textAlignment = .left
//        headerViewLabel.font = .systemFont(ofSize: 32)
//        headerView.addSubview(headerViewLabel)
//        headerViewLabel.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            headerView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
//            headerView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
//            headerView.heightAnchor.constraint(equalToConstant: 68),
//
//
//            mainView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -12),
//            mainView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
//            mainView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
//            mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//
//            headerViewLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 10),
//            headerViewLabel.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 16)
//        ])
//    }
//}
