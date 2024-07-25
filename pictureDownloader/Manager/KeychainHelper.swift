//
//  KeychainHelper.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 25.07.2024.
//

import UIKit
import CryptoKit

class KeychainHelper {
    
    func saveKey(_ key: SymmetricKey, withName name: String) -> Bool {
        let keyData = key.withUnsafeBytes( { Data(Array($0)) } )
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: name,
            kSecValueData as String: keyData
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        return status == errSecSuccess
    }
    
    func getKey(withName name: String) -> SymmetricKey? {
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: name,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        guard status == errSecSuccess, let keyData = dataTypeRef as? Data else {
            return nil
        }
        return SymmetricKey(data: keyData)
    }
}
