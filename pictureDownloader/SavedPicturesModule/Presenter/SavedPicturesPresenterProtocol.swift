//
//  SavedPicturesOutputProtocol.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 22.07.2024.
//

import UIKit

protocol SavedPicturesOutputProtocol: AnyObject {
    var images: [UIImage] { get }
    var isGridMode: Bool { get }
    
    var dataSource: UICollectionViewDataSource? { get }
    var delegate: UICollectionViewDelegate? { get }
    
    func viewDidLoad()
    func reloadImages()
    func didLoadImages(_ images: [UIImage])
    func getImage(at indexPath: IndexPath) -> UIImage
    func didSelectImage(at indexPath: IndexPath)
    func setGridMode(_ isGridMode: Bool)
}
