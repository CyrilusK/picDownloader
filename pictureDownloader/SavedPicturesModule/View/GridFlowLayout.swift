//
//  GridFlowLayout.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 31.07.2024.
//

import UIKit

final class GridFlowLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()
        self.minimumInteritemSpacing = 10
        self.minimumLineSpacing = 10
        self.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
