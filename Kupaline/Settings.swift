//
//  Settings.swift
//  Kupaline
//
//  Created by Сергей Киселев on 01.03.2025.
//

import UIKit
import StoreKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let tableView = UITableView()
    
    private let menuItems: [(title: String, action: Selector?)] = [
        ("Terms and conditions", #selector(openLink)),
        ("Policy privacy", #selector(openLink)),
        ("Feedback", #selector(openLink)),
        ("Rate app", #selector(rateApp))
    ]
    
        private var headerView = UIView()
        private var mainView = UIView()
        private var headerViewLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(named: "customBlack")
        title = "Settings"
        
        mainView.backgroundColor = UIColor(named: "customDarkGray")
        view.addSubview(mainView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        
        headerView.backgroundColor = UIColor(named: "customBlack")
        headerView.layer.cornerRadius = 12
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        headerViewLabel.text = "Settings"
        headerViewLabel.textColor = .white
        headerViewLabel.textAlignment = .left
        headerViewLabel.font = .systemFont(ofSize: 32)
        headerView.addSubview(headerViewLabel)
        headerViewLabel.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .clear
        tableView.separatorColor = .lightGray
        tableView.frame = view.bounds
        tableView.translatesAutoresizingMaskIntoConstraints = false
        mainView.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            headerView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 68),
            
            
            mainView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -12),
            mainView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            mainView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            tableView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 24),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            headerViewLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 10),
            headerViewLabel.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 16)
        ])
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = menuItems[indexPath.row].title
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .clear
        let image = UIImage(named: "chevron-lef")
        let checkmark  = UIImageView(frame:CGRect(x:0, y:0, width:(image?.size.width)!, height:(image?.size.height)!));
        checkmark.image = image
        cell.accessoryView = checkmark
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
            if indexPath.row < 3 {
                openLink(indexPath.row)
            } else {
                rateApp()
            }
    }
    @objc private func openLink(_ index: Int) {
        let urls = [
            "https://hh.ru/resume/b60a7172ff0938668d0039ed1f376f6a643651",
            "https://hh.ru/resume/b60a7172ff0938668d0039ed1f376f6a643651",
            "https://hh.ru/resume/b60a7172ff0938668d0039ed1f376f6a643651"
        ]
        if index < urls.count, let url = URL(string: urls[index]) {
            UIApplication.shared.open(url)
        }
    }
    
    @objc private func rateApp() {
        if let scene = view.window?.windowScene {
            SKStoreReviewController.requestReview(in: scene)
        }
    }
}
