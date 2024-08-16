//
//  SettingsViewInputProtocol.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 15.08.2024.
//

import UIKit

protocol SettingsViewInputProtocol: AnyObject {
    var themeButtons: [UIButton] { get }
    
    func setupUI()
    func updateButtonStyle(selectedButton: UIButton)
}
