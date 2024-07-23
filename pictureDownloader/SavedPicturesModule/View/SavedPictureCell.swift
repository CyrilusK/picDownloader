//
//  SavedPictureCell.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 23.07.2024.
//

import UIKit

final class SavedPictureCell: UICollectionViewCell {
    static let reuseIdentifier = "SavedPictureCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    func configure(with image: UIImage) {
        self.imageView.image = image
        self.setupUI()
    }
    
    private func setupUI() {
        contentView.addSubview(imageView)
        imageView.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
}
