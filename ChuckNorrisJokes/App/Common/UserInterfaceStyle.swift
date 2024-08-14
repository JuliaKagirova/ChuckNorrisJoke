//
//  UserInterfaceStyle.swift
//  ChuckNorrisJokes
//
//  Created by Юлия Кагирова on 14.08.2024.
//

import UIKit

class ViewController2: UIViewController { //прописать для нужного класса, тогда конкретно в этом контроллере тема будет выставленна принужденно
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override var overrideUserInterfaceStyle: UIUserInterfaceStyle {
        get {
            .light
        }
        set {
            
        }
    }
}
