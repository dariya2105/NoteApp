//
//  LanguageController.swift
//  lesson 4
//
//  Created by Dariya on 6/12/23.
//

import UIKit

class LanguageController: UIViewController {
    
    private var languages: [Language] = [Language(image: "kg logo", title: "Кыргызча"), Language(image: "russia logo", title: "Русский"), Language(image: "usa logo", title: "English")]
    
    private lazy var titleLabelLNG: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Выберите язык"
        view.font = .systemFont(ofSize: 17, weight: .bold)
        return view
    }()
    
    private lazy var languagesTableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
initUI()
        view.backgroundColor = .systemBackground
    }
    
    private func initUI() {
        view.addSubview(titleLabelLNG)
        setupConstraintsForTitleLblLNG()
        
        view.addSubview(languagesTableView)
        setupConstraintsForTableView()
    }
    
    private func setupConstraintsForTitleLblLNG() {
        NSLayoutConstraint.activate([
            titleLabelLNG.topAnchor.constraint(equalTo: view.topAnchor, constant: 55),
            titleLabelLNG.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14)
        ])
    }
    
    private func setupConstraintsForTableView() {
        NSLayoutConstraint.activate([
            languagesTableView.topAnchor.constraint(equalTo: titleLabelLNG.bottomAnchor, constant: 36),
            languagesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14),
            languagesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -14),
            languagesTableView.heightAnchor.constraint(equalToConstant: 150)
        ])
        languagesTableView.delegate = self
        languagesTableView.dataSource = self
        languagesTableView.register(LanguageCell.self, forCellReuseIdentifier: LanguageCell.reuseId)
        languagesTableView.layer.cornerRadius = 12
    }

}

extension LanguageController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LanguageCell.reuseId, for: indexPath) as! LanguageCell
        cell.setup(language: languages[indexPath.row])
        return cell
    }
}

extension LanguageController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
