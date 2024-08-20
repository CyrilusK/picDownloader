//
//  SavedPicturesInteractor.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 15.07.2024.
//

import UIKit

final class SavedPicturesInteractor: SavedPicturesInteractorInputProtocol {
    weak var output: SavedPicturesOutputProtocol?
    private let imageStorage: ImageStorageProtocol
    
    init(imageStorage: ImageStorageProtocol) {
        self.imageStorage = imageStorage
    }
    
    func fetchSavedImages() {
        Task {
            do {
                let images = try await imageStorage.loadSavedImages()
                output?.didLoadImages(images)
            }
            catch {
                print("[DEBUG] - Failed to load saved images: \(error)")
            }
        }
    }
}
