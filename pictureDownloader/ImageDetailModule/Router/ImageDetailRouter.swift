//
//  ImageDetailRouter.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 26.07.2024.
//

import UIKit

final class ImageDetailRouter: ImageDetailRouterInputProtocol {
    weak var viewController: UIViewController?
    
    func dismiss() {
        viewController?.dismiss(animated: true, completion: nil)
    }
}
