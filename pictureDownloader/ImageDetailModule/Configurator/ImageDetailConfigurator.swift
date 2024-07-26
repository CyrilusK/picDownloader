//
//  ImageDetailConfigurator.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 26.07.2024.
//

import UIKit

final class ImageDetailConfigurator {
    func configure(image: UIImage) -> UIViewController {
        let view = ImageDetailViewController()
        let presenter = ImageDetailPresenter(image: image)
        let router = ImageDetailRouter()
        
        view.output = presenter
        presenter.view = view
        presenter.router = router
        router.viewController = view
        
        return view
    }
}