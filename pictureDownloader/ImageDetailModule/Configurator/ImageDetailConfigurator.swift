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
        let interactor = ImageDetailInteractor(imageEditor: ImageEditor(context: CIContext(options: nil)))
        
        view.output = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        router.viewController = view
        
        return view
    }
}
