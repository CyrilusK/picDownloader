//
//  TabbarPresenter.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 05.08.2024.
//

import UIKit

final class TabbarPresenter: TabbarOutputProtocol {
    weak var view: TabbarViewProtocol?
    
//    func viewDidLoad() {
//        view?.setupTabs()
//    }
    
    func handleDeepLink(_ deeplink: DeepLink) {
        switch deeplink {
        case .search:
            view?.selectedIndex = 0
            view?.showAlert()
        case .saved:
            view?.selectedIndex = 1
            view?.showAlert()
        }
    }
    
    func downloadImage(from url: String) {
        let imageDownloader = ImageDownloader()
        let imageStorage = ImageStorage(imageEncryptor: ImageEncryptor())
        let imageName = url.md5 + ".png"
        
        imageDownloader.fetchImage(from: url) { result in
            switch result {
            case .success(let image):
                imageStorage.saveImage(image, withName: imageName)
                DispatchQueue.main.async {
                    self.view?.reloadGridSavedVC()
                }
            case .failure(let error):
                self.view?.showErrorAlert(message: "Не удалось загрузить изображение: \(error.localizedDescription)")
            }
        }
    }
    
}

