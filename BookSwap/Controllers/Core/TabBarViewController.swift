//
//  TabBarViewController.swift
//  BookSwap
//
//  Created by Shivani Vora on 3/17/22.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let email = UserDefaults.standard.string(forKey: "email"), let firstName = UserDefaults.standard.string(forKey: "firstName"), let lastName = UserDefaults.standard.string(forKey: "lastName") else {
            return
        }
        
        let currentUser = User(firstName: firstName, lastName: lastName, email: email)
        
        // Define VCs
        let home = HomeViewController()
        let camera = CameraViewController()
        let profile = ProfileViewController(user: currentUser)
        
        let nav1 = UINavigationController(rootViewController: home)
        let nav2 = UINavigationController(rootViewController: camera)
        let nav3 = UINavigationController(rootViewController: profile)
        
        nav1.navigationBar.tintColor = .label
        nav2.navigationBar.tintColor = .label
        nav3.navigationBar.tintColor = .label
        
        //Define tab items
        nav1.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Post a Book", image: UIImage(systemName: "plus"), tag: 1)
        nav3.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 1)
        
        //Set controllers
        self.setViewControllers([nav1, nav2, nav3], animated: false)
        

        // Do any additional setup after loading the view.
    }
    
}
