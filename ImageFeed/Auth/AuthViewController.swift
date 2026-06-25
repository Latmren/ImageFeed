//
//  AuthViewController.swift.swift
//  ImageFeed
//
//  Created by Dmitry Zherebyatnikov on 14.06.2026.
//

import UIKit

protocol AuthViewControllerDelegate: AnyObject {
    func didAuthenticate(_ vc: AuthViewController)
}

final class AuthViewController: UIViewController {
    private let showWebViewSegueIdentifier = "ShowWebView"
    private let oauth2Service = OAuth2Service.shared

    weak var delegate: AuthViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackButton()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == showWebViewSegueIdentifier {
            guard
                let webViewViewController = segue.destination
                    as? WebViewViewController
            else {
                assertionFailure(
                    "Failed to prepare for \(showWebViewSegueIdentifier)"
                )
                return
            }
            webViewViewController.delegate = self
        } else {
            super.prepare(for: segue, sender: sender)
        }

    }
    private func configureBackButton() {
        navigationController?.navigationBar.backIndicatorImage = UIImage(
            named: "nav_back_button_black"
        )
        navigationController?.navigationBar.backIndicatorTransitionMaskImage =
            UIImage(named: "nav_back_button_black")
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "",
            style: .plain,
            target: nil,
            action: nil
        )
        navigationItem.backBarButtonItem?.tintColor = UIColor(named: "ypBlack")
    }
}

extension AuthViewController: WebViewViewControllerDelegate {
    func webViewViewController(
        _ vc: WebViewViewController,
        didAuthenticateWithCode code: String
    ) {

        fetchOAuthToken(code) { [weak self] result in
            guard let self = self else {
                assertionFailure("self is nil")
                return
            }

            switch result {
            case .success:
                vc.dismiss(animated: true) {
                    self.delegate?.didAuthenticate(self)
                }
            case .failure:
                print("Failed to authenticate")
                vc.dismiss(animated: true)
            }
        }
    }

    func webViewViewControllerDidCancel(_ vc: WebViewViewController) {
        vc.dismiss(animated: true)
    }
}

extension AuthViewController {
    private func fetchOAuthToken(
        _ code: String,
        completion: @escaping (Result<String, Error>) -> Void
    ) {

        oauth2Service.fetchOAuthToken(code) { result in
            completion(result)
        }
    }
}
