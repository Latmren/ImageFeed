//
//  OAuth2Service.swift
//  ImageFeed
//
//  Created by Dmitry Zherebyatnikov on 22.06.2026.
//

import UIKit

final class OAuth2Service {
    static let shared = OAuth2Service()
    private let tokenStorage = OAuth2TokenStorage()
    private var oAuthTokenTask: URLSessionTask?
    private init() {}

    func fetchOAuthToken(
        _ code: String,
        completion: @escaping (Result<String, Error>) -> Void
    ) {
        guard oAuthTokenTask == nil else {
            print("Error: already fetching token")
            return
        }

        guard let request = makeOAuthTokenRequest(code: code) else {
            print("Error: bad url")
            completion(.failure(URLError(.badURL)))
            return
        }

        let task = URLSession.shared.data(for: request) { [weak self] result in
            self?.oAuthTokenTask = nil

            switch result {
            case .success(let data):
                do {
                    let responseData = try JSONDecoder().decode(
                        OAuthTokenResponseBody.self,
                        from: data
                    )
                    let authorizationToken = responseData.accessToken
                    self?.tokenStorage.token = authorizationToken
                    completion(.success(authorizationToken))
                } catch {
                    print("Error: \(error)")
                    completion(.failure(error))
                }
            case .failure(let error):
                print("Error: \(error)")
                completion(.failure(error))
            }
        }
        oAuthTokenTask = task
        task.resume()
    }

    private func makeOAuthTokenRequest(code: String) -> URLRequest? {
        guard
            var urlComponents = URLComponents(
                string: "https://unsplash.com/oauth/token"
            )
        else {
            assertionFailure(
                "Error in OAuth2Service: Invalid URL, missing scheme or host"
            )
            return nil
        }

        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: Constants.accessKey),
            URLQueryItem(name: "client_secret", value: Constants.secretKey),
            URLQueryItem(name: "redirect_uri", value: Constants.redirectURI),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "grant_type", value: "authorization_code"),
        ]

        guard let authTokenUrl = urlComponents.url else {
            assertionFailure(
                "Error in OAuth2Service: Invalid URL, missing query items"
            )
            return nil
        }

        var request = URLRequest(url: authTokenUrl)
        request.httpMethod = "POST"
        return request
    }
}
