//
//  SavedPicturesViewController.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 15.07.2024.
//

import UIKit

class SavedPicturesViewController: UIViewController, SavedPicturesViewProtocol {
    var presenter: SavedPicturesPresenterProtocol?
    
    private var gridCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        presenter?.viewDidLoad()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width / 2 - 20, height: 250)
        gridCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.addSubview(gridCollectionView)
        gridCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            gridCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            gridCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            gridCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            gridCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
  
        gridCollectionView.dataSource = presenter?.dataSource
        gridCollectionView.delegate = presenter?.delegate
        gridCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        view.backgroundColor = .systemGroupedBackground
        gridCollectionView.backgroundColor = .systemGroupedBackground
    }
    
    func reloadData() {
        guard let collectionView = gridCollectionView else {
            DispatchQueue.main.async {
                self.viewDidLoad()
            }
            return
        }
        DispatchQueue.main.async {
            collectionView.reloadData()
        }
    }
}
