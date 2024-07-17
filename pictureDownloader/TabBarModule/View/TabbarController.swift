//
//  TabbarView.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 15.07.2024.
//

import UIKit

class TabbarController: UITabBarController {
     override func viewDidLoad() {
         super.viewDidLoad()
         setupTabs()
         self.selectedIndex = 0
         self.tabBar.tintColor = UIColor.blue
         extendedLayoutIncludesOpaqueBars = true
     }

     private func setupTabs() {
         guard let gridSavedVC = SavedPicturesConfigurator.configure() as? SavedPicturesViewController else {
             print("[DEBUG] - SavedPicturesViewController cannot be configured.")
             return
         }
         let gridSavedBarItem = UITabBarItem()
         gridSavedBarItem.image = UIImage(systemName: "square.grid.3x3.fill")
         gridSavedVC.tabBarItem = gridSavedBarItem
         
         guard let savedPicturesPresenter = gridSavedVC.presenter as? SavedPicturesPresenter else {
             print("[DEBUG] - SavedPicturesPresenter cannot be cast.")
             return
         }
         let imageVC = DownloaderConfigurator.configure(savedPicturesPresenter: savedPicturesPresenter)
         let imageBarItem = UITabBarItem()
         imageBarItem.image = UIImage(systemName: "plus.magnifyingglass")
         imageVC.tabBarItem = imageBarItem

         viewControllers = [
             imageVC,
             gridSavedVC
         ]
     }
 }
