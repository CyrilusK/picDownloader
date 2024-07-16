//
//  SavedPicturesDelegate.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 15.07.2024.
//

import UIKit

class SavedPicturesDelegate: NSObject, UICollectionViewDelegate {
    private let presenter: SavedPicturesPresenterProtocol
    
    init(presenter: SavedPicturesPresenterProtocol) {
        self.presenter = presenter
    }
}
