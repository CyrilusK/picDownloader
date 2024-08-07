//
//  TabbarOutputProtocol.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 05.08.2024.
//

import UIKit

protocol TabbarOutputProtocol: AnyObject {
    func handleDeepLink(_ deeplink: DeepLink)
    func requestDownloadImage(from url: String)
    func requestReload()
    func passResult(message: String)
}
