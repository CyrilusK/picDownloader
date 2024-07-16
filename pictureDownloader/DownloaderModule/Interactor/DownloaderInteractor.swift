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
            
            let imageName = UUID().uuidString + ".png"
            self?.saveImage(image, withName: imageName)
            
            DispatchQueue.main.async {
                self?.presenter?.didFetchImage(image)
            }
        }
        task.resume()
    }
    
    private func documentsDirUrl() -> URL? {
        try? FileManager.default.url(for: .downloadsDirectory,
                                     in: .userDomainMask,
                                     appropriateFor: nil,
                                     create: false)
    }
    
    private func saveImage(_ image: UIImage, withName name: String) {
        guard let url = documentsDirUrl() else {
            print("[DEBUG] - failed to get documents dir url")
            return
        }
        guard let data = image.pngData() else {
            return
        }
        let dirUrl = url.appendingPathComponent(Constants.directoryName)
        
        if !FileManager.default.fileExists(atPath: dirUrl.path) {
            do {
                try FileManager.default.createDirectory(at: dirUrl, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("[DEBUG] - Failed to create images directory: \(error)")
                return
            }
        }
        
        let fileUrl = dirUrl.appendingPathComponent(name)
        
        do {
            try data.write(to: fileUrl)
            print("[DEBUG] - Image saved: \(fileUrl.path)")
        }
        catch {
            print("[DEBUG] - Failed to save image: \(error)")
        }
    }
    
    
}
