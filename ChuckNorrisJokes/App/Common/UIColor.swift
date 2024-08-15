//
//  UIColor.swift
//  ChuckNorrisJokes
//
//  Created by Юлия Кагирова on 14.08.2024.
//

import UIKit

extension UIColor {
    static func createColor(any: UIColor, darkMode: UIColor) -> UIColor {
        UIColor { traitCollection in
            if traitCollection.userInterfaceStyle == .dark {
                return darkMode
            } else {
                return any
            }
        }
    }
}
