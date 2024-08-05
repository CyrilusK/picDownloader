//
//  TabbarOutputProtocol.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 05.08.2024.
//

import UIKit

protocol TabbarOutputProtocol {
    func viewDidLoad()
    func handleDeepLink(_ deeplink: DeepLink)
}
