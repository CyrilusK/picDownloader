//
//  DownloaderOutputProtocol.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 22.07.2024.
//

import UIKit

protocol DownloaderOutputProtocol: AnyObject {
    var delegate: UITextFieldDelegate? { get }
    
    func viewDidLoad()
    func loadImage(_ url: String) async
    func didFetchImage(_ image: UIImage)
    func didFailWithError(_ error: Error)
}
