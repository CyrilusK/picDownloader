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
    var interactor: ImageDetailInteractorInputProtocol?
    var image: UIImage
    
    init(image: UIImage) {
        self.image = image
    }
    
    func viewDidLoad() {
        view?.setupUI(withImage: image)
    }
    
    func applyFilter(named filterName: String, with image: UIImage, intensity: Float) -> UIImage? {
        return interactor?.applyFilter(named: filterName, with: image, intensity: intensity)
    }
    
    func didTapCloseButton() {
        router?.dismiss()
    }
    
    func getOriginalImage() -> UIImage {
        image
    }
}
