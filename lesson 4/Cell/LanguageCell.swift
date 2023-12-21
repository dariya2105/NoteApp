//
//  LanguageCell.swift
//  lesson 4
//
//  Created by Dariya on 21/12/23.
//

import Foundation
import UIKit

class LanguageCell: UITableViewCell {
    
    static var reuseId = "language_cell"
    
    private lazy var iconImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 17)
        view.textAlignment = .center
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .systemGray6
        initUI()
    }
    
    func setup(language: Language) {
        iconImageView.image = UIImage(named: language.image)
        titleLabel.text = language.title
    }
    
    private func initUI() {
        contentView.addSubview(iconImageView)
        setupConstraintsForIconImage()
        
        contentView.addSubview(titleLabel)
        setupConstraintsForTitleLabel()
    }
    
    private func setupConstraintsForIconImage() {
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 32),
            iconImageView.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    private func setupConstraintsForTitleLabel() {
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
