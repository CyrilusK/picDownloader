//
//  SavedPicturesViewController.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 15.07.2024.
//

import UIKit

final class SavedPicturesViewController: UIViewController, SavedPicturesViewInputProtocol {
    var output: SavedPicturesOutputProtocol?
    
    var gridOrCarouselCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    private var isGridMode = true
    private let floatingButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output?.viewWillAppear()
    }
    
    func setupUI() {
        setupCollectionView()
        setupFloatingButton()
    }
    
    private func setupCollectionView() {
        view.addSubview(gridOrCarouselCollectionView)
        gridOrCarouselCollectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            gridOrCarouselCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            gridOrCarouselCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gridOrCarouselCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gridOrCarouselCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        gridOrCarouselCollectionView.register(SavedPictureCell.self, forCellWithReuseIdentifier: Constants.reuseIdentifier)
        gridOrCarouselCollectionView.backgroundColor = .systemGroupedBackground
        view.backgroundColor = .systemGroupedBackground
    }
    
    func reloadData() {
        gridOrCarouselCollectionView.reloadData()
    }
    
    private func setupFloatingButton() {
        floatingButton.setImage(UIImage(systemName: "square.stack.fill"), for: .normal)
        floatingButton.addTarget(self, action: #selector(toggleViewMode), for: .touchUpInside)
        floatingButton.backgroundColor = UIColor.blue.withAlphaComponent(0.3)
        floatingButton.tintColor = .white
        floatingButton.layer.cornerRadius = 25
        floatingButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(floatingButton)
        
        NSLayoutConstraint.activate([
            floatingButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            floatingButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            floatingButton.widthAnchor.constraint(equalToConstant: 50),
            floatingButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func toggleViewMode() {
        isGridMode.toggle()
        output?.setGridMode(isGridMode)
        updateViewMode()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        reloadData()
    }
    
    private func updateViewMode() {
        if isGridMode {
            floatingButton.setImage(UIImage(systemName: "square.stack.fill"), for: .normal)
            let layout = UICollectionViewFlowLayout()
            layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            gridOrCarouselCollectionView.setCollectionViewLayout(layout, animated: false)
            reloadData()
        }
        else {
            floatingButton.setImage(UIImage(systemName: "square.grid.3x3.fill"), for: .normal)
            let layout = CarouselFlowLayout()
            gridOrCarouselCollectionView.setCollectionViewLayout(layout, animated: false)
            reloadData()
        }
    }
}
