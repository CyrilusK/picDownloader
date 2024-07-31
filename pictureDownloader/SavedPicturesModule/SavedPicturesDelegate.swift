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
            let image = presenter.getImage(at: indexPath)
            
            let imageWidth = image.size.width
            let imageHeight = image.size.height
            
            let maxWidth = collectionView.safeAreaLayoutGuide.layoutFrame.width - 120
            let maxHeight = collectionView.safeAreaLayoutGuide.layoutFrame.height - 120
            
            let widthRatio = maxWidth / imageWidth
            let heightRatio = maxHeight / imageHeight
            
            let scale = min(widthRatio, heightRatio)
            
            return CGSize(width: imageWidth * scale, height: imageWidth * scale)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if presenter.isGridMode {
            presenter.didSelectImage(at: indexPath)
        }
    }
}
