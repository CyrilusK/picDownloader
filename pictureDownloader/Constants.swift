//
//  Constants.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 16.07.2024.
//

import UIKit

struct Constants {
    static let directoryName = "SavedImages"
    static let reuseIdentifier = "SavedPictureCell"
    static let keyName = "com.kkg.picDownloader"
    static let dailyReminder = "dailyReminder"
    static let downloadSuccess = "downloadSuccess"
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
