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
        view.font = .systemFont(ofSize: 15, weight: .heavy)
        return view
    }()
    
    private lazy var noteDescriptionLbl: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 12, weight: .regular)
        view.numberOfLines = 3
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
        setupConstraintsFortitleLbl()
        
        contentView.addSubview(noteDescriptionLbl)
        setupConstraintsForDescriptionLbl()
    }
    private func setupConstraintsFortitleLbl() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
    
    private func setupConstraintsForDescriptionLbl() {
        NSLayoutConstraint.activate([
            noteDescriptionLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            noteDescriptionLbl.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            noteDescriptionLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
    
    func setup(title: String, details: String) {
        titleLabel.text = title
        noteDescriptionLbl.text = details
    }
}
