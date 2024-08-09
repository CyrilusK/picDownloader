//
//  ImageDetailViewController.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 26.07.2024.
//

import UIKit
import CoreImage

final class ImageDetailViewController: UIViewController, ImageDetailViewInputProtocol {
    var output: ImageDetailOutputProtocol?
    
    private var zoomScrollView = UIScrollView()
    private let filterScrollView = UIScrollView()
    private var imageView = UIImageView()
    private var closeButton = UIButton(type: .close)
    private var originalImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewDidLoad()
    }
    
    func setupUI(withImage image: UIImage) {
        setupZoomScrollView()
        setupFilterScrollView()
        setupImageView()
        setImage(image)
        setupCloseButton()
    }
    
    private func setupFilterScrollView() {
        filterScrollView.showsHorizontalScrollIndicator = false
        filterScrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(filterScrollView)
        
        NSLayoutConstraint.activate([
            filterScrollView.leadingAnchor.constraint(equalTo: zoomScrollView.leadingAnchor),
            filterScrollView.trailingAnchor.constraint(equalTo: zoomScrollView.trailingAnchor),
            filterScrollView.topAnchor.constraint(equalTo: zoomScrollView.bottomAnchor),
            filterScrollView.heightAnchor.constraint(equalToConstant: 90)
        ])
        setupFilterButtons()
    }
    
    private func setupFilterButtons() {
        var xOffset: CGFloat = 10.0
        
        for filter in FilterTypes.allCases {
            let button = UIButton(type: .system)
            button.setTitle(filter.description, for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
            button.frame = CGRect(x: xOffset, y: 10, width: 70, height: 70)
            button.imageView?.contentMode = .scaleAspectFill
            button.layer.cornerRadius = 25
            button.clipsToBounds = true
            filterScrollView.addSubview(button)
            
            xOffset += button.frame.width + 10
            
            DispatchQueue.main.async {
                guard let image = self.imageView.image else { return }
                let filteredImage = filter == .original ? image.cgImage : self.applyFilter(named: filter.rawValue, with: image)
                if let cgImage = filteredImage {
                    button.setBackgroundImage(UIImage(cgImage: cgImage), for: .normal)
                }
            }
        }
        filterScrollView.contentSize = CGSize(width: xOffset, height: 70)
    }
    
    @objc private func filterButtonTapped(_ sender: UIButton) {
        guard let filterName = sender.titleLabel?.text,
              let filterType = FilterTypes.allCases.first(where: { $0.description == filterName }) else { return }
        guard let image = imageView.image else { return }
        
        guard let filteredImage = filterType == .original ? originalImage?.cgImage : applyFilter(named: filterType.rawValue, with: image) else { return }
        imageView.image = UIImage(cgImage: filteredImage)
    }
    
    private func applyFilter(named filterName: String, with image: UIImage) -> CGImage? {
        let context = CIContext(options: nil)
        let ciImage = CIImage(image: image)
        guard let filter = CIFilter(name: filterName) else { return nil }
        filter.setValue(ciImage, forKey: kCIInputImageKey)
        guard let outputImage = filter.outputImage else { return nil }
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return nil }
        return cgImage
    }
    
    private func setupZoomScrollView() {
        zoomScrollView.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        zoomScrollView.translatesAutoresizingMaskIntoConstraints = false
        zoomScrollView.delegate = self
        zoomScrollView.minimumZoomScale = 1.0
        zoomScrollView.maximumZoomScale = 10.0
        view.addSubview(zoomScrollView)
        
        NSLayoutConstraint.activate([
            zoomScrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            zoomScrollView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    private func setupImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        zoomScrollView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: zoomScrollView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: zoomScrollView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: zoomScrollView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: zoomScrollView.bottomAnchor),
            imageView.widthAnchor.constraint(equalTo: zoomScrollView.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: zoomScrollView.heightAnchor)
        ])
    }
    
    private func setupCloseButton() {
        closeButton.setTitleColor(.red, for: .normal)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        view.addSubview(closeButton)
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: zoomScrollView.topAnchor, constant: 5),
            closeButton.trailingAnchor.constraint(equalTo: zoomScrollView.trailingAnchor, constant: -5)
        ])
    }
    
    private func setImage(_ image: UIImage) {
        originalImage = image
        imageView.image = image
        imageView.sizeToFit()
        zoomScrollView.contentSize = imageView.bounds.size

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
            zoomScrollView.widthAnchor.constraint(equalToConstant: newWidth),
            zoomScrollView.heightAnchor.constraint(equalToConstant: newHeight),
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
