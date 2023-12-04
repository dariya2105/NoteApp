//
//  OnBoardingCell.swift
//  lesson 4
//
//  Created by Dariya on 8/12/23.
//

import Foundation
import UIKit

class OnBoardingCell: UICollectionViewCell {
    
    static let reuseId = "onboarding_cell"
    
    private lazy var onBoardImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "image1")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var onBoardLbl1: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 22, weight: .semibold)
        return view
    }()
    
    private lazy var onBoardLbl2: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 14, weight: .regular)
        view.textColor = .gray
        view.textAlignment = .left
        view.numberOfLines = 4
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initUI() {
        contentView.addSubview(onBoardImage)
        setupConstraintsForOnBoardImage()
        
        contentView.addSubview(onBoardLbl1)
        setupConstraintsForOnBoardLabel1()
        
        contentView.addSubview(onBoardLbl2)
        setupConstraintsForLabel2()
    }
    
    private func setupConstraintsForOnBoardImage() {
        NSLayoutConstraint.activate([
            onBoardImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 136),
            onBoardImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            onBoardImage.heightAnchor.constraint(equalToConstant: 140)
        ])
    }
    private func setupConstraintsForOnBoardLabel1() {
        NSLayoutConstraint.activate([
            onBoardLbl1.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            onBoardLbl1.topAnchor.constraint(equalTo: onBoardImage.bottomAnchor, constant: 52)
        ])
    }
    
    private func setupConstraintsForLabel2() {
        NSLayoutConstraint.activate([
            onBoardLbl2.topAnchor.constraint(equalTo: onBoardLbl1.bottomAnchor, constant: 16),
            onBoardLbl2.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            onBoardLbl2.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            onBoardLbl2.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    func setup(title: String, imageName: String, label: String) {
        onBoardLbl1.text = title
        onBoardImage.image = UIImage(named: imageName)
        onBoardLbl2.text = label
    }
    
}
