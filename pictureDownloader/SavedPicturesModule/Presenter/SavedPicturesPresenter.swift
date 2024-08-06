//
//  SavedPicturesPresenter.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 15.07.2024.
//

import UIKit

final class SavedPicturesPresenter: SavedPicturesOutputProtocol {
    weak var view: SavedPicturesViewInputProtocol?
    var interactor: SavedPicturesInteractorInputProtocol?
    var router: SavedPicturesRouterInputProtocol?
    
    var images = [UIImage]()
    
    var dataSource: UICollectionViewDataSource?
    var delegate: UICollectionViewDelegate?
    
    var isGridMode: Bool = true
    
    init() {
        self.dataSource = SavedPicturesDataSource(presenter: self)
        self.delegate = SavedPicturesDelegate(presenter: self)
    }
    
    func viewDidLoad() {
        interactor?.fetchSavedImages()
        view?.setupUI()
    }
    
    func reloadImages() {
        interactor?.fetchSavedImages()
    }
    
    func didLoadImages(_ images: [UIImage]) {
        self.images = images
        DispatchQueue.main.async {
            self.view?.reloadData()
        }
    }
    
    func getImage(at indexPath: IndexPath) -> UIImage {
        return images[indexPath.row]
    }
    
    func didSelectImage(at indexPath: IndexPath) {
        let image = getImage(at: indexPath)
        router?.presentImageDetail(image)
    }
    
    func setGridMode(_ isGridMode: Bool) {
        self.isGridMode = isGridMode
    }
}


