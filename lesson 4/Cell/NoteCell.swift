//
//  NoteCell.swift
//  lesson 4
//
//  Created by Dariya on 13/12/23.
//

import Foundation
import UIKit

class NoteCell: UICollectionViewCell {
    
    static var reuseId = "note_cell"
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 10
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initUI() {
        contentView.addSubview(titleLabel)
        setupConstraintsFortiteLbl()
    }
    private func setupConstraintsFortiteLbl() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
    
    func setup(title: String) {
        titleLabel.text = title
    }
}
