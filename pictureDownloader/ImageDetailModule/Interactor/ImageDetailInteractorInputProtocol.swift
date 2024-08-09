//
//  ImageDetailInteractorInputProtocol.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 09.08.2024.
//

import UIKit

protocol ImageDetailInteractorInputProtocol: AnyObject {
    func applyFilter(named filterName: String, with image: UIImage) -> CGImage?
}
