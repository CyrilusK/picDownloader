//
//  ImageDownloader.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 19.07.2024.
//

import UIKit

final class ImageDownloader: ImageDownloaderProtocol {
    
    @available(*, deprecated, renamed: "fetchImage")
    func fetchImage(from url: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(NSError(domain: "App", code: 500, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        print("[DEBUG] - Start fetching")
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                completion(.failure(NSError(domain: "App", code: 500, userInfo: [NSLocalizedDescriptionKey: "Failed to decode image data"])))
                return
            }
            
            completion(.success(image))
        }
        task.resume()
    }
    
    func fetchImage(from url: String) async throws -> UIImage {
        guard let url = URL(string: url) else {
            throw NSError(domain: "App", code: 500, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
        }
        print("[DEBUG] - Start fetching")
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        guard let image = UIImage(data: data) else {
            throw NSError(domain: "App", code: 500, userInfo: [NSLocalizedDescriptionKey: "Failed to decode image data"])
        }
        return image
    }
}
