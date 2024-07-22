//
//  DownloaderInteractor.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 15.07.2024.
//

import UIKit

final class DownloaderInteractor: DownloaderInteractorProtocol {
    weak var presenter: DownloaderPresenterProtocol?
    private let imageDownloader: ImageDownloaderProtocol
    private let imageStorage: ImageStorageProtocol
    
    init(imageDownloader: ImageDownloaderProtocol, imageStorage: ImageStorageProtocol) {
        self.imageDownloader = imageDownloader
        self.imageStorage = imageStorage
    }
    
    //https://cataas.com/cat
    func fetchImage(_ url: String) {
        imageDownloader.fetchImage(from: url) { [weak self] result in
            switch result {
            case .success(let image):
                let imageName = UUID().uuidString + ".png"
                self?.imageStorage.saveImage(image, withName: imageName)
                self?.presenter?.didFetchImage(image)
            case .failure(let error):
                self?.presenter?.didFailWithError(error)
            }
        }
    }
}
