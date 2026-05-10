//
//  ImagesListViewController.swift
//  ImageFeed
//
//  Created by Dmitry Zherebyatnikov on 19.04.2026.
//

import UIKit

final class ImagesListViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet weak private var tableView: UITableView!

    // MARK: - Properties

    private let photoNames = (0..<20).map(String.init)
    private let showSingleImageSegueIdentifier = "ShowSingleImage"

    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

// MARK: - UITableViewDelegate

extension ImagesListViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        performSegue(withIdentifier: showSingleImageSegueIdentifier, sender: indexPath)
    }
}

// MARK: - UITableViewDataSource

extension ImagesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int
    {
        return photoNames.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: ImagesListCell.reuseIdentifier,
            for: indexPath
        )

        guard let imageListCell = cell as? ImagesListCell else {
            return UITableViewCell()
        }

        configCell(for: imageListCell, with: indexPath)
        return imageListCell
    }

    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        guard let image = UIImage(named: photoNames[indexPath.row]) else {
            return 0
        }

        let sideInsets = 16.0
        let topBottomInsets = 4.0

        let imageViewWidth = tableView.bounds.width - sideInsets * 2

        let aspect = image.size.width / imageViewWidth
        let height = image.size.height / aspect

        return height + 2 * topBottomInsets
    }
}

// MARK: - Private Methods

extension ImagesListViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == showSingleImageSegueIdentifier {
                guard
                    let viewController = segue.destination as? SingleImageViewController,
                    let indexPath = sender as? IndexPath
                else {
                    assertionFailure("Invalid segue destination")
                    return
                }

                let image = UIImage(named: photoNames[indexPath.row])
                viewController.image = image
            } else {
                super.prepare(for: segue, sender: sender) 
            }
        }
    
    func configCell(for cell: ImagesListCell, with indexPath: IndexPath) {
        guard let image = UIImage(named: photoNames[indexPath.row]) else {
            return
        }

        cell.cellImage.image = image
        cell.dateLabel.text = dateFormatter.string(from: Date())

        let isLiked = indexPath.row % 2 == 0

        let likeImage =
            isLiked
            ? UIImage(named: "like_button_on")
            : UIImage(named: "like_button_off")

        cell.likeButton.setImage(likeImage, for: .normal)
    }

    func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self

        //        tableView.register(
        //            ImagesListCell.self,
        //            forCellReuseIdentifier: ImagesListCell.reuseIdentifier
        //        )

        tableView.contentInset = UIEdgeInsets(
            top: 12,
            left: 0,
            bottom: 12,
            right: 0
        )
    }
    
}
