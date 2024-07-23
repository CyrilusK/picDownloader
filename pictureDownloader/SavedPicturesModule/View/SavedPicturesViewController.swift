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
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output?.viewWillAppear()
    }
    
    func setupCollectionView() {
        view.addSubview(gridCollectionView)
        gridCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            gridCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            gridCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gridCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gridCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
  
        gridCollectionView.register(SavedPictureCell.self, forCellWithReuseIdentifier: SavedPictureCell.reuseIdentifier)
        gridCollectionView.backgroundColor = .systemGroupedBackground
        view.backgroundColor = .systemGroupedBackground
    }
    
    func reloadData() {
        gridCollectionView.reloadData()
    }
}
