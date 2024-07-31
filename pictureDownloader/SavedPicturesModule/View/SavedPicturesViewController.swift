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
        view.addSubview(gridCollectionView)
        gridCollectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            gridCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            gridCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gridCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gridCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        gridCollectionView.register(SavedPictureCell.self, forCellWithReuseIdentifier: Constants.reuseIdentifier)
        gridCollectionView.backgroundColor = .systemGroupedBackground
        view.backgroundColor = .systemGroupedBackground
    }
    
    func reloadData() {
        gridCollectionView.reloadData()
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
        let layout: UICollectionViewLayout
        
        if isGridMode {
            floatingButton.setImage(UIImage(systemName: "square.stack.fill"), for: .normal)
            layout = GridFlowLayout()
        }
        else {
            floatingButton.setImage(UIImage(systemName: "square.grid.3x3.fill"), for: .normal)
            layout = CarouselFlowLayout()
        }
        gridCollectionView.setCollectionViewLayout(layout, animated: true) {_ in
            self.gridCollectionView.reloadData()
        }
    }
}
