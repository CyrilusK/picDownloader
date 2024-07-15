//
//  DownloaderInteractor.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 15.07.2024.
//

import UIKit

class DownloaderInteractor: DownloaderInteractorProtocol {
    weak var presenter: DownloaderPresenterProtocol?
    
    //https://cataas.com/cat
    func fetchImage(_ url: String) {
        guard let url = URL(string: url) else {
            presenter?.didFailWithError(NSError(domain: "App", code: 500, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
            return
        }
        
        guard let scheme = url.scheme, ["https"].contains(scheme.lowercased()) else {
            let errorMessage = "URL invalid or URL must start with 'https://': \(url)"
            presenter?.didFailWithError(NSError(domain: "App", code: 500, userInfo: [NSLocalizedDescriptionKey: errorMessage]))
            return
        }
        
        print("[DEBUG] - Start fetching")
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                self?.presenter?.didFailWithError(error)
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                self?.presenter?.didFailWithError(NSError(domain: "App", code: 500, userInfo: [NSLocalizedDescriptionKey: "Failed to decode image data"]))
                return
            }
            
            self?.presenter?.didFetchImage(image)
        }
        task.resume()
    }
}
