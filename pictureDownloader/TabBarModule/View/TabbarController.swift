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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(updateColorUI), name: .themeChanged, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .themeChanged, object: nil)
    }
    
    func handleDeepLink(_ deeplink: DeepLink) {
        output?.handleDeepLink(deeplink)
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
            
            self.output?.requestDownloadImage(from: urlString)
            
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
    
    @objc private func updateColorUI() {
        tabBar.tintColor = ThemeManager().getTheme().settings.tintColor
    }
}
