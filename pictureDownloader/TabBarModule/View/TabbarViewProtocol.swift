//
//  TabbarViewProtocol.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 22.07.2024.
//

import UIKit

protocol TabbarViewProtocol: AnyObject {
    var selectedIndex: Int { get set }
    
    func handleDeepLink(_ deeplink: DeepLink)
    func showAlert()
    func showErrorAlert(message: String)
}
