//
//  ImageDetailInteractorInputProtocol.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 09.08.2024.
//

import UIKit

protocol ImageDetailInteractorInputProtocol: AnyObject {
    func getFilteredImage(named filterName: String, with image: UIImage, intensity: Float) -> UIImage?
    func getFilteredImage(named filterName: String, with image: UIImage, intensity: Float) async -> UIImage?
}
