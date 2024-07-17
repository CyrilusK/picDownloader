//
//  Protocols.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 15.07.2024.
//

import UIKit

protocol TabbarViewProtocol: AnyObject {
    var presenter: TabbarPresenterProtocol? { get set }
    func setupTabs(viewControllers: [UIViewController])
}

protocol TabbarPresenterProtocol: AnyObject {
    var view: TabbarViewProtocol? { get set }
    var router: TabbarRouterProtocol? { get set }
    func viewDidLoad()
}

protocol TabbarRouterProtocol: AnyObject {
    func createTabs() -> [UIViewController]
}

protocol TabbarConfiguratorProtocol: AnyObject {
    static func configure() -> UITabBarController
}
