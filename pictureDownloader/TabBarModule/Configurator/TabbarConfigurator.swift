//
//  TabbarConfigurator.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 16.07.2024.
//

import UIKit

final class TabbarConfigurator: TabbarConfiguratorProtocol {
    func configure() -> UITabBarController {
        let view = TabbarController()
        return view
    }
}
