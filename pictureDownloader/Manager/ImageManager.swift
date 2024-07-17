//
//  ImageManager.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 17.07.2024.
//

import UIKit

protocol ImageManagerProtocol {
    func saveImage(_ image: UIImage, withName name: String)
    func fetchSavedImages() -> [UIImage]
    func fetchImage(from url: String, completion: @escaping (Result<UIImage, Error>) -> Void)
}

class ImageManager: ImageManagerProtocol {
    
    private func documentsDirUrl() -> URL? {
        try? FileManager.default.url(for: .downloadsDirectory,
                                     in: .userDomainMask,
                                     appropriateFor: nil,
                                     create: false).appendingPathComponent(Constants.directoryName)
    }
    
    func saveImage(_ image: UIImage, withName name: String) {
        guard let url = documentsDirUrl() else {
            print("[DEBUG] - failed to get documents dir url")
            return
        }
        guard let data = image.pngData() else {
            return
        }
        
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("[DEBUG] - Failed to create images directory: \(error)")
                return
            }
        }
        
        let fileUrl = url.appendingPathComponent(name)
        
        do {
            try data.write(to: fileUrl)
            print("[DEBUG] - Image saved: \(fileUrl.path)")
        }
        catch {
            print("[DEBUG] - Failed to save image: \(error)")
        }
    }
    
    func fetchSavedImages() -> [UIImage] {
        var images = [UIImage]()
        
        guard let url = documentsDirUrl() else {
            return images
        }
        let imagePaths: [String]
        do {
            imagePaths = try FileManager.default.contentsOfDirectory(atPath: url.path)
        } catch {
            print("[DEBUG] - Error fetching image paths: \(error)")
            return images
        }
        
        for imagePath in imagePaths {
            let fileUrl = url.appendingPathComponent(imagePath)
            if let image = UIImage(contentsOfFile: fileUrl.path) {
                images.append(image)
            } else {
                print("[DEBUG] - Error loading image at path: \(fileUrl.path)")
            }
        }
        return images
    }
    
    func fetchImage(from url: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(NSError(domain: "App", code: 500, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        guard let scheme = url.scheme, ["https"].contains(scheme.lowercased()) else {
            let errorMessage = "URL invalid or URL must start with 'https://': \(url)"
            completion(.failure(NSError(domain: "App", code: 500, userInfo: [NSLocalizedDescriptionKey: errorMessage])))
            return
        }
        
        print("[DEBUG] - Start fetching")
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                completion(.failure(NSError(domain: "App", code: 500, userInfo: [NSLocalizedDescriptionKey: "Failed to decode image data"])))
                return
            }
            
            let imageName = UUID().uuidString + ".png"
            self?.saveImage(image, withName: imageName)
            
            completion(.success(image))
        }
        task.resume()
    }
}
