//
//  Protocols.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 15.07.2024.
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
    var router: DownloaderRouterProtocol? { get set }
    var view: DownloaderViewProtocol? { get set }
    var interactor: DownloaderInteractorProtocol? { get set }
    
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
    static func configure() -> UIViewController
}

protocol DownloaderInteractorDelegate: AnyObject {
    func didFinishDownloadingImage(_ image: UIImage)
}

protocol SavedPicturesInteractorProtocol: AnyObject {
    var presenter: SavedPicturesPresenterProtocol? { get set }
    
    func fetchSavedImages()
}

protocol SavedPicturesPresenterProtocol: AnyObject {
    var view: SavedPicturesViewProtocol? { get set }
    var interactor: SavedPicturesInteractorProtocol? { get set }
    var images: [UIImage] { get }
    
    var dataSource: UICollectionViewDataSource? { get }
    var delegate: UICollectionViewDelegate? { get }
    
    func viewDidLoad()
    func didLoadImages(_ images: [UIImage])
    func getImage(at indexPath: IndexPath) -> UIImage
}

protocol SavedPicturesViewProtocol: AnyObject {
    var presenter: SavedPicturesPresenterProtocol? { get set }
    
    func reloadData()
}

protocol TabbarViewProtocol: AnyObject {
    var presenter: TabbarPresenterProtocol? { get set }
    func setupTabs(viewControllers: [UIViewController])
}

protocol TabbarPresenterProtocol: AnyObject {
    var view: TabbarViewProtocol? { get set }
    var router: TabbarRouterProtocol? { get set }
    func viewDidLoad()
}

protocol TabbarRouterProtocol: AnyObject {
    func createTabs() -> [UIViewController]
}

protocol TabbarConfiguratorProtocol: AnyObject {
    static func configure() -> UITabBarController
}
