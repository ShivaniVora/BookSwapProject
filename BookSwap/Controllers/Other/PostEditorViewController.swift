//
//  PostEditorViewController.swift
//  BookSwap
//
//  Created by Shivani Vora on 3/20/22.
//

import UIKit

class PostEditorViewController: UIViewController {

    private let imageView: UIImageView = {
            let imageView = UIImageView()
            imageView.clipsToBounds = true
            imageView.contentMode = .scaleAspectFill
            return imageView
        }()
       
        private let image: UIImage
       
        init(image: UIImage) {
            self.image = image
            super.init(nibName: nil, bundle: nil)
        }
       
        required init?(coder: NSCoder) {
            fatalError()
        }
       
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .secondarySystemBackground
            title = "Add Information"
            imageView.image = image
            view.addSubview(imageView)
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(didTapNext))
        }
       
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            imageView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.width, height: view.width)
        }
       
        @objc func didTapNext() {
            let vc = CaptionViewController(image: image)
            vc.title = "Add Info"
            navigationController?.pushViewController(vc, animated: true)
        }
    }
