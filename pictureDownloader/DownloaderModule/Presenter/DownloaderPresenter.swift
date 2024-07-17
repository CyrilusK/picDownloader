//
//  DownloaderPresenter.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 15.07.2024.
//

import UIKit

protocol DownloaderModuleOutput: AnyObject {
    func didSaveImage()
}

class DownloaderPresenter: DownloaderPresenterProtocol {
    weak var view: DownloaderViewProtocol?
    var interactor: DownloaderInteractorProtocol?
    var moduleOutput: DownloaderModuleOutput?
    
    func didFetchImage(_ image: UIImage) {
        view?.displayImage(image)
        moduleOutput?.didSaveImage()
    }
    
    func loadImage(_ url: String) {
        DispatchQueue.main.async {
            self.interactor?.fetchImage(url)
        }
    }
    
    func didFailWithError(_ error: Error) {
        DispatchQueue.main.async {
            self.view?.displayError("Failed to load image: \(error.localizedDescription)")
        }
    }
}
