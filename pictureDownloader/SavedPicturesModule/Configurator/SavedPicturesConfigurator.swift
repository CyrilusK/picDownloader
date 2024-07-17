//
//  SavedPicturesConfigurator.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 15.07.2024.
//

import UIKit

class SavedPicturesConfigurator: SavedPicturesConfiguratorProtocol {
    static func configure() -> UIViewController {
        let view = SavedPicturesViewController()
        let interactor = SavedPicturesInteractor()
        let presenter = SavedPicturesPresenter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
}
