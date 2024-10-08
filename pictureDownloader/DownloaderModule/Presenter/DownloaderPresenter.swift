//
//  DownloaderPresenter.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 15.07.2024.
//

import UIKit

final class DownloaderPresenter: DownloaderOutputProtocol {
    weak var view: DownloaderViewInputProtocol?
    var interactor: DownloaderInteractorInputProtocol?
    
    var delegate: UITextFieldDelegate?
    
    init() {
        self.delegate = DownloaderTextFieldDelegate(presenter: self)
    }
    
    func viewDidLoad() {
        view?.setupView()
    }
    
    func didFetchImage(_ image: UIImage) {
        DispatchQueue.main.async {
            self.view?.displayImage(image)
        }
    }
    
    func loadImage(_ url: String) async {
        await interactor?.fetchImage(url)
    }
    
    func didFailWithError(_ error: Error) {
        DispatchQueue.main.async {
            if let imageFetchError = error as? ImageFetchError {
                self.view?.displayError("Failed to load image: \(imageFetchError.errorDescription)")
            } else {
                self.view?.displayError("Failed to load image: \(error.localizedDescription)")
            }
        }
    }
}
