//
//  TabbarView.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 15.07.2024.
//

import UIKit
import CryptoKit

final class TabbarController: UITabBarController, TabbarViewProtocol {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        self.selectedIndex = 0
        self.tabBar.tintColor = UIColor.blue
        extendedLayoutIncludesOpaqueBars = true
    }
    
    func setupTabs() {
        let imageStorage = ImageStorage(imageEncryptor: ImageEncryptor())
        guard let gridSavedVC = SavedPicturesConfigurator().configure(imageStorage: imageStorage) as? SavedPicturesViewController else {
            print("[DEBUG] - SavedPicturesViewController cannot be configured.")
            return
        }
        let gridSavedBarItem = UITabBarItem()
        gridSavedBarItem.image = UIImage(systemName: "square.grid.3x3.fill")
        gridSavedVC.tabBarItem = gridSavedBarItem
        
        let imageVC = DownloaderConfigurator().configure(imageDownloader: ImageDownloader(), imageStorage: imageStorage)
        let imageBarItem = UITabBarItem()
        imageBarItem.image = UIImage(systemName: "plus.magnifyingglass")
        imageVC.tabBarItem = imageBarItem
        
        viewControllers = [
            imageVC,
            gridSavedVC
        ]
    }
}
