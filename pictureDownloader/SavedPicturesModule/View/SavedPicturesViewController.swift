//
//  SavedPicturesViewController.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 15.07.2024.
//

import UIKit

final class SavedPicturesViewController: UIViewController, SavedPicturesViewProtocol {
    var output: SavedPicturesPresenterProtocol?
    
    var gridCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 2 - 20, height: 250)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemGroupedBackground
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
            gridCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            gridCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            gridCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            gridCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
  
        gridCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        view.backgroundColor = .systemGroupedBackground
    }
    
    func reloadData() {
        gridCollectionView.reloadData()
    }
}
