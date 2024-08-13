//
//  ImageDetailPresenter.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 26.07.2024.
//

import UIKit

final class ImageDetailPresenter: ImageDetailOutputProtocol{
    weak var view: ImageDetailViewInputProtocol?
    var router: ImageDetailRouterInputProtocol?
    var interactor: ImageDetailInteractorInputProtocol?
    
    private var image: UIImage
    private var currentFilterName: String?
    private var filterIntensities: [String: Float] = [:]
    
    init(image: UIImage) {
        self.image = image
    }
    
    func viewDidLoad() {
        view?.setupUI(withImage: image)
    }
    
    func applyFilter(named filterName: String, with image: UIImage, intensity: Float) -> UIImage? {
        return interactor?.getFilteredImage(named: filterName, with: image, intensity: intensity)
    }
    
    func didTapCloseButton() {
        router?.dismiss()
    }
    
    func getOriginalImage() -> UIImage {
        image
    }
    
    func filterButtonTapped(_ filterName: String) {
        guard let filterType = FilterTypes.allCases.first(where: { $0.description == filterName }) else { return }
        currentFilterName = filterType.rawValue
        
        view?.updateFilterControls(for: filterType)
        
        if filterType == .original {
            view?.updateImageView(with: image)
            view?.hideSwitch()
            filterIntensities.removeAll()
        }
    }
    
    func getValueCurrentFilterIntensities() -> Float {
        filterIntensities[currentFilterName ?? ""] ?? 0.0
    }
    
    func sliderValueChanged(_ value: Float) {
        guard let filterName = currentFilterName else { return }
        filterIntensities[filterName] = value
        applyAllFilters()
    }

    func filterSwitchValueChanged(_ isOn: Bool) {
        guard let filterName = currentFilterName else { return }
        filterIntensities[filterName] = isOn ? 1.0 : 0.0
        applyAllFilters()
    }

    private func applyAllFilters() {
        var processedImage = image
        for (filterName, intensity) in filterIntensities where intensity > 0.0 {
            processedImage = interactor?.getFilteredImage(named: filterName, with: processedImage, intensity: intensity) ?? processedImage
        }
        view?.updateImageView(with: processedImage)
    }
}
