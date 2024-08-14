//
//  String.swift
//  ChuckNorrisJokes
//
//  Created by Юлия Кагирова on 14.08.2024.
//

import UIKit

extension String {
    var localized: String {
        NSLocalizedString(self, comment: self)
    }
}
