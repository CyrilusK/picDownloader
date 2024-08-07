//
//  ImageDownloader.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 19.07.2024.
//

import UIKit

final class ImageDownloader: ImageDownloaderProtocol {
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
}
