//
//  ManagerProtocols.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 19.07.2024.
//

import UIKit

protocol ImageDownloaderProtocol {
    func fetchImage(from url: String, completion: @escaping (Result<UIImage, Error>) -> Void)
    func fetchImage(from url: String) async throws -> UIImage
}

protocol ImageStorageProtocol {
    func saveImage(_ image: UIImage, withName name: String)
    func loadSavedImages() async throws -> [UIImage]
    func getImage(withName name: String) -> UIImage?
}

protocol ImageEditorProtocol {
    func applyFilter(named filterName: String, with image: UIImage, intensity: Float) -> UIImage?
    func applyFilter(named filterName: String, with image: UIImage, intensity: Float) async -> UIImage?
}


