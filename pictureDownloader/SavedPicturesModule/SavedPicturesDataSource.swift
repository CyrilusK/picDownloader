//
//  SavedPicturesDataSource.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 15.07.2024.
//

import UIKit

final class SavedPicturesDataSource: NSObject, UICollectionViewDataSource {
    private let presenter: SavedPicturesOutputProtocol
    
    init(presenter: SavedPicturesOutputProtocol) {
        self.presenter = presenter
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.reuseIdentifier, for: indexPath) as? SavedPictureCell else {
            return UICollectionViewCell()
        }
        let image = presenter.getImage(at: indexPath)
        cell.configure(with: image)
        return cell
    }
}
