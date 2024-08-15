//
//  File.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 25.07.2024.
//

import UIKit
import CryptoKit

extension String {
var md5: String {
        let computed = Insecure.MD5.hash(data: self.data(using: .utf8)!)
        return computed.map { String(format: "%02hhx", $0) }.joined()
    }
}

extension Notification.Name {
    static let imageDownloaded = Notification.Name("imageDownloaded")
    static let themeChanged = Notification.Name("themeChanged")
}


