//
//  OnBoardingViewController.swift
//  lesson 4
//
//  Created by Dariya on 8/12/23.
//

import Foundation
import UIKit

class OnBoardingViewController: UIViewController {    
    private let titles: [String] = ["Welcome to The Note", "Set Up Your Profile", "Dive into The Note"]
    private let images: [String] = ["image1", "image2", "image3"]
    private let labels: [String] = [
        "Welcome to The Note  – your new companion \nfor tasks, goals, health – all in one place. \nLet's get started!",
        "Now that you're with us, let's get to know each other better. Fill out your profile, share your interests, and set your goals.",
        "You're fully equipped to dive into the world \nof The Note. Remember, we're here to assist \nyou every step of the way. Ready to start? \nLet's go!"
    ]
    
    private lazy var onBoardingCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsHorizontalScrollIndicator = false
        view.isPagingEnabled = false
        return view
    }()
    
    private lazy var pageControl: UIPageControl = {
        let view = UIPageControl()
        view.numberOfPages = 3
        view.currentPage = 0
        view.currentPageIndicatorTintColor = .black
        view.pageIndicatorTintColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var viewForButtons: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var skipBtn: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Skip", for: .normal)
        view.backgroundColor = .clear
        view.setTitleColor(UIColor(red: 1, green: 0.237, blue: 0.237, alpha: 1), for: .normal)
        view.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var nextBtn: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Next", for: .normal)
        view.backgroundColor = UIColor(red: 1, green: 0.237, blue: 0.237, alpha: 1)
        view.setTitleColor(.white, for: .normal)
        view.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        return view
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    private func initUI() {
        view.addSubview(onBoardingCollectionView)
        setupConstraintsForCollectionView()
        
        view.addSubview(pageControl)
        setupConstraintsForPageControl()
        
        view.addSubview(viewForButtons)
        setupConstraintsForView()
        
        view.addSubview(skipBtn)
        setupConstraintsForSkipBtn()
        
        view.addSubview(nextBtn)
        setupConstraintsForNextBtn()
    }
    
    private func setupConstraintsForCollectionView() {
        NSLayoutConstraint.activate([
            onBoardingCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            onBoardingCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            onBoardingCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            onBoardingCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        onBoardingCollectionView.register(OnBoardingCell.self, forCellWithReuseIdentifier: OnBoardingCell.reuseId)
        onBoardingCollectionView.dataSource = self
        onBoardingCollectionView.delegate = self
    }
    
    private func setupConstraintsForPageControl() {
        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -290),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupConstraintsForView() {
        NSLayoutConstraint.activate([
            viewForButtons.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70),
            viewForButtons.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            viewForButtons.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            viewForButtons.heightAnchor.constraint(equalToConstant: 42),
        ])
    }
    
    private func setupConstraintsForSkipBtn() {
        NSLayoutConstraint.activate([
            skipBtn.topAnchor.constraint(equalTo: viewForButtons.topAnchor),
            skipBtn.leadingAnchor.constraint(equalTo: viewForButtons.leadingAnchor),
            skipBtn.bottomAnchor.constraint(equalTo: viewForButtons.bottomAnchor),
            skipBtn.widthAnchor.constraint(equalToConstant: 173)
        ])
        
        skipBtn.addTarget(self, action: #selector(skipBtnTapped), for: .touchUpInside)
    }
    
    @objc func skipBtnTapped(_ sender: UIButton) {
        let vc = NotesViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setupConstraintsForNextBtn() {
        NSLayoutConstraint.activate([
            nextBtn.topAnchor.constraint(equalTo: viewForButtons.topAnchor),
            nextBtn.leadingAnchor.constraint(equalTo: skipBtn.trailingAnchor, constant: 12),
            nextBtn.bottomAnchor.constraint(equalTo: viewForButtons.bottomAnchor),
            nextBtn.widthAnchor.constraint(equalToConstant: 173)
        ])
        nextBtn.addTarget(self, action: #selector(nextBtnTapped), for: .touchUpInside)
        
    }
    
    @objc func nextBtnTapped(_ sender: UIButton) {
        let currentPage = pageControl.currentPage
        let nextPage = currentPage + 1
        if nextPage != 3  {
            onBoardingCollectionView.scrollToItem(at: [0, nextPage], at: .centeredHorizontally, animated: true)
        } else {
            let vc = NotesViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension OnBoardingViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnBoardingCell.reuseId, for: indexPath) as! OnBoardingCell
        cell.setup(title: titles[indexPath.row], imageName: images[indexPath.row], label: labels[indexPath.row])
        return cell
    }
    
    
}
extension OnBoardingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.size.width
        
        if pageWidth > 0 {
            let page: CGFloat = scrollView.contentOffset.x / pageWidth
            let roundedPage = round(Double(page))
            pageControl.currentPage = Int(roundedPage)
            print("Current page: \(roundedPage)")
            
            if roundedPage == 2 {
                UserDefaults.standard.set(true, forKey: "isOnBoardShown")
            } else {
                print("ScrollView width is zero or negative, cannot determine current page")
            }
        }
        
    }
    
    
}
