//
//  TabbarView.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 15.07.2024.
//

import UIKit
import CryptoKit

final class TabbarController: UITabBarController, TabbarViewProtocol {
    var output: TabbarOutputProtocol?
    
    private let gridSavedVC = SavedPicturesConfigurator().configure(imageStorage: ImageStorage(imageEncryptor: ImageEncryptor()))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //output?.viewDidLoad()
        setupTabs()
    }
    
    func setupTabs() {
        self.selectedIndex = 0
        self.tabBar.tintColor = UIColor.blue
        extendedLayoutIncludesOpaqueBars = true
        
        let gridSavedBarItem = UITabBarItem()
        gridSavedBarItem.image = UIImage(systemName: "square.grid.3x3.fill")
        gridSavedVC.tabBarItem = gridSavedBarItem
        
        let imageStorage = ImageStorage(imageEncryptor: ImageEncryptor())
        let imageVC = DownloaderConfigurator().configure(imageDownloader: ImageDownloader(), imageStorage: imageStorage)
        let imageBarItem = UITabBarItem()
        imageBarItem.image = UIImage(systemName: "plus.magnifyingglass")
        imageVC.tabBarItem = imageBarItem
        
        viewControllers = [
            imageVC,
            gridSavedVC
        ]
    }
    
    func handleDeepLink(_ deeplink: DeepLink) {
        //output?.handleDeepLink(deeplink)
        switch deeplink {
        case .search:
            self.selectedIndex = 0
            showAlert()
        case .saved:
            self.selectedIndex = 1
            showAlert()
        }
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Скачивание картинки", message: nil, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Введите URL"
        }
        
        let dwnldAction = UIAlertAction(title: "Скачать", style: .default) { _ in
            guard let urlString = alert.textFields?.first?.text, !urlString.isEmpty else {
                self.showErrorAlert(message: "URL не может быть пустым")
                return
            }
            
            let imageDownloader = ImageDownloader()
            let imageStorage = ImageStorage(imageEncryptor: ImageEncryptor())
            let imageName = urlString.md5 + ".png"
            
            imageDownloader.fetchImage(from: urlString) { result in
                switch result {
                case .success(let image):
                    imageStorage.saveImage(image, withName: imageName)
                    DispatchQueue.main.async {
                        self.gridSavedVC.viewWillAppear(true)
                    }
                case .failure(let error):
                    self.showErrorAlert(message: "Не удалось загрузить изображение: \(error.localizedDescription)")
                }
            }
        }
        alert.addAction(dwnldAction)
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    func showErrorAlert(message: String) {
        let errorAlert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        errorAlert.addAction(okAction)
        present(errorAlert, animated: true)
    }
}
