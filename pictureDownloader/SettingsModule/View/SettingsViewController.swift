//
//  SettingsViewController.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 15.08.2024.
//

import UIKit

final class SettingsViewController: UIViewController, SettingsViewInputProtocol {
    var output: SettingsOutputProtocol?
    private var themeButtons: [UIButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(updateTheme), name: .themeChanged, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .themeChanged, object: nil)
    }
    
    func setupUI() {
        setupThemeSelection()
        updateTheme()
    }
    
    private func setupThemeSelection() {
        let blueButton = createThemeButton(color: .systemBlue, selector: #selector(selectBlueTheme))
        let redButton = createThemeButton(color: .systemRed, selector: #selector(selectRedTheme))
        let greenButton = createThemeButton(color: .systemGreen, selector: #selector(selectGreenTheme))
        let systemButton = createThemeButton(color: .systemGroupedBackground, selector: #selector(selectSystemTheme))
        
        themeButtons = [blueButton, redButton, greenButton, systemButton]
        
        let stackView = UIStackView(arrangedSubviews: themeButtons)
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        let width = CGFloat(stackView.arrangedSubviews.count - 1) * stackView.spacing + CGFloat(stackView.arrangedSubviews.count) * 50
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            stackView.widthAnchor.constraint(equalToConstant: width)
        ])
    }
    
    private func createThemeButton(color: UIColor, selector: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.backgroundColor = color
        button.layer.cornerRadius = 25
        button.layer.masksToBounds = true
        button.layer.borderWidth = 0.1
        button.layer.borderColor = UIColor.black.cgColor
        button.addTarget(self, action: selector, for: .touchUpInside)
        return button
    }
    
    private func updateButtonStyle(selectedButton: UIButton) {
        for button in themeButtons {
            if button == selectedButton {
                button.layer.borderWidth = 1.5
                button.layer.shadowColor = ThemeManager.shared.getTheme().settings.tintColor.cgColor
            } else {
                button.layer.borderWidth = 0.1
                button.layer.shadowOpacity = 0.0
                button.layer.borderColor = UIColor.black.cgColor
            }
        }
    }
    
    @objc private func selectBlueTheme(_ sender: UIButton) {
        ThemeManager.shared.setTheme(.blue)
        updateButtonStyle(selectedButton: sender)
    }
    
    @objc private func selectRedTheme(_ sender: UIButton) {
        ThemeManager.shared.setTheme(.red)
        updateButtonStyle(selectedButton: sender)
    }
    
    @objc private func selectGreenTheme(_ sender: UIButton) {
        ThemeManager.shared.setTheme(.green)
        updateButtonStyle(selectedButton: sender)
    }
    
    @objc private func selectSystemTheme(_ sender: UIButton) {
        ThemeManager.shared.setTheme(.system)
        updateButtonStyle(selectedButton: sender)
    }
    
    @objc private func updateTheme() {
        let currentTheme = ThemeManager.shared.getTheme()
        view.backgroundColor = currentTheme.settings.backgroundColor
        switch currentTheme {
        case .blue:
            updateButtonStyle(selectedButton: themeButtons[0])
        case .red:
            updateButtonStyle(selectedButton: themeButtons[1])
        case .green:
            updateButtonStyle(selectedButton: themeButtons[2])
        case .system:
            updateButtonStyle(selectedButton: themeButtons[3])
        }
    }
}

