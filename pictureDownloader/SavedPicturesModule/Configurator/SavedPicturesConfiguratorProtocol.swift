//
//  SavedPicturesConfiguratorProtocol.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 22.07.2024.
//

import UIKit

protocol SavedPicturesConfiguratorProtocol {
    func configure(imageStorage: ImageStorageProtocol) -> SavedPicturesViewController
}
