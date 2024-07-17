//
//  SavedPicturesDataSource.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 15.07.2024.
//

import UIKit

class SavedPicturesDataSource: NSObject, UICollectionViewDataSource {
    private let presenter: SavedPicturesPresenterProtocol
    
    init(presenter: SavedPicturesPresenterProtocol) {
        self.presenter = presenter
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let imageView = UIImageView(image: presenter.getImage(at: indexPath))
        cell.contentView.addSubview(imageView)
        imageView.frame = cell.contentView.bounds
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        return cell
    }
}
