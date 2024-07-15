//
//  DownloaderConfigurator.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 15.07.2024.
//

import UIKit

class DownloaderConfigurator: DownloaderConfiguratorProtocol {
    static func configure() -> UIViewController {
        let view = DownloaderViewController()
        let presenter = DownloaderPresenter()
        let interactor = DownloaderInteractor()
 //       let router = UserRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
 //       presenter.router = router
        interactor.presenter = presenter
 //       router.entry = view
        
        return view
    }
}
