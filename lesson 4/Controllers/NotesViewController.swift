//
//  ViewController.swift
//  lesson 4
//
//  Created by Dariya on 4/12/23.
//

import UIKit

class NotesViewController: UIViewController {
    
    private let noteDataManager = NoteDataManager.shared
    
    private var notes: [Note] = []
    
    private var colors: [UIColor] = [.systemPink, .systemBlue, .systemBrown, .systemOrange]
    
    private var filteredNotes: [Note] = []
    
    private lazy var noteSearchBar: UISearchBar = {
        let view = UISearchBar()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.placeholder = "Найти"
        return view
    }()
    
    private lazy var notesLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Notes"
        view.backgroundColor = .systemBackground
        view.font = .systemFont(ofSize: 16, weight: .regular)
        return view
    }()
    
    private lazy var notesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var addBtn: UIButton = {
        let view = UIButton(type: .system)
        view.backgroundColor = UIColor(red: 1, green: 0.237, blue: 0.237, alpha: 1)
        view.setTitle("+", for: .normal)
        view.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 30)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 42 / 2
        view.setTitleColor(.systemBackground, for: .normal)
        return view
    }()
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
        navigationItem.hidesBackButton = true
        
        view.backgroundColor = .systemBackground
        notes = noteDataManager.fethNotes()
        filteredNotes = notes
        notesCollectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Title"
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
        view.addSubview(noteSearchBar)
        setupConstraintsForNoteSearchBar()
        
        view.addSubview(notesLabel)
        setupConstraintsForNotesLabel()
        
        view.addSubview(notesCollectionView)
        setupConstraintsForNotesCV()
        
        view.addSubview(addBtn)
        setupConstraintsForAddBtn()
    }
    
    private func setupConstraintsForNoteSearchBar() {
        NSLayoutConstraint.activate([
            noteSearchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 4),
            noteSearchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            noteSearchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            noteSearchBar.heightAnchor.constraint(equalToConstant: 36)
        ])
        noteSearchBar.searchTextField.addTarget(self, action: #selector(searchTextEditingChanged), for: .editingChanged)
    }
    
    @objc private func searchTextEditingChanged() {
        filteredNotes = []
        guard let searchText = noteSearchBar.text?.uppercased() else {
            return
        }
        
        if searchText.isEmpty {
            filteredNotes = notes
        } else {
            filteredNotes = notes.filter { note in
                note.title?.uppercased().contains(searchText) == true
            }
        }
        
        notesCollectionView.reloadData()
    }
    
    private func setupConstraintsForNotesLabel() {
        NSLayoutConstraint.activate([
            notesLabel.topAnchor.constraint(equalTo: noteSearchBar.bottomAnchor, constant: 32),
            notesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 34)
        ])
    }
    
    private func setupConstraintsForNotesCV() {
        NSLayoutConstraint.activate([
            notesCollectionView.topAnchor.constraint(equalTo: notesLabel.bottomAnchor, constant: 40),
            notesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            notesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            notesCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        notesCollectionView.dataSource = self
        notesCollectionView.delegate = self
        notesCollectionView.register(NoteCell.self, forCellWithReuseIdentifier: NoteCell.reuseId)
    }
    
    private func setupConstraintsForAddBtn() {
        NSLayoutConstraint.activate([
            addBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            addBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addBtn.heightAnchor.constraint(equalToConstant: 42),
            addBtn.widthAnchor.constraint(equalToConstant: 42)
        ])
        
        addBtn.addTarget(self, action: #selector(addBtnTapped), for: .touchUpInside)
    }
    
    @objc private func addBtnTapped() {
        let addNoteVc = AddNoteViewController()
        navigationController?.pushViewController(addNoteVc, animated: true)
    }
    
}

extension NotesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredNotes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NoteCell.reuseId, for: indexPath) as! NoteCell
        let randomColor = colors.randomElement()
        cell.backgroundColor = randomColor
        cell.setup(title: filteredNotes[indexPath.row].title ?? "")
        return cell
    }
    
    
}
extension NotesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.size.width - 58) / 2, height: 100)
        
    }
}
