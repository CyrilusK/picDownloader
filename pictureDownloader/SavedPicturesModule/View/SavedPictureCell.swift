//
//  SavedPictureCell.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 23.07.2024.
//

import UIKit

final class SavedPictureCell: UICollectionViewCell {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 25
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    func configure(with image: UIImage, isGridMode: Bool) {
        self.imageView.image = image
        imageView.contentMode = isGridMode ? .scaleAspectFill : .scaleAspectFit
        imageView.clipsToBounds = isGridMode
        self.setupUI()
    }
    
    private func setupUI() {
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
}
