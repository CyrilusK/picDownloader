//
//  ImageDetailPresenter.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 26.07.2024.
//

import UIKit

class ImageDetailPresenter: ImageDetailOutputProtocol{
    weak var view: ImageDetailViewInputProtocol?
    var router: ImageDetailRouterInputProtocol?
    var image: UIImage
    
    init(image: UIImage) {
        self.image = image
    }
    
    func viewDidLoad() {
        view?.setupUI(withImage: image)
    }
    
    func didTapCloseButton() {
        router?.dismiss()
    }
}
