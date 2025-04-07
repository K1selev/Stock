//
//  Quotes.swift
//  Kupaline
//
//  Created by Сергей Киселев on 01.03.2025.
//

import UIKit

struct Quote {
    let text: String
    let author: String
    let date: Date
    var isFavorite: Bool
}

class QuotesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var quotes: [Quote] = [
        Quote(text: "When you have money in your hands, only you forget who you are. But when you don't have money in your hands, everyone forgets who you are. That's life.", author: "Bill Gates", date: Date(), isFavorite: false),
        Quote(text: "The key to success in business is to determine where the world is going and get there first", author: "Bill Gates", date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!, isFavorite: false),
        Quote(text: "You will not earn 5,000 euros per month immediately after graduation and will not become a vice president until you have earned both achievements through your efforts", author: "Bill Gates", date: Calendar.current.date(byAdding: .day, value: -2, to: Date())!, isFavorite: false),
        Quote(text: "Yes, you can learn anything", author: "Bill Gates", date: Calendar.current.date(byAdding: .day, value: -3, to: Date())!, isFavorite: false),
        Quote(text: "Success is not the key to happiness. Happiness is the key to success.", author: "Albert Schweitzer", date: Calendar.current.date(byAdding: .day, value: -4, to: Date())!, isFavorite: false),
        Quote(text: "Don’t let yesterday take up too much of today.", author: "Will Rogers", date: Calendar.current.date(byAdding: .day, value: -5, to: Date())!, isFavorite: false),
        Quote(text: "The only way to do great work is to love what you do.", author: "Steve Jobs", date: Calendar.current.date(byAdding: .day, value: -6, to: Date())!, isFavorite: false),
        Quote(text: "Do what you can, with what you have, where you are.", author: "Theodore Roosevelt", date: Calendar.current.date(byAdding: .day, value: -7, to: Date())!, isFavorite: false),
        Quote(text: "It does not matter how slowly you go as long as you do not stop.", author: "Confucius", date: Calendar.current.date(byAdding: .day, value: -8, to: Date())!, isFavorite: false),
        Quote(text: "Act as if what you do makes a difference. It does.", author: "William James", date: Calendar.current.date(byAdding: .day, value: -9, to: Date())!, isFavorite: false),
        Quote(text: "Opportunities don't happen. You create them.", author: "Chris Grosser", date: Calendar.current.date(byAdding: .day, value: -10, to: Date())!, isFavorite: false),
        Quote(text: "The best way to predict the future is to create it.", author: "Peter Drucker", date: Calendar.current.date(byAdding: .day, value: -11, to: Date())!, isFavorite: false),
        Quote(text: "Success usually comes to those who are too busy to be looking for it.", author: "Henry David Thoreau", date: Calendar.current.date(byAdding: .day, value: -12, to: Date())!, isFavorite: false),
        Quote(text: "If you really look closely, most overnight successes took a long time.", author: "Steve Jobs", date: Calendar.current.date(byAdding: .day, value: -13, to: Date())!, isFavorite: false),
        Quote(text: "I find that the harder I work, the more luck I seem to have.", author: "Thomas Jefferson", date: Calendar.current.date(byAdding: .day, value: -14, to: Date())!, isFavorite: false),
        Quote(text: "Do one thing every day that scares you.", author: "Eleanor Roosevelt", date: Calendar.current.date(byAdding: .day, value: -15, to: Date())!, isFavorite: false),
        Quote(text: "Everything you’ve ever wanted is on the other side of fear.", author: "George Addair", date: Calendar.current.date(byAdding: .day, value: -16, to: Date())!, isFavorite: false),
        Quote(text: "Hardships often prepare ordinary people for an extraordinary destiny.", author: "C.S. Lewis", date: Calendar.current.date(byAdding: .day, value: -17, to: Date())!, isFavorite: false),
        Quote(text: "You miss 100% of the shots you don’t take.", author: "Wayne Gretzky", date: Calendar.current.date(byAdding: .day, value: -18, to: Date())!, isFavorite: false),
        Quote(text: "Your time is limited, so don’t waste it living someone else’s life.", author: "Steve Jobs", date: Calendar.current.date(byAdding: .day, value: -19, to: Date())!, isFavorite: false)
    ]
    private var headerView = UIView()
    private var mainView = UIView()
    private var headerViewLabel = UILabel()
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        title = "Quotes"
        view.backgroundColor = UIColor(named: "customBlack")
        tabBarController?.tabBar.barTintColor = UIColor(named: "customBlack")
         
        mainView.backgroundColor = UIColor(named: "customDarkGray")
        view.addSubview(mainView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(QuoteCell.self, forCellReuseIdentifier: "QuoteCell")
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        headerView.backgroundColor = UIColor(named: "customBlack")
        headerView.layer.cornerRadius = 12
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        headerViewLabel.text = "Quotes"
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
            
            tableView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 24),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -8),
            
            headerViewLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 10),
            headerViewLabel.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 16)
        
        ])
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            header.textLabel?.textColor = .lightGray
            header.contentView.backgroundColor = UIColor(named: "customDarkGray")
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        let uniqueDates = Set(quotes.map { formattedDate($0.date) })
        return uniqueDates.count + 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
                   return quotes.filter { $0.isFavorite }.count
        } else {
            let uniqueDates = Array(Set(quotes.map { formattedDate($0.date) })).sorted(by: >)
            let selectedDate = uniqueDates[section - 1]
            return quotes.filter { formattedDate($0.date) == selectedDate && !$0.isFavorite }.count
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Saved"
        } else {
            let uniqueDates = Array(Set(quotes.map { formattedDate($0.date) })).sorted(by: >)
            return uniqueDates[section - 1]
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuoteCell", for: indexPath) as! QuoteCell
                let sectionQuotes: [Quote]
                
        if indexPath.section == 0 {
            sectionQuotes = quotes.filter { $0.isFavorite }
        } else {
            let uniqueDates = Array(Set(quotes.map { formattedDate($0.date) })).sorted(by: >)
            let selectedDate = uniqueDates[indexPath.section - 1]
            sectionQuotes = quotes.filter { formattedDate($0.date) == selectedDate && !$0.isFavorite }
        }
        let quote = sectionQuotes[indexPath.row]
        cell.configure(with: quote)
        
        cell.favoriteButtonAction = { [weak self] in
            guard let self = self else { return }
            if let index = self.quotes.firstIndex(where: { $0.text == quote.text }) {
                self.quotes[index].isFavorite.toggle()
                self.tableView.reloadData()
            }
        }
        
        cell.shareButtonAction = {
            let activityVC = UIActivityViewController(activityItems: [quote.text], applicationActivities: nil)
            self.present(activityVC, animated: true)
        }
        
        return cell
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}
