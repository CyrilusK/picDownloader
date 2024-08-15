//
//  SettingsConfigurator.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 15.08.2024.
//

import UIKit

final class SettingsConfigurator {
    func configure() -> UIViewController {
        let view = SettingsViewController()
        let presenter = SettingsPresenter()
        
        view.output = presenter
        presenter.view = view
        
        return view
    }
}
