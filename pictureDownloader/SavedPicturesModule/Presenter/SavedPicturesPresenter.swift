//
//  SavedPicturesPresenter.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 15.07.2024.
//

import UIKit

class SavedPicturesPresenter: SavedPicturesPresenterProtocol {
    weak var view: SavedPicturesViewProtocol?
    var interactor: SavedPicturesInteractorProtocol?
    
    var images = [UIImage]()
    
    var dataSource: UICollectionViewDataSource?
    var delegate: UICollectionViewDelegate?
    
    init() {
        self.dataSource = SavedPicturesDataSource(presenter: self)
        self.delegate = SavedPicturesDelegate(presenter: self)
    }
    
    func viewDidLoad() {
        interactor?.fetchSavedImages()
    }
    
    func didLoadImages(_ images: [UIImage]) {
        self.images = images
        view?.reloadData()
    }
    
    func getImage(at indexPath: IndexPath) -> UIImage {
        return images[indexPath.row]
    }
}


