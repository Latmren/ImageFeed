//
//  OAuth2TokenStorage.swift
//  ImageFeed
//
//  Created by Dmitry Zherebyatnikov on 23.06.2026.
//

import Foundation

final class OAuth2TokenStorage {
    var token: String? {
        get { UserDefaults.standard.string(forKey: "token") ?? nil }
        set { UserDefaults.standard.set(newValue, forKey: "token") }
    }
}
