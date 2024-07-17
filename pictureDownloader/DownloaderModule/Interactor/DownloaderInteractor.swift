//
//  DownloaderInteractor.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 15.07.2024.
//

import UIKit

class DownloaderInteractor: DownloaderInteractorProtocol {
    weak var presenter: DownloaderPresenterProtocol?
    private let imageManager: ImageManagerProtocol
    
    init(imageManager: ImageManagerProtocol) {
        self.imageManager = imageManager
    }
    
    //https://cataas.com/cat
    func fetchImage(_ url: String) {
        imageManager.fetchImage(from: url) { [weak self] result in
            switch result {
            case .success(let image):
                self?.presenter?.didFetchImage(image)
            case .failure(let error):
                self?.presenter?.didFailWithError(error)
            }
        }
    }
}
