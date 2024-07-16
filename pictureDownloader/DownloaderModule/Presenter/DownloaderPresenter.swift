//
//  DownloaderPresenter.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 15.07.2024.
//

import UIKit

protocol DownloaderDelegate: AnyObject {
    func didSaveImage()
}

class DownloaderPresenter: DownloaderPresenterProtocol {
    var router: DownloaderRouterProtocol?
    weak var view: DownloaderViewProtocol?
    var interactor: DownloaderInteractorProtocol?
    weak var delegate: DownloaderDelegate?
    
    func didFetchImage(_ image: UIImage) {
        view?.displayImage(image)
        delegate?.didSaveImage()
        print("delegate?.didSaveImage() called")
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
