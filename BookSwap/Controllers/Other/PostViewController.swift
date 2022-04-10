//
//  PostViewController.swift
//  BookSwap
//
//  Created by Shivani Vora on 3/17/22.
//
//
import UIKit

class PostViewController: UIViewController {

    let post: Post
    
    init(post: Post){
        self.post = post
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Post"
        view.backgroundColor = .systemBackground

    }

}
