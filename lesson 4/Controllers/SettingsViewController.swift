//
//  TableViewController.swift
//  lesson 4
//
//  Created by Dariya on 4/12/23.
//

import UIKit

class SettingsViewController: UIViewController {
    
    private let settingsTableView = UITableView()
    
    private var settings = [
        Settings(image: "language",title: "Выбрать язык", type: .none),
        Settings(image: "moon", title: "Темная тема", type: .configure),
        Settings(image: "trash", title: "Очистить данные", type: .none)
    ]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let isDarkTheme = UserDefaults.standard.bool(forKey: "theme")
        if isDarkTheme == true {
            overrideUserInterfaceStyle = .dark
            navigationController?.overrideUserInterfaceStyle = .dark
        } else {
            navigationController?.overrideUserInterfaceStyle = .light
            overrideUserInterfaceStyle = .light
        }
        
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Настройки"
        
        view.addSubview(settingsTableView)
        setupConstraintsForTableView()
        
        print(UserDefaults.standard.bool(forKey: "theme"))
    }
    
    private func setupConstraintsForTableView() {
        settingsTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            settingsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            settingsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            settingsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            //settingsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            settingsTableView.heightAnchor.constraint(equalToConstant: 130)
        ])
        settingsTableView.layer.cornerRadius = 10
        settingsTableView.clipsToBounds = true
        settingsTableView.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.reuseId)
        settingsTableView.dataSource = self
        settingsTableView.delegate = self
    }
    
}

extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.reuseId, for: indexPath) as! SettingsCell
        
        let settingItem = settings[indexPath.row]
        cell.setUp(image: settingItem.image, title: settingItem.title, type: settingItem.type)
        cell.delegate = self
        cell.backgroundColor = .systemGray5
        return cell
    }
}

extension SettingsViewController: SettingCellDelegate {
    func didSwithOn(isOn: Bool) {
        UserDefaults.standard.set(isOn, forKey: "theme")
        if isOn == true {
            navigationController?.overrideUserInterfaceStyle = .dark
            overrideUserInterfaceStyle = .dark
        } else {
            navigationController?.overrideUserInterfaceStyle = .light
            overrideUserInterfaceStyle = .light
        }
    }
    
    func didSelectLanguage() {
        let languageSelectionVC = LanguageController()
        present(languageSelectionVC, animated: true, completion: nil)
    }
}
