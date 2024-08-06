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
        let interactor = TabbarInteractor()
        
        view.output = presenter
        presenter.view = view
        presenter.interactor = interactor
        interactor.output = presenter
        
        return view
    }
}
