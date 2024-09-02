//
//  SettingsViewController.swift
//  ChuckNorrisJokes
//
//  Created by Юлия Кагирова on 30.08.2024.
//

import UIKit

//ToDo

enum Constants {
    case right
    case left
    case icon
    case btwIcon

}

class SettingsViewController: UITableViewController {
    
    //MARK: - Properties
    
    var coordinator: Coordinator?
    lazy var notificationLink: UIButton = {
        var button = UIButton()
        button.setTitle("Notification.title".localized, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(notificationLinkTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var notificationIcon: UIImageView = {
        var icon = UIImageView()
        icon.image = UIImage(systemName: "bell.badge.fill")
        icon.contentMode = .scaleToFill
        icon.tintColor = .white
        icon.backgroundColor = .systemRed
        icon.layer.cornerRadius = 5
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    lazy var faceIDLink: UIButton = {
        var button = UIButton()
        button.setTitle("FaceID.title".localized, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(faceIDLinkTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var faceIDIcon: UIImageView = {
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
        LocalAuthorizationService().biometryType()
    }
    
    //MARK: - Private Methods
    
    private func setupUI() {
        view.backgroundColor = .white
        title = "Settings.title".localized
        
        view.addSubview(notificationLink)
        view.addSubview(notificationIcon)
        view.addSubview(faceIDIcon)
        view.addSubview(faceIDLink)
        
        NSLayoutConstraint.activate([
            
            notificationIcon.centerYAnchor.constraint(equalTo: notificationLink.centerYAnchor),
            notificationIcon.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            notificationIcon.heightAnchor.constraint(equalToConstant: 30),
            notificationIcon.widthAnchor.constraint(equalToConstant: 30),
            
            notificationLink.topAnchor.constraint(equalTo: view.topAnchor, constant: 42),
            notificationLink.leadingAnchor.constraint(equalTo: notificationIcon.trailingAnchor, constant: 8),
            notificationLink.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            notificationLink.heightAnchor.constraint(equalToConstant: 50),
            
            faceIDIcon.centerYAnchor.constraint(equalTo: faceIDLink.centerYAnchor),
            faceIDIcon.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            faceIDIcon.heightAnchor.constraint(equalToConstant: 30),
            faceIDIcon.widthAnchor.constraint(equalToConstant: 30),
            
            faceIDLink.topAnchor.constraint(equalTo: notificationLink.bottomAnchor, constant: 18),
            faceIDLink.leadingAnchor.constraint(equalTo: faceIDIcon.trailingAnchor, constant: 8),
//            faceIDLink.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            faceIDLink.heightAnchor.constraint(equalToConstant: 50),

            
        ])
    }
    
    //MARK: - Event Handler
    
    @objc private func notificationLinkTapped() {
        let notificationVC = NotificationVC()
        navigationController?.pushViewController(notificationVC, animated: true)
    }
    
    @objc private func faceIDLinkTapped() {
        let faceID = LocalAuthorizationService()
        navigationController?.pushViewController(faceID, animated: true)
    }
}
