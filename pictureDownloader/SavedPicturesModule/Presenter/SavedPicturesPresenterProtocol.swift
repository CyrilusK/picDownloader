//
//  SavedPicturesOutputProtocol.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 22.07.2024.
//

import UIKit

protocol SavedPicturesOutputProtocol: AnyObject {
    var images: [UIImage] { get }
    
    var dataSource: UICollectionViewDataSource? { get }
    var delegate: UICollectionViewDelegate? { get }
    
    func viewDidLoad()
    func viewWillAppear()
    func didLoadImages(_ images: [UIImage])
    func getImage(at indexPath: IndexPath) -> UIImage
}
