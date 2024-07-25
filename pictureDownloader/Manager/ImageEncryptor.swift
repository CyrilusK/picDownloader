//
//  ImageEncryptor.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 25.07.2024.
//

import UIKit
import CryptoKit

final class ImageEncryptor {
    private let keychainHelper = KeychainHelper()
    
    private var key: SymmetricKey {
        if let savedKey = keychainHelper.getKey(withName: Constants.keyName) {
            return savedKey
        } else {
            let newKey = SymmetricKey(size: .bits256)
            let success = keychainHelper.saveKey(newKey, withName: Constants.keyName)
            if !success {
                print("[DEBUG] - Failed to save encryption key to Keychain")
            }
            return newKey
        }
    }
    
    private func imageToData(image: UIImage) -> Data? {
        return image.pngData()
    }
    
    private func dataToImage(data: Data) -> UIImage? {
        return UIImage(data: data)
    }
    
    func encrypt(image: UIImage) -> Data? {
        guard let imageData = imageToData(image: image) else {
            return nil
        }
        do {
            let sealedBox = try AES.GCM.seal(imageData, using: key)
            return sealedBox.combined
        } catch {
            print("[DEBUG] - Error encryption \(error)")
            return nil
        }
    }
    
    func decrypt(encrypted: Data) -> UIImage? {
        do {
            let sealedBox = try AES.GCM.SealedBox(combined: encrypted)
            let decryptedData = try AES.GCM.open(sealedBox, using: key)
            return dataToImage(data: decryptedData)
        } catch {
            print("[DEBUG] - Error decryption \(error)")
            return nil
        }
    }
}
