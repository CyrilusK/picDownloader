//
//  SavedPicturesConfigurator.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 15.07.2024.
//

import UIKit

final class SavedPicturesConfigurator: SavedPicturesConfiguratorProtocol {
    func configure(imageStorage: ImageStorageProtocol) -> UIViewController {
        let view = SavedPicturesViewController()
        let interactor = SavedPicturesInteractor(imageStorage: imageStorage)
        let presenter = SavedPicturesPresenter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
}
