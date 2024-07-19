//
//  DownloaderPresenter.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 15.07.2024.
//

import UIKit

class DownloaderPresenter: DownloaderPresenterProtocol {
    weak var view: DownloaderViewProtocol?
    var interactor: DownloaderInteractorProtocol?
    
    func didFetchImage(_ image: UIImage) {
        DispatchQueue.main.async {
            self.view?.displayImage(image)
        }
    }
    
    func loadImage(_ url: String) {
        self.interactor?.fetchImage(url)
    }
    
    func didFailWithError(_ error: Error) {
        self.view?.displayError("Failed to load image: \(error.localizedDescription)")
    }
}
