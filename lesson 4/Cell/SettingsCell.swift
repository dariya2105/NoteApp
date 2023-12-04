//
//  SettingsCell.swift
//  lesson 4
//
//  Created by Dariya on 8/12/23.
//

import Foundation
import UIKit

protocol SettingCellDelegate: AnyObject {
    func didSwithOn(isOn: Bool)
    func didSelectLanguage()
}

class SettingsCell: UITableViewCell {
    
    static let reuseId = "reuse_cell"
    
    var delegate: SettingCellDelegate?
    
    private lazy var languageBtn: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Русский  >", for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var settingImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var settingTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var settingSwith: UISwitch = {
        let view = UISwitch()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isOn = UserDefaults.standard.bool(forKey: "theme")
        return view
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initUI() {
        contentView.addSubview(settingImage)
        setupConstraintsForSettingImage()
        
        contentView.addSubview(settingTitle)
        setupConstraintsForSettingTitle()
        
        contentView.addSubview(settingSwith)
        setupConstraintsForSettingSwith()
    }
    
    private func setupConstraintsForLanguageBtn() {
        NSLayoutConstraint.activate([
            languageBtn.centerYAnchor.constraint(equalTo: centerYAnchor),
            languageBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    
    @objc private func selectLanguage() {
        delegate?.didSelectLanguage()
    }
    
    private func setupConstraintsForSettingImage() {
        NSLayoutConstraint.activate([
            settingImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            settingImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10)
        ])
    }
    
    private func setupConstraintsForSettingTitle() {
        NSLayoutConstraint.activate([
            settingTitle.centerYAnchor.constraint(equalTo: centerYAnchor),
            settingTitle.leadingAnchor.constraint(equalTo: settingImage.trailingAnchor, constant: 15)
        ])
    }
    
    private func setupConstraintsForSettingSwith() {
        NSLayoutConstraint.activate([
            settingSwith.centerYAnchor.constraint(equalTo: centerYAnchor),
            settingSwith.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
        settingSwith.addTarget(self, action: #selector(swithOnOff), for: .valueChanged)
    }
    
    @objc private func swithOnOff() {
        delegate?.didSwithOn(isOn: settingSwith.isOn)
    }
    
    func setUp(image: String, title: String, type: Types) {
        settingImage.image = UIImage(named: image)
        settingTitle.text = title
        
        if title == "Выбрать язык" {
            contentView.addSubview(languageBtn)
            setupConstraintsForLanguageBtn()
            languageBtn.addTarget(self, action: #selector(selectLanguage), for: .touchUpInside)
            
            let isSwitchOn = settingSwith.isOn
            updateLanguageButtonTitleColor(isSwitchOn: isSwitchOn)
        } else {
            languageBtn.removeFromSuperview()
        }
        
        if type == .configure {
            settingSwith.isHidden = false
            settingSwith.addTarget(self, action: #selector(switchStateChanged), for: .valueChanged)
        } else {
            settingSwith.isHidden = true
        }
        
        if UserDefaults.standard.bool(forKey: "theme") == true {
            settingSwith.isOn = true
        } else {
            settingSwith.isOn = false
        }
        
    }
    @objc private func switchStateChanged() {
        let isSwitchOn = settingSwith.isOn
        updateLanguageButtonTitleColor(isSwitchOn: isSwitchOn)
    }
    
    private func updateLanguageButtonTitleColor(isSwitchOn: Bool) {
        let titleColor: UIColor = isSwitchOn ? .white : .black
        languageBtn.setTitleColor(titleColor, for: .normal)
    }
}
