//
//  DownloaderConfigurator.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 15.07.2024.
//

import UIKit

class DownloaderConfigurator: DownloaderConfiguratorProtocol {
    static func configure(imageDownloader: ImageDownloaderProtocol, imageStorage: ImageStorageProtocol) -> UIViewController {
        let view = DownloaderViewController()
        let presenter = DownloaderPresenter()
        let interactor = DownloaderInteractor(imageDownloader: imageDownloader, imageStorage: imageStorage)
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
}
