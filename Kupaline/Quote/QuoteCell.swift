//
//  QuoteCell.swift
//  Kupaline
//
//  Created by Сергей Киселев on 04.03.2025.
//

import UIKit

class QuoteCell: UITableViewCell {
    
    private let quoteLabel = UILabel()
    private let authorLabel = UILabel()
    private let favoriteButton = UIButton(type: .system)
    private let shareButton = UIButton(type: .system)
    private let grayline = UIView()
    
    var favoriteButtonAction: (() -> Void)?
    var shareButtonAction: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .clear
        
        quoteLabel.numberOfLines = 0
        quoteLabel.textColor = .white
        authorLabel.textColor = .lightGray
        
        favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        favoriteButton.addTarget(self, action: #selector(favoriteTapped), for: .touchUpInside)
        
        shareButton.setImage(UIImage(systemName: "arrowshape.turn.up.right"), for: .normal)
        shareButton.tintColor = .white
        shareButton.addTarget(self, action: #selector(shareTapped), for: .touchUpInside)
        quoteLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        
        grayline.backgroundColor = .lightGray
        contentView.addSubview(grayline)
        grayline.translatesAutoresizingMaskIntoConstraints = false
       
        
        contentView.addSubview(quoteLabel)
        contentView.addSubview(authorLabel)
        contentView.addSubview(shareButton)
        contentView.addSubview(favoriteButton)
        
        NSLayoutConstraint.activate([
            
        contentView.heightAnchor.constraint(equalToConstant: 136),
            
        quoteLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
        quoteLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
        quoteLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
        
        authorLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
        authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
        
        favoriteButton.centerYAnchor.constraint(equalTo: authorLabel.centerYAnchor),
        favoriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
        favoriteButton.widthAnchor.constraint(equalToConstant: 32),
        favoriteButton.heightAnchor.constraint(equalToConstant: 24),

        shareButton.centerYAnchor.constraint(equalTo: authorLabel.centerYAnchor),
        shareButton.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: -10),
        shareButton.widthAnchor.constraint(equalToConstant: 24),
        shareButton.heightAnchor.constraint(equalToConstant: 24),
        
        grayline.topAnchor.constraint(equalTo: shareButton.bottomAnchor, constant: 16),
        grayline.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
        grayline.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
        grayline.heightAnchor.constraint(equalToConstant: 1),
       
        
        ])
    }
    
    func configure(with quote: Quote) {
        quoteLabel.text = quote.text
        authorLabel.text = quote.author
        authorLabel.font = .italicSystemFont(ofSize: 14)
        favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        favoriteButton.tintColor = quote.isFavorite ? .red : .white
    }
    
    @objc private func favoriteTapped() {
        favoriteButtonAction?()
    }
    
    @objc private func shareTapped() {
        shareButtonAction?()
    }
}

