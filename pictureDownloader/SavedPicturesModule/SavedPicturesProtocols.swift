//
//  SavedPicturesProtocols.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 17.07.2024.
//

import UIKit

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

protocol SavedPicturesConfiguratorProtocol {
    static func configure(imageManager: ImageManagerProtocol) -> UIViewController
}
