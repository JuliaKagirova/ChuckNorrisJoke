//
//  CustomTheme.swift
//  ChuckNorrisJokes
//
//  Created by Юлия Кагирова on 14.08.2024.
//

import UIKit

struct CustomTheme {
    enum ThemeType {
        case light
        case dark
    }
    let type: ThemeType
    let colors: ColorPalette
    
    static var light = CustomTheme(type: .light, colors: .light)
    static var dark = CustomTheme(type: .dark, colors: .dark)
    
    static var current: CustomTheme = CustomTheme.light {
        didSet {
            func changeTheme(for view: UIView) {
                view.applyTheme(current)
                view.subviews.forEach { view in
                    changeTheme(for: view)
                }
            }
            let scene = UIApplication.shared.connectedScenes.first
            let mainWindow = (scene as? UIWindowScene)?.keyWindow
            mainWindow?.subviews.forEach({ view in
                changeTheme(for: view)
            })
        }
    }
}

struct ColorPalette {
    let labelcolor: UIColor
    let viewColor: UIColor
    let buttonColor: UIColor
    let tabBarItem: UIColor
//    let backgroundImageColor: UIColor
    
    static let light = ColorPalette(labelcolor: .black, viewColor: .white, buttonColor: .systemBlue, tabBarItem: .systemBlue)// backgroundImageColor: .systemBackground)
    static let dark = ColorPalette(labelcolor: .white, viewColor: .black, buttonColor: .systemBlue, tabBarItem: .systemBlue)//, backgroundImageColor: .systemBackground)
}

protocol Themeable {
    func applyTheme(_ theme: CustomTheme)
}

extension UIView: Themeable {
    func applyTheme(_ theme: CustomTheme) {
        if (self is UILabel) {
            (self as! UILabel).textColor = theme.colors.labelcolor
            return
        }
        if (self is UIButton) {
            (self as! UIButton).tintColor = theme.colors.buttonColor
            return
        }
//        if (self is UITabBarItem) {
//            (self as! UITabBarItem).badgeColor = theme.colors.tabBarItem
//            return
//        }
//        if (self is UIImageView) {
//            (self as! UIImageView).backgroundColor = theme.colors.backgroundImageColor
//            return
//        }
        backgroundColor = theme.colors.viewColor
    }
}
