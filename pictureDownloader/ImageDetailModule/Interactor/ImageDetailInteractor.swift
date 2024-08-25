//
//  ImageDetailInteractor.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 09.08.2024.
//

import UIKit

final class ImageDetailInteractor: ImageDetailInteractorInputProtocol {
    private let imageEditor: ImageEditorProtocol
    
    init(imageEditor: ImageEditorProtocol) {
        self.imageEditor = imageEditor
    }
    
    func getFilteredImage(named filterName: String, with image: UIImage, intensity: Float) -> UIImage? {
        imageEditor.applyFilter(named: filterName, with: image, intensity: intensity)
    }
}
