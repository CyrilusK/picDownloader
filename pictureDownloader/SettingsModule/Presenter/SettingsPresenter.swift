//
//  SettingsPresenter.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 15.08.2024.
//

import UIKit

final class SettingsPresenter: SettingsOutputProtocol {
    weak var view: SettingsViewInputProtocol?
    func viewDidLoad() {
        view?.setupUI()
    }
    
    func highlightButtonForCurrentTheme(current: Theme) {
        guard let themeBtns = view?.themeButtons else { return }
        
        switch current {
        case .blue:
            view?.updateButtonStyle(selectedButton: themeBtns[0])
        case .red:
            view?.updateButtonStyle(selectedButton: themeBtns[1])
        case .green:
            view?.updateButtonStyle(selectedButton: themeBtns[2])
        case .system:
            view?.updateButtonStyle(selectedButton: themeBtns[3])
        }
    }
}
