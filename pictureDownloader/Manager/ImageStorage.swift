//
//  ImageStorage.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 19.07.2024.
//

import UIKit

final class ImageStorage: ImageStorageProtocol {
    private let imageEncryptor: ImageEncryptor
    
    init(imageEncryptor: ImageEncryptor) {
        self.imageEncryptor = imageEncryptor
    }
    
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
        
        guard let encryptedData = imageEncryptor.encrypt(image: image) else {
            print("[DEBUG] - Failed to encrypt image")
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
            try encryptedData.write(to: fileUrl, options: .completeFileProtection)
            print("[DEBUG] - Image saved: \(fileUrl.path)")
        }
        catch {
            print("[DEBUG] - Failed to save image: \(error)")
        }
    }
    
    func loadSavedImages() -> [UIImage] {
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
            do {
                let encryptedData = try Data(contentsOf: fileUrl)
                if let image = imageEncryptor.decrypt(encrypted: encryptedData) {
                    images.append(image)
                }
                else {
                    print("[DEBUG] - Error decrypting image at path: \(fileUrl.path)")
                }
            } catch {
                print("[DEBUG] - Error loading image at path: \(fileUrl.path)")
            }
        }
        return images
    }
    
}
