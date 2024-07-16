//
//  TabbarView.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 15.07.2024.
//

import UIKit

class TabbarController: UITabBarController {
     var presenter: DownloaderPresenterProtocol?

     override func viewDidLoad() {
         super.viewDidLoad()
         setupTabs()
         self.selectedIndex = 0
         self.tabBar.tintColor = UIColor.blue
         extendedLayoutIncludesOpaqueBars = true
     }

     private func setupTabs() {
         let imageVC = DownloaderConfigurator.configure()
         let imageBarItem = UITabBarItem()
         imageBarItem.image = UIImage(systemName: "plus.magnifyingglass")
         imageVC.tabBarItem =  imageBarItem

         let gridSavedVC = SavedPicturesConfigurator.configure()
         let gridSavedBarItem = UITabBarItem()
         gridSavedBarItem.image = UIImage(systemName: "square.grid.3x3.fill")
         gridSavedVC.tabBarItem =  gridSavedBarItem

         viewControllers = [
             imageVC,
             gridSavedVC
         ]
     }
 }
