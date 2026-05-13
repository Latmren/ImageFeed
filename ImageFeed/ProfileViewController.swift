//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by Dmitry Zherebyatnikov on 09.05.2026.
//

import UIKit

final class ProfileViewController: UIViewController {
    // MARK: - Properties
    private var userPicView: UIImageView!
    private var userNameLabel: UILabel!
    private var userLoginNameLabel: UILabel!
    private var userDescriptionLabel: UILabel!
    private var logoutButton: UIButton!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileViewInitialize()
    }
    
    // MARK: - Private Methods
    private func profileViewInitialize() {
        userPicInitialize()
        userNameLabelInitialize()
        userLoginNameLabelInitialize()
        userDescriptionLabelInitizalize()
        logoutButtonInitialize()
        setupConstraints()
    }
    
    private func userPicInitialize() {
        let profileImage = UIImage(named: "mock_user_pic")
        let userPicView = UIImageView(image: profileImage)
        
        view.addSubview(userPicView)
        userPicView.translatesAutoresizingMaskIntoConstraints = false
        self.userPicView = userPicView
        
    }
    
    private func userNameLabelInitialize() {
        let userNameLabel = UILabel()
        userNameLabel.text = "Екатерина Новикова"
        userNameLabel.textColor = .ypWhite
        userNameLabel.font = .systemFont(ofSize: 23, weight: .bold)

        view.addSubview(userNameLabel)
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.userNameLabel = userNameLabel
        
    }
    
    private func userLoginNameLabelInitialize() {
        let userLoginNameLabel = UILabel()
        userLoginNameLabel.text = "@ekaterina_nov"
        userLoginNameLabel.textColor = .ypGray
        userLoginNameLabel.font = .systemFont(ofSize: 13, weight: .regular)
        
        view.addSubview(userLoginNameLabel)
        userLoginNameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.userLoginNameLabel = userLoginNameLabel
    }
    
    private func userDescriptionLabelInitizalize() {
        let userDescriptionLabel = UILabel()
        userDescriptionLabel.text = "Hello, world!"
        userDescriptionLabel.textColor = .ypWhite
        userDescriptionLabel.font = .systemFont(ofSize: 13, weight: .regular)
        
        view.addSubview(userDescriptionLabel)
        userDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.userDescriptionLabel = userDescriptionLabel
    }
    
    private func logoutButtonInitialize() {
        let logoutImage = UIImage(named: "exit")
        
        let logoutButton = UIButton()
        logoutButton.setImage(logoutImage, for: .normal)
        logoutButton.tintColor = .red
        
        view.addSubview(logoutButton)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        self.logoutButton = logoutButton
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            userPicView.widthAnchor.constraint(equalToConstant: 70),
            userPicView.heightAnchor.constraint(equalTo: userPicView.widthAnchor),
            userPicView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            userPicView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            userNameLabel.topAnchor.constraint(equalTo: userPicView.bottomAnchor, constant: 8),
            userNameLabel.leadingAnchor.constraint(equalTo: userPicView.leadingAnchor),
            
            userLoginNameLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 8),
            userLoginNameLabel.leadingAnchor.constraint(equalTo: userNameLabel.leadingAnchor),
            
            userDescriptionLabel.topAnchor.constraint(equalTo: userLoginNameLabel.bottomAnchor, constant: 8),
            userDescriptionLabel.leadingAnchor.constraint(equalTo: userNameLabel.leadingAnchor),
            
            logoutButton.centerYAnchor.constraint(equalTo: userPicView.centerYAnchor),
            logoutButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ])
    }
}
