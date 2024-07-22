//
//  SavedPicturesInteractor.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 15.07.2024.
//

import UIKit

final class SavedPicturesInteractor: SavedPicturesInteractorProtocol {
    weak var output: SavedPicturesPresenterProtocol?
    private let imageStorage: ImageStorageProtocol
    
    init(imageStorage: ImageStorageProtocol) {
        self.imageStorage = imageStorage
    }
    
    func fetchSavedImages() {
        let images = imageStorage.loadSavedImages()
        output?.didLoadImages(images)
    }
}
