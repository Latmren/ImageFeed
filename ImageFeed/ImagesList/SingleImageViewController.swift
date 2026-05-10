//
//  SingleImageViewController.swift
//  ImageFeed
//
//  Created by Dmitry Zherebyatnikov on 10.05.2026.
//

import UIKit

final class SingleImageViewController: UIViewController {
    var image: UIImage?{
        didSet {
            guard isViewLoaded else { return }
            imageView.image = image
        }
    }

    @IBOutlet private var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
    }
}
