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
    let created_at: Int

    private enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case scope
        case created_at
    }
}
