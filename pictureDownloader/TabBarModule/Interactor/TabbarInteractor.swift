//
//  TabbarInteractor.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 06.08.2024.
//

import UIKit

final class TabbarInteractor: TabbarInteractorInputProtocol {
    weak var output: TabbarOutputProtocol?
    
    func downloadImage(from url: String) {
        let imageDownloader = ImageDownloader()
        let imageStorage = ImageStorage(imageEncryptor: ImageEncryptor())
        let imageName = url.md5 + ".png"
        
        imageDownloader.fetchImage(from: url) { result in
            switch result {
            case .success(let image):
                imageStorage.saveImage(image, withName: imageName)
                DispatchQueue.main.async {
                    self.output?.requestReload()
                }
            case .failure(let error):
                self.output?.passResult(message: "Не удалось загрузить изображение: \(error.localizedDescription)")
            }
        }
    }
}
