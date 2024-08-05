//
//  TabbarPresenter.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 05.08.2024.
//

import UIKit

final class TabbarPresenter: TabbarOutputProtocol {
    weak var view: TabbarViewProtocol?
    
    func viewDidLoad() {
        view?.setupTabs()
    }
    
    func handleDeepLink(_ deeplink: DeepLink) {
        switch deeplink {
        case .search:
            view?.selectedIndex = 0
        case .saved:
            view?.selectedIndex = 1
        }
    }
}

