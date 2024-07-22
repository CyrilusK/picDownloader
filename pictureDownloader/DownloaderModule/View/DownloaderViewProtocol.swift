//
//  DownloaderViewProtocol.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 22.07.2024.
//

import UIKit

protocol DownloaderViewProtocol: AnyObject {
    func setupView()
    func displayImage(_ image: UIImage)
    func displayError(_ message: String)
}
