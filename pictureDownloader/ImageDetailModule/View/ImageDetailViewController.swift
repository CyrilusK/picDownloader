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
    
    private let zoomScrollView = UIScrollView()
    private let filterScrollView = UIScrollView()
    private let imageView = UIImageView()
    private let closeButton = UIButton(type: .close)
    private let slider = UISlider()
    private let filterSwitch = UISwitch()
    var filterButtons: [UIButton] = []
    
    private var portraitConstraints: [NSLayoutConstraint] = []
    private var landscapeConstraints: [NSLayoutConstraint] = []
    
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
        setupFilterSwitch()
        applyPortraitConstraints()
        view.backgroundColor = ThemeManager().getTheme().settings.backgroundColor
    }
    
    private func setupSlider() {
        slider.minimumValue = 0.0
        slider.maximumValue = 1.0
        slider.value = 0.0
        slider.tintColor = ThemeManager().getTheme().settings.tintColor
        slider.isHidden = true
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        slider.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(slider)
    }
    
    private func setupFilterSwitch() {
        filterSwitch.onTintColor = ThemeManager().getTheme().settings.tintColor
        filterSwitch.isHidden = true
        filterSwitch.addTarget(self, action: #selector(filterSwitchValueChanged), for: .valueChanged)
        filterSwitch.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(filterSwitch)
    }
    
    private func setupFilterScrollView() {
        filterScrollView.showsVerticalScrollIndicator = false
        filterScrollView.showsHorizontalScrollIndicator = false
        filterScrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(filterScrollView)
        setupFilterButtons()
    }
    
    private func setupFilterButtons() {
        for button in filterButtons {
            button.removeFromSuperview()
        }
        filterButtons.removeAll()
        
        var xOffset: CGFloat = 10.0
        var yOffset: CGFloat = 10.0
        let buttonSize: CGFloat = 70.0
        
        for filter in FilterTypes.allCases {
            let button = UIButton(type: .system)
            button.setTitle(filter.description, for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
            
            switch UIDevice.current.orientation {
            case .portrait:
                button.frame = CGRect(x: xOffset, y: 10, width: buttonSize, height: buttonSize)
                xOffset += buttonSize + 10
            case .landscapeLeft, .portraitUpsideDown, .landscapeRight:
                button.frame = CGRect(x: 10, y: yOffset, width: buttonSize, height: buttonSize)
                yOffset += buttonSize + 10
            default:
                button.frame = CGRect(x: xOffset, y: 10, width: buttonSize, height: buttonSize)
                xOffset += buttonSize + 10
            }
            
            button.imageView?.contentMode = .scaleAspectFill
            button.layer.cornerRadius = 25
            button.clipsToBounds = true
            filterScrollView.addSubview(button)
            filterButtons.append(button)
        }
        
        Task(priority: .userInitiated) {
            guard let originalImage = output?.getOriginalImage() else { return }
            guard let filteredImages = await output?.applyFilterForButton(with: originalImage) else { return }
            for (index, filteredImage) in filteredImages.enumerated() {
                if index < filterButtons.count {
                    let button = filterButtons[index]
                    button.setBackgroundImage(filteredImage, for: .normal)
                }
            }
        }
        
        switch UIDevice.current.orientation {
        case .portrait:
            filterScrollView.contentSize = CGSize(width: xOffset, height: buttonSize)
        case .landscapeLeft, .landscapeRight, .portraitUpsideDown:
            filterScrollView.contentSize = CGSize(width: buttonSize, height: yOffset)
        default:
            filterScrollView.contentSize = CGSize(width: xOffset, height: buttonSize)
        }
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
            zoomScrollView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
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
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        view.addSubview(closeButton)
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            closeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5)
        ])
    }
    
    @objc private func filterButtonTapped(_ sender: UIButton) {
        guard let filterName = sender.titleLabel?.text else { return }
        output?.filterButtonTapped(filterName)
        updateFilterButtonBorders(selectedButton: sender)
    }
    
    func updateFilterControls(for filter: FilterTypes) {
        guard let currentValue = output?.getValueCurrentFilterIntensities() else { return }
        slider.value = currentValue
        slider.isHidden = filter.unsupportsIntensity
        filterSwitch.isHidden = !filter.unsupportsIntensity
        filterSwitch.isOn = currentValue == 1.0
    }
    
    func hideSwitch() {
        filterSwitch.isHidden = true
    }

    func updateImageView(with image: UIImage) {
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }
    
    private func updateFilterButtonBorders(selectedButton: UIButton) {
        output?.updateFilterButtonBorders(selectedButton: selectedButton)
    }
    
    @objc private func sliderValueChanged(_ sender: UISlider) {
        output?.sliderValueChanged(sender.value)
    }
    
    @objc private func filterSwitchValueChanged(_ sender: UISwitch) {
        output?.filterSwitchValueChanged(sender.isOn)
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
    
    private func applyPortraitConstraints() {
        portraitConstraints = [
            filterScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            filterScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            filterScrollView.topAnchor.constraint(equalTo: zoomScrollView.bottomAnchor),
            filterScrollView.heightAnchor.constraint(equalToConstant: 90),
            
            slider.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            slider.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            slider.topAnchor.constraint(equalTo: filterScrollView.bottomAnchor),
            slider.heightAnchor.constraint(equalToConstant: 50),
            
            filterSwitch.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            filterSwitch.topAnchor.constraint(equalTo: filterScrollView.bottomAnchor, constant: 10),
            filterSwitch.heightAnchor.constraint(equalToConstant: 50)
        ]
        NSLayoutConstraint.activate(portraitConstraints)
        filterScrollView.alwaysBounceVertical = false
        filterScrollView.alwaysBounceHorizontal = true
        slider.transform = .identity
    }
    
    private func applyLandscapeConstraints(width: CGFloat) {
        landscapeConstraints = [
            filterScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25),
            filterScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            filterScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            filterScrollView.widthAnchor.constraint(equalToConstant: 90),
            
            slider.widthAnchor.constraint(equalToConstant: width),
            slider.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            slider.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            
            filterSwitch.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            filterSwitch.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            filterSwitch.heightAnchor.constraint(equalToConstant: 50)
            
        ]
        NSLayoutConstraint.activate(landscapeConstraints)
        filterScrollView.alwaysBounceVertical = true
        filterScrollView.alwaysBounceHorizontal = false
        slider.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        orientationDidChange()
    }
    
    private func orientationDidChange() {
        let currentOrientation = UIDevice.current.orientation
        NSLayoutConstraint.deactivate(portraitConstraints + landscapeConstraints)

        switch currentOrientation {
        case .portrait:
            filterScrollView.alwaysBounceVertical = false
            filterScrollView.alwaysBounceHorizontal = true
            applyPortraitConstraints()
        case .landscapeLeft, .portraitUpsideDown:
            filterScrollView.alwaysBounceVertical = true
            filterScrollView.alwaysBounceHorizontal = false
            applyLandscapeConstraints(width: view.bounds.height - 40)
        case .landscapeRight:
            filterScrollView.alwaysBounceVertical = true
            filterScrollView.alwaysBounceHorizontal = false
            applyLandscapeConstraints(width: view.bounds.width - 40)
        default:
            break
        }
        setupFilterButtons()
    }
}

extension ImageDetailViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
