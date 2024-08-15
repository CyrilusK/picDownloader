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
}
