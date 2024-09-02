//
//  NotificationVC.swift
//  ChuckNorrisJokes
//
//  Created by Юлия Кагирова on 28.08.2024.
//

import UIKit
import NotificationCenter

class NotificationVC: UIViewController {
    
    //MARK: - Properties
    
    var notificationManager = LocalNotificationsService()
    var labelStatus: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "some text status"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    var requestPermission: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Запрос на уведомления", for: .normal)
        button.setTitleColor(.link, for: .normal)
        button.addTarget(self, action: #selector(requestPermissionTapped), for: .touchUpInside)
        return button
    }()
    
    var pushSetNotification: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Запланировать уведомление", for: .normal)
        button.setTitleColor(.link, for: .normal)
        button.addTarget(self, action: #selector(setNotificationTapped), for: .touchUpInside)
        return button
    }()
    
    var pushResetNotification: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Отменить уведомление", for: .normal)
        button.setTitleColor(.link, for: .normal)
        button.addTarget(self, action: #selector(resetNotificationTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        NotificationCenter.default.addObserver(forName: Notification.Name("sceneDidBecomeActive"), object: nil, queue: .main) {
            _ in
            self.setStatus()  
            
        }
    }
    
    //MARK: - Private Methods
    
    private func setupUI() {
        title = "Notification.title".localized
        
        view.backgroundColor = .systemBackground

        view.addSubview(requestPermission)
        view.addSubview(pushSetNotification)
        view.addSubview(pushResetNotification)
        view.addSubview(labelStatus)
        
        NSLayoutConstraint.activate([
            labelStatus.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            labelStatus.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            labelStatus.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            labelStatus.heightAnchor.constraint(equalToConstant: 50),
            
            requestPermission.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            requestPermission.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            requestPermission.heightAnchor.constraint(equalToConstant: 50),
            
            pushSetNotification.topAnchor.constraint(equalTo: requestPermission.bottomAnchor, constant: 22),
            pushSetNotification.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            pushSetNotification.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            pushSetNotification.heightAnchor.constraint(equalToConstant: 50),


            pushResetNotification.topAnchor.constraint(equalTo: pushSetNotification.bottomAnchor, constant: 22),
            pushResetNotification.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            pushResetNotification.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            pushResetNotification.heightAnchor.constraint(equalToConstant: 50),


        ])
    }
    
    //MARK: - Event Handler
    
    @objc func requestPermissionTapped(_ sender: Any) {
        notificationManager.requestPermission()
    }
    
    @objc func setNotificationTapped(_ sender: Any) {
        notificationManager.registeForLatestUpdatesIfPossible()
    }
    
    @objc func resetNotificationTapped(_ sender: Any) {
        notificationManager.resetNotification()
    }
    
    func openSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    func setStatus() {
        Task {
            if await notificationManager.checkAuthorizationStatus() {
                labelStatus.text = "Доступ к уведомлениям разрешен"
            } else {
                labelStatus.text = "Доступ к уведомлениям запрещен"

            }
        }
    }
}
