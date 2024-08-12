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
    private var slider = UISlider()
    
    private var currentFilterName: String?
    private var filterIntensities: [String: Float] = [:]
    private var filterButtons: [UIButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewDidLoad()
    }
    
    func setupUI(withImage image: UIImage) {
        setupZoomScrollView()
        setupSlider()
        setupFilterScrollView()
        setupImageView()
        setImage(image)
        setupCloseButton()
        view.backgroundColor = .systemGroupedBackground
    }
    
    private func setupSlider() {
        slider.minimumValue = 0.0
        slider.maximumValue = 1.0
        slider.value = 0.0
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        slider.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(slider)
        NSLayoutConstraint.activate([
            slider.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            slider.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            slider.topAnchor.constraint(equalTo: zoomScrollView.bottomAnchor),
            slider.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupFilterScrollView() {
        filterScrollView.showsHorizontalScrollIndicator = false
        filterScrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(filterScrollView)
        
        NSLayoutConstraint.activate([
            filterScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            filterScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            filterScrollView.topAnchor.constraint(equalTo: slider.bottomAnchor),
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
            filterButtons.append(button)
            
            xOffset += button.frame.width + 10
            
            DispatchQueue.main.async {
                guard let image = self.imageView.image else { return }
                let filteredImage = filter == .original ? image : self.output?.applyFilter(named: filter.rawValue, with: image, intensity: 0.5)
                button.setBackgroundImage(filteredImage, for: .normal)
            }
        }
        filterScrollView.contentSize = CGSize(width: xOffset, height: 70)
    }
    
    
    @objc private func filterButtonTapped(_ sender: UIButton) {
        if let currentFilter = currentFilterName {
            filterIntensities[currentFilter] = slider.value
        }
        guard let filterName = sender.titleLabel?.text,
              let filterType = FilterTypes.allCases.first(where: { $0.description == filterName }) else { return }
        guard let image = imageView.image else { return }
        
        currentFilterName = filterType.rawValue
        slider.value = filterIntensities[filterType.rawValue] ?? 0.0
        
        guard let filteredImage = filterType == .original ? output?.getOriginalImage() : output?.applyFilter(named: filterType.rawValue, with: image, intensity: slider.value) else { return }
        imageView.image = filteredImage
        
        updateFilterButtonBorders(selectedButton: sender)
    }
    
    private func updateFilterButtonBorders(selectedButton: UIButton) {
        for button in filterButtons {
            button.layer.borderColor = button == selectedButton ? UIColor.yellow.cgColor : nil
            button.layer.borderWidth = button == selectedButton ? 2 : 0
        }
    }
    
    @objc private func sliderValueChanged(_ sender: UISlider) {
        guard let filterName = currentFilterName,
              let originalImage = output?.getOriginalImage() else { return }
        
        guard let filteredImage = output?.applyFilter(named: filterName, with: originalImage, intensity: slider.value) else { return }
        imageView.image = filteredImage
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
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            closeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5)
        ])
    }
    
    private func setImage(_ image: UIImage) {
        imageView.image = image
        imageView.sizeToFit()
        zoomScrollView.contentSize = imageView.bounds.size

        let imageWidth = image.size.width
        let imageHeight = image.size.height
        let maxWidth = view.bounds.width
        let maxHeight = view.bounds.height
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
