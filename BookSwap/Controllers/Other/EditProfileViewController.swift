//
//  EditProfileViewController.swift
//  BookSwap
//
//  Created by Shivani Vora on 4/2/22.
//

import UIKit

class EditProfileViewController: UIViewController {

    public var completion: (() -> Void)?
    
    let firstNameField: BATextField = {
        let field = BATextField()
        field.placeholder = "First Name..."
        return field
    }()
    
    let lastNameField: BATextField = {
        let field = BATextField()
        field.placeholder = "Last Name..."
        return field
    }()
    
    let emailField: BATextField = {
        let field = BATextField()
        field.placeholder = "Email..."
        return field
    }()
    
    let phoneField: BATextField = {
        let field = BATextField()
        field.placeholder = "Phone..."
        return field
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Edit Profile"
        
        view.backgroundColor = .systemBackground
        view.addSubview(firstNameField)
        view.addSubview(lastNameField)
        view.addSubview(emailField)
        view.addSubview(phoneField)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapClose))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSave))
        
        
        guard let email = UserDefaults.standard.string(forKey: "email") else { return }
        
        DatabaseManager.shared.getUserInfo(email: email) { [weak self] info, user in
            DispatchQueue.main.async {
                if let info = info {
                    self?.phoneField.text = info.phone
                }
                
                /*self?.emailField.text = email
                self?.firstNameField.text = UserDefaults.standard.string(forKey: "firstName")
                self?.lastNameField.text = UserDefaults.standard.string(forKey: "lastName")*/
                if let user = user {
                    self?.emailField.text = user.email
                    self?.firstNameField.text = user.firstName
                    self?.lastNameField.text = user.lastName
                }
                
                
            }
        }
         

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        firstNameField.frame = CGRect(x: 20, y: view.safeAreaInsets.top+10, width: view.width-40, height: 50)
        lastNameField.frame = CGRect(x: 20, y: firstNameField.bottom + 10, width: view.width-40, height: 50)
        emailField.frame = CGRect(x: 20, y: lastNameField.bottom + 10, width: view.width-40, height: 50)
        phoneField.frame = CGRect(x: 20, y: emailField.bottom + 10, width: view.width-40, height: 50)
    }
    
    @objc func didTapClose() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func didTapSave() {
        let email = emailField.text ?? ""
        let firstName = firstNameField.text ?? ""
        let lastName = lastNameField.text ?? ""
        let phone = phoneField.text ?? ""
        
        let newInfo = UserInfo(phone: phone)
        let user = User(firstName: firstName, lastName: lastName, email: email)
        
        DatabaseManager.shared.setUserInfo(userInfo: newInfo, user: user) { [weak self] success in
            DispatchQueue.main.async {
                if success {
                    self?.didTapClose()
                    self?.completion?()
                }
            }
        }
    }

}
