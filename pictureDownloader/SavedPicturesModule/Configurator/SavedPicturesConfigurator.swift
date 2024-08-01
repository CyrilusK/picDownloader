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
        
        view.gridCollectionView.dataSource = presenter.dataSource
        view.gridCollectionView.delegate = presenter.delegate
        view.carouselCollectionView.dataSource = presenter.dataSource
        view.carouselCollectionView.delegate = presenter.delegate
        
        return view
    }
}
