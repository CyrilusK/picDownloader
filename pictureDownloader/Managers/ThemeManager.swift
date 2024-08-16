//
//  ThemeManager.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 15.08.2024.
//

import UIKit

struct ThemeSettings {
    let backgroundColor: UIColor
    let tintColor: UIColor
    
    static let blueTheme = ThemeSettings(backgroundColor: .systemBlue, tintColor: .orange)
    static let redTheme = ThemeSettings(backgroundColor: .systemRed, tintColor: .yellow)
    static let greenTheme = ThemeSettings(backgroundColor: .systemGreen, tintColor: .blue)
    static let systemTheme = ThemeSettings(backgroundColor: .systemGroupedBackground, tintColor: .black)
}

enum Theme: String {
    case blue
    case red
    case green
    case system
    var settings: ThemeSettings {
        switch self {
        case .blue:
            return ThemeSettings.blueTheme
        case .red:
            return ThemeSettings.redTheme
        case .green:
            return ThemeSettings.greenTheme
        case .system:
            return ThemeSettings.systemTheme
        }
    }
}

final class ThemeManager {
    private var currentTheme: Theme {
        get {
            if let savedTheme = UserDefaults.standard.string(forKey: Notification.Name.themeChanged.rawValue),
               let theme = Theme(rawValue: savedTheme) {
                return theme
            }
            return .system
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: Notification.Name.themeChanged.rawValue)
        }
    }
    
    func setTheme(_ theme: Theme) {
        currentTheme = theme
        applyTheme()
    }
    
    func getTheme() -> Theme {
        currentTheme
    }
    
    private func applyTheme() {
        NotificationCenter.default.post(name: .themeChanged, object: nil)
    }
}
