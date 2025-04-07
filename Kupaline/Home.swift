//
//  Home.swift
//  Kupaline
//
//  Created by Сергей Киселев on 01.03.2025.
//

import UIKit

class HomeViewController: UIViewController,  UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    private let userBalance = UserDefaults.standard.string(forKey: "Wallet")
    private var headerView = UIView()
    private var mainView = UIView()
    private var headerViewLabel = UILabel()
    private let walletLabel = UILabel()
    private let walletEditButton = UIButton()
    private let walletBalanceLabel = UILabel()
    private let addSharesLabel = UILabel()
    private let addSharesButton = UIButton()
    private let grayline = UIView()
    
    private let sharesEditButton = UIButton()
    var stocks: [Collect] = []
    var filteredStocks: [Collect] = []
    let searchBar = UISearchBar()
    let collectionView: UICollectionView
    private let sharesTitleLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "customBlack")
        setupUI()
    }
    
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
    
    private func setupUI() {
        mainView.backgroundColor = UIColor(named: "customDarkGray")
        view.addSubview(mainView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        
        headerView.backgroundColor = UIColor(named: "customBlack")
        headerView.layer.cornerRadius = 12
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        headerViewLabel.text = "Home"
        headerViewLabel.textColor = .white
        headerViewLabel.textAlignment = .left
        headerViewLabel.font = .systemFont(ofSize: 32)
        headerView.addSubview(headerViewLabel)
        headerViewLabel.translatesAutoresizingMaskIntoConstraints = false
        
        walletLabel.text = "Wallet"
        walletLabel.textColor = .lightGray
        walletLabel.textAlignment = .left
        walletLabel.font = .systemFont(ofSize: 16)
        mainView.addSubview(walletLabel)
        walletLabel.translatesAutoresizingMaskIntoConstraints = false
        
        walletEditButton.setTitle("", for: .normal)
        walletEditButton.setImage(UIImage(named: "editBtn"), for: .normal)
        walletEditButton.tintColor = .white
        walletEditButton.addTarget(self, action: #selector(didTapWalletEditButton), for: .touchUpInside)
        mainView.addSubview(walletEditButton)
        walletEditButton.translatesAutoresizingMaskIntoConstraints = false
        
        sharesEditButton.setTitle("", for: .normal)
        sharesEditButton.setImage(UIImage(named: "editBtn"), for: .normal)
        sharesEditButton.tintColor = .white
        sharesEditButton.addTarget(self, action: #selector(addSharesButtonButton), for: .touchUpInside)
        mainView.addSubview(sharesEditButton)
        sharesEditButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        walletBalanceLabel.text = (userBalance ?? "") + " $"
        walletBalanceLabel.textColor = .white
        walletBalanceLabel.textAlignment = .left
        walletBalanceLabel.font = .systemFont(ofSize: 32, weight: .bold)
        mainView.addSubview(walletBalanceLabel)
        walletBalanceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        grayline.backgroundColor = .lightGray
        mainView.addSubview(grayline)
        grayline.translatesAutoresizingMaskIntoConstraints = false
        
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
        
        addSharesButton.setTitle("", for: .normal)
        addSharesButton.setImage(UIImage(named: "plusBtn"), for: .normal)
        addSharesButton.tintColor = .white
        addSharesButton.addTarget(self, action: #selector(addSharesButtonButton), for: .touchUpInside)
        mainView.addSubview(addSharesButton)
        addSharesButton.translatesAutoresizingMaskIntoConstraints = false
        
        addSharesLabel.text = "Add shares"
        addSharesLabel.textColor = .white
        addSharesLabel.textAlignment = .center
        addSharesLabel.font = .systemFont(ofSize: 16)
        mainView.addSubview(addSharesLabel)
        addSharesLabel.translatesAutoresizingMaskIntoConstraints = false
       
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.register(HomeCell.self, forCellWithReuseIdentifier: "HomeCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        
        if userStocksGlobal.isEmpty {
            addSharesButton.isHidden = false
            addSharesLabel.isHidden = false
            collectionView.isHidden = true
            searchBar.isHidden = true
            sharesTitleLabel.isHidden = true
            sharesEditButton.isHidden = true
        } else {
            stocks = userStocksGlobal
            addSharesButton.isHidden = true
            addSharesLabel.isHidden = true
            collectionView.isHidden = false
            searchBar.isHidden = false
            sharesTitleLabel.isHidden = false
            sharesEditButton.isHidden = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if userStocksGlobal.isEmpty {
                self.addSharesButton.isHidden = false
                self.addSharesLabel.isHidden = false
                self.collectionView.isHidden = true
                self.searchBar.isHidden = true
                self.sharesTitleLabel.isHidden = true
                self.sharesEditButton.isHidden = true
            } else {
                self.stocks = userStocksGlobal
                self.filteredStocks = self.stocks
                self.addSharesButton.isHidden = true
                self.addSharesLabel.isHidden = true
                self.collectionView.isHidden = false
                self.collectionView.reloadData()
                self.searchBar.isHidden = false
                self.sharesTitleLabel.isHidden = false
                self.sharesEditButton.isHidden = false
            }
        }
        makeConstraints()
    }
    
    private func makeConstraints() {
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
            
            walletEditButton.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 28),
            walletEditButton.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -16),
            walletEditButton.widthAnchor.constraint(equalToConstant: 24),
            walletEditButton.heightAnchor.constraint(equalToConstant: 24),
            
            walletLabel.topAnchor.constraint(equalTo: walletEditButton.topAnchor),
            walletLabel.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 16),
            
            walletBalanceLabel.topAnchor.constraint(equalTo: walletLabel.bottomAnchor, constant: 8),
            walletBalanceLabel.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 16),
            
            grayline.topAnchor.constraint(equalTo: walletBalanceLabel.bottomAnchor, constant: 16),
            grayline.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 16),
            grayline.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -16),
            grayline.heightAnchor.constraint(equalToConstant: 1),
            
            addSharesButton.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            addSharesButton.topAnchor.constraint(equalTo: mainView.centerYAnchor, constant: 8),
            
            addSharesLabel.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            addSharesLabel.bottomAnchor.constraint(equalTo: mainView.centerYAnchor, constant: -8),
            
            sharesTitleLabel.topAnchor.constraint(equalTo: grayline.bottomAnchor, constant: 16),
            sharesTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            sharesEditButton.topAnchor.constraint(equalTo: grayline.bottomAnchor, constant: 16),
            sharesEditButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            
            searchBar.topAnchor.constraint(equalTo: sharesTitleLabel.bottomAnchor, constant: 16),
            searchBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            searchBar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            
        ])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredStocks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as! HomeCell
        cell.configure(with: filteredStocks[indexPath.row], at: indexPath)
//        cell.plusBtn.addTarget(self, action: #selector(didTapPlusButton(_:)), for: .touchUpInside)
//        cell.minusBtn.addTarget(self, action: #selector(didTapMinusButton(_:)), for: .touchUpInside)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 32, height: 42)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredStocks = searchText.isEmpty ? stocks : stocks.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        collectionView.reloadData()
    }
    
    @objc func didTapWalletEditButton() {
        let vc = OnboardingWallet()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
    }
    @objc func addSharesButtonButton() {
        let vc = CollectNewViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
    }
}

class HomeCell: UICollectionViewCell {
    weak var delegate: CollectCellDelegate?

    let logoImageView = UIImageView()
    let nameLabel = UILabel()
    let priceLabel = UILabel()
    let changeLabel = UILabel()

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
        
        setupLayout()
    }
    
    private func setupLayout() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        changeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(logoImageView)
        addSubview(nameLabel)
        addSubview(priceLabel)
        addSubview(changeLabel)

        NSLayoutConstraint.activate([
            logoImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            logoImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.leftAnchor.constraint(equalTo: logoImageView.rightAnchor, constant: 8),
            priceLabel.bottomAnchor.constraint(equalTo: centerYAnchor, constant: 2),
            priceLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            changeLabel.topAnchor.constraint(equalTo: centerYAnchor, constant: -2),
            changeLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
        ])
    }
}
