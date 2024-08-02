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
        let router = SavedPicturesRouter()
        
        view.output = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.output = presenter
        router.entry = view
        
        view.gridOrCarouselCollectionView.dataSource = presenter.dataSource
        view.gridOrCarouselCollectionView.delegate = presenter.delegate
        
        return view
    }
}
