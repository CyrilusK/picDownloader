//
//  ImageEditor.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 13.08.2024.
//

import UIKit
import CoreImage

final class ImageEditor: ImageEditorProtocol {
    private let context: CIContext
    
    init(context: CIContext) {
        self.context = context
    }
    
    func applyFilter(named filterName: String, with image: UIImage, intensity: Float) -> UIImage? {
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
    
    func processImagesConcurrently(with image: UIImage) async -> [UIImage] {
        var processedImages: [UIImage] = []
        for filter in FilterTypes.allCases {
            async let processedImage = applyFilter(named: filter.rawValue, with: image, intensity: 0.2)
            processedImages.append(await processedImage ?? image)
        }
        return processedImages
    }
}

enum FilterTypes: String, CaseIterable {
    case original = "Original"
    case discBlur = "CIDiscBlur"
    case chrome = "CIColorMonochrome"
    case vignette = "CIVignette"
    case sepia = "CISepiaTone"
    case fade = "CIPhotoEffectFade"
    case instant = "CIPhotoEffectInstant"
    case noir = "CIPhotoEffectNoir"
    case process = "CIPhotoEffectProcess"
    case tonal = "CIPhotoEffectTonal"
    case transfer = "CIPhotoEffectTransfer"
    
    var description: String {
        switch self {
        case .original: return "Original"
        case .discBlur: return "Blur"
        case .chrome: return "Mono"
        case .vignette: return "Vignette"
        case .sepia: return "Sepia"
        case .fade: return "Fade"
        case .instant: return "Instant"
        case .noir: return "Noir"
        case .process: return "Process"
        case .tonal: return "Tonal"
        case .transfer: return "Transfer"
        }
    }
    
    var unsupportsIntensity: Bool {
        switch self {
        case .sepia, .discBlur, .chrome, .vignette:
            return false
        default:
            return true
        }
    }
}
