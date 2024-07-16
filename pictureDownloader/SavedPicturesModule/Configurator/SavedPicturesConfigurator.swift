//
//  SavedPicturesConfigurator.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 15.07.2024.
//

import UIKit

class SavedPicturesConfigurator {
    static func configure() -> UIViewController {
        let view = SavedPicturesViewController()
        let presenter = SavedPicturesPresenter()
        let interactor = SavedPicturesInteractor()
        let downloader = DownloaderPresenter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        downloader.delegate = presenter
        print("download.delegate assigned to self")
        return view
    }
}
