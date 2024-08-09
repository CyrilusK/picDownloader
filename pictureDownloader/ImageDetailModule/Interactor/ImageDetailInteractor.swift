//
//  ImageDetailInteractor.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 09.08.2024.
//

import UIKit

class ImageDetailInteractor: ImageDetailInteractorInputProtocol {
    func applyFilter(named filterName: String, with image: UIImage) -> CGImage? {
        let context = CIContext(options: nil)
        let ciImage = CIImage(image: image)
        guard let filter = CIFilter(name: filterName) else { return nil }
        filter.setValue(ciImage, forKey: kCIInputImageKey)
        guard let outputImage = filter.outputImage else { return nil }
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return nil }
        return cgImage
    }
}


