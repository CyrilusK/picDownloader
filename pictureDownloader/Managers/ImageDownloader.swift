//
//  ImageDownloader.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 19.07.2024.
//

import UIKit

enum ImageFetchError: Error {
    case invalidURL
    case invalidImageData
    case serverError
    
    var errorDescription: String {
        switch self {
        case .invalidURL:
            return Constants.invalidURL
        case .serverError:
            return Constants.serverError
        case .invalidImageData:
            return Constants.invalidImageData
        }
    }
}

final class ImageDownloader: ImageDownloaderProtocol {
    
    @available(*, deprecated, renamed: "fetchImage")
    func fetchImage(from url: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(ImageFetchError.invalidURL))
            return
        }
        
        print("[DEBUG] - Start fetching")
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                completion(.failure(ImageFetchError.invalidImageData))
                return
            }
            
            completion(.success(image))
        }
        task.resume()
    }
    
    func fetchImage(from url: String) async throws -> UIImage {
        guard let url = URL(string: url) else {
            throw ImageFetchError.invalidURL
        }
        print("[DEBUG] - Start fetching")
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw ImageFetchError.serverError
        }
        
        guard let image = UIImage(data: data) else {
            throw ImageFetchError.invalidImageData
        }
        return image
    }
}
