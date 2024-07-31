//
//  ImageDetailViewController.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 26.07.2024.
//

import UIKit

final class ImageDetailViewController: UIViewController, ImageDetailViewInputProtocol {
    var output: ImageDetailOutputProtocol?
    
    private var scrollView = UIScrollView()
    private var imageView = UIImageView()
    private var closeButton = UIButton(type: .close)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewDidLoad()
    }
    
    func setupUI(withImage image: UIImage) {
        setupScrollView()
        setupImageView()
        setImage(image)
        setupCloseButton()
    }
    
    private func setupScrollView() {
        scrollView.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 10.0
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    private func setupImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        scrollView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            imageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
    }
    
    private func setupCloseButton() {
        closeButton.setTitleColor(.red, for: .normal)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        view.addSubview(closeButton)
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 5),
            closeButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -5)
        ])
    }
    
    private func setImage(_ image: UIImage) {
        imageView.image = image
        imageView.sizeToFit()
        scrollView.contentSize = imageView.bounds.size

        let imageWidth = image.size.width
        let imageHeight = image.size.height
        let maxWidth = view.bounds.width - 40
        let maxHeight = view.bounds.height - 40
        let widthRatio = maxWidth / imageWidth
        let heightRatio = maxHeight / imageHeight
        let scale = min(widthRatio, heightRatio)

        let newWidth = imageWidth * scale
        let newHeight = imageHeight * scale

        NSLayoutConstraint.activate([
            scrollView.widthAnchor.constraint(equalToConstant: newWidth),
            scrollView.heightAnchor.constraint(equalToConstant: newHeight),
        ])
    }
    
    @objc private func closeButtonTapped() {
        output?.didTapCloseButton()
    }
}

extension ImageDetailViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
