//
//  SavedPicturesDelegate.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 15.07.2024.
//

import UIKit

final class SavedPicturesDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    private let presenter: SavedPicturesOutputProtocol
    
    init(presenter: SavedPicturesOutputProtocol) {
        self.presenter = presenter
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.width / 2) - 15
        return CGSize(width: size, height: size)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
    }
}
