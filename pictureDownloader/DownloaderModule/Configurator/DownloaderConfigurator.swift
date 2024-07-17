//
//  DownloaderConfigurator.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 15.07.2024.
//

import UIKit

class DownloaderConfigurator: DownloaderConfiguratorProtocol {
    static func configure(savedPicturesPresenter: SavedPicturesPresenter, imageManager: ImageManagerProtocol) -> UIViewController {
        let view = DownloaderViewController()
        let presenter = DownloaderPresenter()
        let interactor = DownloaderInteractor(imageManager: imageManager)
        
        presenter.moduleOutput = savedPicturesPresenter
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
}
