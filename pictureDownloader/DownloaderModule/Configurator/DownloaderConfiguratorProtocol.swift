//
//  DownloaderConfiguratorProtocol.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 22.07.2024.
//

import UIKit

protocol DownloaderConfiguratorProtocol {
    func configure(imageDownloader: ImageDownloaderProtocol, imageStorage: ImageStorageProtocol) -> UIViewController
}
