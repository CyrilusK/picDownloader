//
//  ImageDetailViewInputProtocol.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 26.07.2024.
//

import UIKit

protocol ImageDetailViewInputProtocol: AnyObject {
    func setupUI(withImage image: UIImage)
    func updateImageView(with image: UIImage)
    func updateFilterControls(for filter: FilterTypes)
    func hideSwitch()
//    func applyPortraitConstraints()
//    func applyLandscapeConstraints(width: CGFloat)
//    func setupFilterButtons()
}
