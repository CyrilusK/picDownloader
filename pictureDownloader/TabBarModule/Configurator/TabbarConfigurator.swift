//
//  TabbarConfigurator.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 16.07.2024.
//

import UIKit

final class TabbarConfigurator: TabbarConfiguratorProtocol {
    func configure() -> TabbarController {
        let view = TabbarController()
        let presenter = TabbarPresenter()
        
        view.output = presenter
        presenter.view = view
        
        return view
    }
}
