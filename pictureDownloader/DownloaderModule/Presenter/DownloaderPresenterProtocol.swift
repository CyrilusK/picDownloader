//
//  DownloaderPresenterProtocol.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 22.07.2024.
//

import UIKit

protocol DownloaderPresenterProtocol: AnyObject {
    func loadImage(_ url: String)
    func didFetchImage(_ image: UIImage)
    func didFailWithError(_ error: Error)
}
