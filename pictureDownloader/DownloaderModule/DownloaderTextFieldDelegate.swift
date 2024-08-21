//
//  DownloaderTextFieldDelegate.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 22.07.2024.
//

import UIKit

final class DownloaderTextFieldDelegate: NSObject, UITextFieldDelegate {
    private let presenter: DownloaderOutputProtocol
    
    init(presenter: DownloaderOutputProtocol) {
        self.presenter = presenter
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let url = textField.text else {
            textField.text = ""
            return
        }
        textField.text = ""
        Task(priority: .userInitiated) {
            await presenter.loadImage(url)
        }
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        }
        else {
            textField.placeholder = " Введите url"
            return false
        }
    }
}


