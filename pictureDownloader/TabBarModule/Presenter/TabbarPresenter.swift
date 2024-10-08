//
//  TabbarPresenter.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 05.08.2024.
//

import UIKit

final class TabbarPresenter: TabbarOutputProtocol {
    weak var view: TabbarViewProtocol?
    var interactor: TabbarInteractorInputProtocol?
    
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
    
    func requestDownloadImage(from url: String) {
        interactor?.downloadImage(from: url)
    }
    
    func passResult(message: String) {
        DispatchQueue.main.async {
            self.view?.showErrorAlert(message: message)
        }
    }
}

