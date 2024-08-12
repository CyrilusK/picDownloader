//
//  ImageDetailInteractor.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 09.08.2024.
//

import UIKit

class ImageDetailInteractor: ImageDetailInteractorInputProtocol {
    func applyFilter(named filterName: String, with image: UIImage, intensity: Float) -> UIImage? {
        let context = CIContext(options: nil)
        let ciImage = CIImage(image: image)
        guard let filter = CIFilter(name: filterName) else { return nil }
        if filter.inputKeys.contains(kCIInputIntensityKey) {
            filter.setValue(intensity, forKey: kCIInputIntensityKey)
        }
        else if filter.inputKeys.contains(kCIInputRadiusKey) {
            filter.setValue(intensity * 100, forKey: kCIInputRadiusKey)
        }
        filter.setValue(ciImage, forKey: kCIInputImageKey)
        guard let outputImage = filter.outputImage else { return nil }
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return nil }
        return UIImage(cgImage: cgImage)
    }
}


