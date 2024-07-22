//
//  DownloaderConfigurator.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 15.07.2024.
//

import UIKit

final class DownloaderConfigurator: DownloaderConfiguratorProtocol {
    func configure(imageDownloader: ImageDownloaderProtocol, imageStorage: ImageStorageProtocol) -> UIViewController {
        let view = DownloaderViewController()
        let presenter = DownloaderPresenter()
        let interactor = DownloaderInteractor(imageDownloader: imageDownloader, imageStorage: imageStorage)
        
        view.output = presenter
        presenter.view = view
        presenter.interactor = interactor
        interactor.output = presenter
        
        view.urlTextField.delegate = presenter.delegate
        
        return view
    }
}
