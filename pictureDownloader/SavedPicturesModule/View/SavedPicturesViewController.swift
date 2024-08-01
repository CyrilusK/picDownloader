//
//  SavedPicturesViewController.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 15.07.2024.
//

import UIKit

final class SavedPicturesViewController: UIViewController, SavedPicturesViewInputProtocol {
    var output: SavedPicturesOutputProtocol?
    
    var gridCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: GridFlowLayout())
        return collectionView
    }()
    
    var carouselCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: CarouselFlowLayout())
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
        setupCollectionView(gridCollectionView)
        setupCollectionView(carouselCollectionView)
        setupFloatingButton()
        
        gridCollectionView.isHidden = false
        carouselCollectionView.isHidden = true
    }
    
    private func setupCollectionView(_ collectionView: UICollectionView) {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        collectionView.register(SavedPictureCell.self, forCellWithReuseIdentifier: Constants.reuseIdentifier)
        collectionView.backgroundColor = .systemGroupedBackground
        view.backgroundColor = .systemGroupedBackground
    }
    
    func reloadData() {
        gridCollectionView.reloadData()
        carouselCollectionView.reloadData()
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
    
    private func updateViewMode() {
        if isGridMode {
            floatingButton.setImage(UIImage(systemName: "square.stack.fill"), for: .normal)
            gridCollectionView.isHidden = false
            carouselCollectionView.isHidden = true
            gridCollectionView.collectionViewLayout.invalidateLayout()
        }
        else {
            floatingButton.setImage(UIImage(systemName: "square.grid.3x3.fill"), for: .normal)
            gridCollectionView.isHidden = true
            carouselCollectionView.isHidden = false
            carouselCollectionView.collectionViewLayout.invalidateLayout()
        }
    }
}
