//
//  AuthenticationManager.swift
//  ChuckNorrisJokes
//
//  Created by Юлия Кагирова on 30.08.2024.
//

import UIKit
import LocalAuthentication

class LocalAuthorizationService: UIViewController {
    
    //MARK: - Properties
    var faceIDIcon = SettingsViewController().faceIDIcon
    let laContext = LAContext()
    var error: NSError?
    lazy var authButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("FaceID.title".localized, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(authButtonTapped), for: .touchUpInside)
        button.isEnabled = laContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
        return button
    }()
    
    lazy var icon: UIImageView = {
        var icon = UIImageView()
        icon.image = UIImage(systemName: "faceid")
        icon.contentMode = .scaleToFill
        icon.tintColor = .white
        icon.backgroundColor = .systemGreen
        icon.layer.cornerRadius = 5
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        biometryType()
        self.authorizeIfPossible()
        
    }
    
    //MARK: - Private Methods
    
    private func setupUI() {
        title = "FaceID.title".localized
        view.backgroundColor = .systemBackground
        
        view.addSubview(authButton)
        view.addSubview(icon)
        
        NSLayoutConstraint.activate([
            authButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            authButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            icon.centerYAnchor.constraint(equalTo: authButton.centerYAnchor),
            icon.trailingAnchor.constraint(equalTo: authButton.leadingAnchor, constant: -8),
            icon.heightAnchor.constraint(equalToConstant: 30),
            icon.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func authorizeIfPossible() {
        laContext.evaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            localizedReason: "To access data"
        ) { success, error in
            if let error = error {
                print("Try another method, \(error.localizedDescription)")
                return
            }
            print("Auth: \(success)")
        }
    } 
    
     func biometryType() {
        switch laContext.biometryType {
        case .none:
            print("Don't have biometric auth at all")
        case .touchID:
            faceIDIcon = UIImageView(image: UIImage(systemName: "touchid"))
            icon = UIImageView(image: UIImage(systemName: "touchid"))
            print("touchid")
        case .faceID:
            faceIDIcon = UIImageView(image: UIImage(systemName: "faceid"))
            icon = UIImageView(image: UIImage(systemName: "faceid"))
            print("faceid")
        case .opticID:
            print("Don't have it in Russia")
        @unknown default:
            break
        }
    }
    
    //MARK: - Event Handler
    
    @objc private func authButtonTapped() {
        self.authorizeIfPossible()
    }
}

