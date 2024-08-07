//
//  TabbarConfigurator.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 16.07.2024.
//

import UIKit

final class TabbarConfigurator: TabbarConfiguratorProtocol {
    func configure() -> TabbarController {
        let view = TabbarController()
        let presenter = TabbarPresenter()
        let interactor = TabbarInteractor()
        
        view.output = presenter
        presenter.view = view
        presenter.interactor = interactor
        interactor.output = presenter
        
        setupTabs(for: view)
        
        return view
    }
    
    private func setupTabs(for tabBar: TabbarController) {
        tabBar.selectedIndex = 0
        tabBar.tabBar.tintColor = UIColor.blue
        tabBar.extendedLayoutIncludesOpaqueBars = true
        
        let imageStorage = ImageStorage(imageEncryptor: ImageEncryptor())
        let gridSavedVC = SavedPicturesConfigurator().configure(imageStorage: imageStorage)
        let gridSavedBarItem = UITabBarItem()
        gridSavedBarItem.image = UIImage(systemName: "square.grid.3x3.fill")
        gridSavedVC.tabBarItem = gridSavedBarItem
        
        let imageVC = DownloaderConfigurator().configure(imageDownloader: ImageDownloader(), imageStorage: imageStorage)
        let imageBarItem = UITabBarItem()
        imageBarItem.image = UIImage(systemName: "plus.magnifyingglass")
        imageVC.tabBarItem = imageBarItem
        
        tabBar.viewControllers = [
            imageVC,
            gridSavedVC
        ]
    }
}
