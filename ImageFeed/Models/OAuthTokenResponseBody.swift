//
//  OAuthTokenResponseBody.swift
//  ImageFeed
//
//  Created by Dmitry Zherebyatnikov on 23.06.2026.
//

import Foundation

public struct OAuthTokenResponseBody: Decodable {
    let accessToken: String
    let tokenType: String
    let scope: String
    let createdAt: Int
}
