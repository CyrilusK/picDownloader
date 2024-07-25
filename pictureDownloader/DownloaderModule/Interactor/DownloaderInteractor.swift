//
//  DownloaderInteractor.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 15.07.2024.
//

import UIKit

final class DownloaderInteractor: DownloaderInteractorInputProtocol {
    weak var output: DownloaderOutputProtocol?
    private let imageDownloader: ImageDownloaderProtocol
    private let imageStorage: ImageStorageProtocol
    
    init(imageDownloader: ImageDownloaderProtocol, imageStorage: ImageStorageProtocol) {
        self.imageDownloader = imageDownloader
        self.imageStorage = imageStorage
    }
    
    //https://cataas.com/cat
    func fetchImage(_ url: String) {
        let imageName = url.md5 + ".png"
        
        if let cachedImage = imageStorage.getImage(withName: imageName) {
            output?.didFetchImage(cachedImage)
            return
        }
        
        imageDownloader.fetchImage(from: url) { [weak self] result in
            switch result {
            case .success(let image):
                self?.imageStorage.saveImage(image, withName: imageName)
                self?.output?.didFetchImage(image)
            case .failure(let error):
                self?.output?.didFailWithError(error)
            }
        }
    }
}
