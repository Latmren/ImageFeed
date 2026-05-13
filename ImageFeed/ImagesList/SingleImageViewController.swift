//
//  SingleImageViewController.swift
//  ImageFeed
//
//  Created by Dmitry Zherebyatnikov on 10.05.2026.
//

import UIKit

final class SingleImageViewController: UIViewController {
    // MARK: - Properties
    var image: UIImage? {
        didSet {
            guard isViewLoaded else { return }
            scrollViewInitialize()
            imageInitialize()
        }
    }

    // MARK: - IBOutlets
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var scrollView: UIScrollView!

    // MARK: - IBActions
    @IBAction func didTapBackButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func didTapShareButton(_ sender: Any) {
        guard let image else { return }
        let share = UIActivityViewController(
            activityItems: [image],
            applicationActivities: nil
        )
        present(share, animated: true, completion: nil)
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollViewInitialize()
        imageInitialize()
    }

    // MARK: - Private Methods
    private func initialRescaleAndCenterImageInScrollView(image: UIImage) {

        view.layoutIfNeeded()

        let visibleRectSize = scrollView.bounds.size
        let imageSize = image.size

        let hScale = visibleRectSize.width / imageSize.width
        let vScale = visibleRectSize.height / imageSize.height
        let scale = min(
            scrollView.maximumZoomScale,
            max(scrollView.minimumZoomScale, max(hScale, vScale))
        )

        scrollView.setZoomScale(scale, animated: false)
        scrollView.layoutIfNeeded()

        let newContentSize = scrollView.contentSize

        let x = (visibleRectSize.width - newContentSize.width) / 2
        let y = (visibleRectSize.height - newContentSize.height) / 2

        scrollView.contentInset = UIEdgeInsets(
            top: y,
            left: x,
            bottom: y,
            right: x
        )

    }

    private func centerImageInScrollView(image: UIImage) {
        let visibleRectSize = scrollView.bounds.size
        let newContentSize = scrollView.contentSize

        let x = max(0, (visibleRectSize.width - newContentSize.width) / 2)
        let y = max(0, (visibleRectSize.height - newContentSize.height) / 2)

        scrollView.contentInset = UIEdgeInsets(
            top: y,
            left: x,
            bottom: y,
            right: x
        )
    }

    private func imageInitialize() {
        guard let image else { return }

        imageView.image = image
        imageView.frame.size = image.size

        initialRescaleAndCenterImageInScrollView(image: image)
    }

    private func scrollViewInitialize() {
        scrollView.minimumZoomScale = 0.1
        scrollView.maximumZoomScale = 1.25
    }
}

// MARK: - UIScrollViewDelegate
extension SingleImageViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    func scrollViewDidEndZooming(
        _ scrollView: UIScrollView,
        with view: UIView?,
        atScale scale: CGFloat
    ) {
        if let image { centerImageInScrollView(image: image) }
    }
}
