//
//  ImageDetailPresenterProtocol.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 26.07.2024.
//

import UIKit

protocol ImageDetailOutputProtocol: AnyObject {
    func viewDidLoad()
    func didTapCloseButton()
    func applyFilterForButton(with image: UIImage) async -> [UIImage]
    func getOriginalImage() -> UIImage
    func filterButtonTapped(_ filterName: String)
    func getValueCurrentFilterIntensities() -> Float
    func sliderValueChanged(_ value: Float)
    func filterSwitchValueChanged(_ isOn: Bool)
    func updateFilterButtonBorders(selectedButton: UIButton)
}
