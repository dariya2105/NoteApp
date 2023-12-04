//
//  AddNoteViewController.swift
//  lesson 4
//
//  Created by Dariya on 13/12/23.
//

import Foundation
import UIKit

class AddNoteViewController: UIViewController, UITextFieldDelegate {
    
    private let noteDataManager = NoteDataManager.shared
    
    private lazy var titleTF: UITextField = {
        let view = UITextField()
        view.placeholder = "Title"
        view.layer.cornerRadius = 18
        view.backgroundColor = .systemBackground
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor(red: 0.012, green: 0.012, blue: 0.012, alpha: 1).cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var grayView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.backgroundColor = .systemGray3
        return view
    }()
    
    private lazy var notesTF: UITextField = {
        let view = UITextField()
        view.placeholder = "Написать"
        view.backgroundColor = .systemGray3
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var dateLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .systemGray3
            label.textAlignment = .center
            return label
        }()
    
    private lazy var saveBtn: UIButton = {
        let view = UIButton(type: .system)
        view.backgroundColor = UIColor(red: 1, green: 0.237, blue: 0.237, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitleColor(.white, for: .normal)
        view.layer.cornerRadius = 20
        view.setTitle("Сохранить", for: .normal)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Settings"
        let settingsBtn = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(settingBtnTapped))
        navigationItem.rightBarButtonItem = settingsBtn
        initUI()
        updateSettingsButtonColor()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
            super.traitCollectionDidChange(previousTraitCollection)
            updateSettingsButtonColor()
        }

        private func updateSettingsButtonColor() {
            let isDarkTheme = traitCollection.userInterfaceStyle == .dark
            let buttonColor: UIColor = isDarkTheme ? .white : .black
            navigationItem.rightBarButtonItem?.tintColor = buttonColor
        }
    
    @objc private func settingBtnTapped(_ sender: UIButton ) {
        let vc = SettingsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func initUI() {
        view.addSubview(titleTF)
        setupConstraintsForTitleTF()
        
        view.addSubview(grayView)
        setupConstraintsForGrayView()
        
        grayView.addSubview(notesTF)
        setupConstraintsForNoteTF()
        
        view.addSubview(dateLabel)
        setupConstraintForDateLabel()
        updateDateLabel()
        
        view.addSubview(saveBtn)
        setupConstraintsForSaveBtn()
    }
    
    private func setupConstraintsForTitleTF() {
        NSLayoutConstraint.activate([
            titleTF.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 6),
            titleTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            titleTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
            titleTF.heightAnchor.constraint(equalToConstant: 34)
        ])
        addLeftPaddingToTitleTextField()

    }
    
    private func addLeftPaddingToTitleTextField() {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: titleTF.frame.height))
        titleTF.leftView = paddingView
        titleTF.leftViewMode = .always
        }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
    
    private func setupConstraintsForGrayView() {
        NSLayoutConstraint.activate([
            grayView.topAnchor.constraint(equalTo: titleTF.bottomAnchor, constant: 26),
            grayView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            grayView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
            grayView.heightAnchor.constraint(equalToConstant: 474)
        ])
    }
    
    private func setupConstraintsForNoteTF() {
        NSLayoutConstraint.activate([
            notesTF.topAnchor.constraint(equalTo: grayView.topAnchor, constant: 18),
            notesTF.leadingAnchor.constraint(equalTo: grayView.leadingAnchor, constant: 18),
            notesTF.trailingAnchor.constraint(equalTo: grayView.trailingAnchor, constant: -18),
            notesTF.bottomAnchor.constraint(equalTo: grayView.bottomAnchor, constant: -18)
        ])

    }
    
    private func setupConstraintForDateLabel() {
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: grayView.bottomAnchor, constant: 6),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -17)
                ])
    }

    
    private func updateDateLabel() {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            
            let currentDate = Date()
            let formattedDate = dateFormatter.string(from: currentDate)
            
            dateLabel.text = formattedDate
        }
    
    private func setupConstraintsForSaveBtn() {
        NSLayoutConstraint.activate([
            saveBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            saveBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            saveBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            saveBtn.heightAnchor.constraint(equalToConstant: 45)
        ])
        saveBtn.addTarget(self, action: #selector(saveBtnTapped), for: .touchUpInside)
    }
    
    @objc func saveBtnTapped(_ sender: UIButton) {
        let id = UUID().uuidString
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = dateFormatter.string(from: date)
        showAlert(id: id, title: titleTF.text ?? "", date: dateString)
    }
    
    private func showAlert(id: String, title: String, date: String) {
        saveBtn.backgroundColor = .systemGray4
        let alert = UIAlertController(title: "Сохранение", message: "Вы хотите сохранить?", preferredStyle: .alert)
        let actionAccept = UIAlertAction(title: "Да", style: .cancel) { action in
            self.noteDataManager.addNote(id: id, title: title, description: "none", date: date)
            self.navigationController?.popViewController(animated: true)
        }
        
        let actionCancel = UIAlertAction(title: "Нет", style: .default) { action in
            self.saveBtn.backgroundColor = UIColor(red: 1, green: 0.237, blue: 0.237, alpha: 1)
        }
        
        alert.addAction(actionAccept)
        alert.addAction(actionCancel)

        present(alert, animated: true)
    }
}
