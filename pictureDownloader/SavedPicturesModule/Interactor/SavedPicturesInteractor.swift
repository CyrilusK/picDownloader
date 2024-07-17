//
//  SavedPicturesInteractor.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 15.07.2024.
//

import UIKit

class SavedPicturesInteractor: SavedPicturesInteractorProtocol {
    weak var presenter: SavedPicturesPresenterProtocol?
    private let imageManager: ImageManagerProtocol
    
    init(imageManager: ImageManagerProtocol) {
        self.imageManager = imageManager
    }
    
    func fetchSavedImages() {
        let images = imageManager.fetchSavedImages()
        presenter?.didLoadImages(images)
    }
}
