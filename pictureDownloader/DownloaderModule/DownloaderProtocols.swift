//
//  DownloaderProtocols.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 17.07.2024.
//

import UIKit

protocol DownloaderViewProtocol: AnyObject {
    /// - Parameters:
    var presenter: DownloaderPresenterProtocol? { get set }
    
    func displayImage(_ image: UIImage)
    func displayError(_ message: String)
}

protocol DownloaderPresenterProtocol: AnyObject {
    /// - Parameters:
    var view: DownloaderViewProtocol? { get set }
    var interactor: DownloaderInteractorProtocol? { get set }
    var moduleOutput: DownloaderModuleOutput? { get set }
    
    func loadImage(_ url: String)
    func didFetchImage(_ image: UIImage)
    func didFailWithError(_ error: Error)
}

protocol DownloaderInteractorProtocol {
    /// - Parameters:
    var presenter: DownloaderPresenterProtocol? { get set }
    
    func fetchImage(_ url: String)
}

protocol DownloaderRouterProtocol {
    /// - Parameters:
    var entry: UIViewController? { get }
}

protocol DownloaderConfiguratorProtocol {
    static func configure(savedPicturesPresenter: SavedPicturesPresenter, imageManager: ImageManagerProtocol) -> UIViewController
}

protocol DownloaderModuleOutput: AnyObject {
    func didSaveImage()
}
