//
//  ImageDetailViewInputProtocol.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 26.07.2024.
//

import UIKit

protocol ImageDetailViewInputProtocol: AnyObject {
    var filterButtons: [UIButton] { get }
    
    func setupUI(withImage image: UIImage)
    func updateImageView(with image: UIImage)
    func updateFilterControls(for filter: FilterTypes)
    func hideSwitch()
}
