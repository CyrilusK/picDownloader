//
//  ViewController.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 15.07.2024.
//

import UIKit

final class DownloaderViewController: UIViewController, DownloaderViewInputProtocol {
    var output: DownloaderOutputProtocol?
    
    let urlTextField = UITextField()
    private let imageViewFromUrl = UIImageView()
    private let searchButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(updateColorUI), name: .themeChanged, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .themeChanged, object: nil)
    }
    
    private func setupButton() {
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        view.addSubview(searchButton)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            searchButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            searchButton.leadingAnchor.constraint(equalTo: urlTextField.trailingAnchor, constant: 5),
            searchButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setupImageView() {
        imageViewFromUrl.contentMode = .scaleAspectFit
        view.addSubview(imageViewFromUrl)
        imageViewFromUrl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageViewFromUrl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            imageViewFromUrl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            imageViewFromUrl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            imageViewFromUrl.topAnchor.constraint(equalTo: urlTextField.bottomAnchor, constant: 20)
        ])
    }
    
    private func setupUrlTextField() {
        urlTextField.placeholder = " Введите url"
        urlTextField.layer.borderWidth = 1.0
        urlTextField.layer.cornerRadius = 5.0
        urlTextField.autocapitalizationType = .none
        urlTextField.autocorrectionType = .no
        setupTextFieldConstraints()
    }
    
    private func setupTextFieldConstraints() {
        view.addSubview(urlTextField)
        urlTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            urlTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            urlTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -45),
            urlTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            urlTextField.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func setupView() {
        setupUrlTextField()
        setupImageView()
        setupButton()
        updateColorUI()
    }
    
    @objc private func updateColorUI() {
        let settings = ThemeManager.shared.getTheme().settings
        view.backgroundColor = settings.backgroundColor
        urlTextField.layer.borderColor = settings.tintColor.cgColor
        searchButton.tintColor = settings.tintColor
    }
    
    @objc
    private func didTapButton() {
        urlTextField.endEditing(true)
    }
    
    func displayImage(_ image: UIImage) {
        self.imageViewFromUrl.image = image
    }
    
    func displayError(_ message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}


