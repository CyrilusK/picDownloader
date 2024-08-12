//
//  ImageDetailPresenterProtocol.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 26.07.2024.
//

import UIKit

protocol ImageDetailOutputProtocol: AnyObject {
    func viewDidLoad()
    func didTapCloseButton()
    func applyFilter(named filterName: String, with image: UIImage, intensity: Float) -> UIImage?
    func getOriginalImage() -> UIImage
}
