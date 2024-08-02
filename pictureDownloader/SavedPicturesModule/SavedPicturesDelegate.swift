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
        if presenter.isGridMode {
            let size = (collectionView.frame.width / 2) - 15
            return CGSize(width: size, height: size)
        }
        else {
            return CGSize(width: collectionView.frame.width * 0.7, height: collectionView.frame.height * 0.7 - collectionView.safeAreaInsets.bottom)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if presenter.isGridMode {
            presenter.didSelectImage(at: indexPath)
        }
    }
}
