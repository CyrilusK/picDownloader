//
//  DeepLinkHandler.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 06.08.2024.
//

import UIKit

enum DeepLink: String {
    case search
    case saved
}

final class DeepLinkHandler {
    private let window: UIWindow?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func handleDeepLink(_ url: URL) {
        guard let components = NSURLComponents(url: url, resolvingAgainstBaseURL: true), let host = components.host else {
            print("[DEBUG] - Invalid URL")
            return
        }
        
        guard let deepLink = DeepLink(rawValue: host) else {
            print("[DEBUG] - Deeplink not found: \(host)")
            return
        }
        
        handleDeepLink(deepLink)
    }
    
    private func handleDeepLink(_ deepLink: DeepLink) {
        guard let tabBarController = window?.rootViewController as? TabbarController else { return }
        tabBarController.handleDeepLink(deepLink)
    }
}

