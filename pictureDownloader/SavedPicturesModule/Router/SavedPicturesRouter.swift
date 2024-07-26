//
//  SavedPicturesRouter.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 26.07.2024.
//

import UIKit

final class SavedPicturesRouter: SavedPicturesRouterInputProtocol {
    weak var entry: UIViewController?
    
    func presentImageDetail(_ image: UIImage) {
        let imageDetailVC = ImageDetailConfigurator().configure(image: image)
        imageDetailVC.modalPresentationStyle = .overFullScreen
        imageDetailVC.modalTransitionStyle = .crossDissolve
        entry?.present(imageDetailVC, animated: true)
    }
}
