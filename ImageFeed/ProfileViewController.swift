//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by Dmitry Zherebyatnikov on 09.05.2026.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    @IBOutlet private var userPic: UIImageView!
    @IBOutlet private var userName: UILabel!
    @IBOutlet private var userLogin: UILabel!
    @IBOutlet private var userDescription: UILabel!
    
    @IBOutlet private var logoutButton: UIButton!
    
    @IBAction private func logoutTapped(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}
