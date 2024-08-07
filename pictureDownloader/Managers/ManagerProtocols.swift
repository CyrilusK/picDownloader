//
//  ManagerProtocols.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 19.07.2024.
//

import UIKit

protocol ImageDownloaderProtocol {
    func fetchImage(from url: String, completion: @escaping (Result<UIImage, Error>) -> Void)
}

protocol ImageStorageProtocol {
    func saveImage(_ image: UIImage, withName name: String)
    func loadSavedImages() -> [UIImage]
    func getImage(withName name: String) -> UIImage?
}

