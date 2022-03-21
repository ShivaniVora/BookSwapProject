//
//  ProfileViewController.swift
//  BookSwap
//
//  Created by Shivani Vora on 3/17/22.
//

import UIKit

class ProfileViewController: UIViewController {

    private let user: User
    
    private var isCurrentUser: Bool {
        return user.email.lowercased() == UserDefaults.standard.string(forKey: "email")?.lowercased() ?? ""
    }
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\(user.firstName) \(user.lastName)"
        view.backgroundColor = .systemBackground
        configure()
    }
    
    private func configure() {
        if isCurrentUser {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .done, target: self, action: #selector(didTapSettings))
        }
    }
    
    @objc func didTapSettings() {
        let vc = SettingsViewController()
        present(UINavigationController(rootViewController: vc), animated: true)
    }
    
}
