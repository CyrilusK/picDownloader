//
//  SavedPicturesInteractor.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 15.07.2024.
//

import UIKit

class SavedPicturesInteractor: SavedPicturesInteractorProtocol {
    weak var presenter: SavedPicturesPresenterProtocol?
    private let cache = NSCache<NSString, UIImage>()
    
    func fetchSavedImages() {
        var images = [UIImage]()
        
        guard let url = documentsDirUrl() else {
            return
        }
        let imagePaths: [String]
        do {
            imagePaths = try FileManager.default.contentsOfDirectory(atPath: url.path)
        } catch {
            print("[DEBUG] - Error fetching image paths: \(error)")
            presenter?.didLoadImages([])
            return
        }
        
        for imagePath in imagePaths {
            let fileUrl = url.appendingPathComponent(imagePath)
            if let image = UIImage(contentsOfFile: fileUrl.path) {
                images.append(image)
            } else {
                print("[DEBUG] - Error loading image at path: \(fileUrl.path)")
            }
        }
        print(images.count)
        presenter?.didLoadImages(images)
    }
    
    private func documentsDirUrl() -> URL? {
        try? FileManager.default.url(for: .downloadsDirectory,
                                     in: .userDomainMask,
                                     appropriateFor: nil,
                                     create: false).appendingPathComponent(Constants.directoryName)
    }
}
