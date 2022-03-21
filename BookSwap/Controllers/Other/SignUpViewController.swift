//
//  SignUpViewController.swift
//  BookSwap
//
//  Created by Shivani Vora on 3/17/22.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    private let firstNameField: BATextField = {
        let field = BATextField()
        field.placeholder = "First Name"
        field.keyboardType = .default
        field.returnKeyType = .next
        field.autocorrectionType = .no
        return field
    }()
    
    private let lastNameField: BATextField = {
        let field = BATextField()
        field.placeholder = "Last Name"
        field.keyboardType = .default
        field.returnKeyType = .next
        field.autocorrectionType = .no
        return field
    }()
    
    private let emailField: BATextField = {
        let field = BATextField()
        field.placeholder = "Email Address"
        field.keyboardType = .emailAddress
        field.returnKeyType = .next
        field.autocorrectionType = .no
        return field
    }()
    
    private let passwordField: BATextField = {
        let field = BATextField()
        field.placeholder = "Create Password"
        field.isSecureTextEntry = true
        field.keyboardType = .default
        field.returnKeyType = .continue
        field.autocorrectionType = .no
        return field
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    private let termsButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.link, for: .normal)
        button.setTitle("Terms and Conditions", for: .normal)
        return button
    }()
    
    private let privacyButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.link, for: .normal)
        button.setTitle("Privacy Policy", for: .normal)
        return button
    }()
    
    public var completion: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Create Account"
        view.backgroundColor = .systemBackground
        addSubviews()
        
        firstNameField.delegate = self
        lastNameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        addButtonActions()
    }
    
    private func addSubviews() {
        view.addSubview(firstNameField)
        view.addSubview(lastNameField)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(signUpButton)
        view.addSubview(termsButton)
        view.addSubview(privacyButton)
    }
    
    private func addButtonActions() {
        signUpButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
        termsButton.addTarget(self, action: #selector(didTapTerms), for: .touchUpInside)
        privacyButton.addTarget(self, action: #selector(didTapPrivacy), for: .touchUpInside)
    }
    
    @objc private func didTapSignUp() {
        firstNameField.resignFirstResponder()
        lastNameField.resignFirstResponder()
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard let first = firstNameField.text,
              let last = lastNameField.text,
              let email = emailField.text,
              let password = passwordField.text,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty,
              !first.trimmingCharacters(in: .whitespaces).isEmpty,
              !last.trimmingCharacters(in: .whitespaces).isEmpty,
              password.count >= 6
        else {
            let alert = UIAlertController(title: "Whoops", message: "Please make sure your password is over 6 characters and you have entered a valid email address.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            present(alert, animated: true)
            return
        }
        
        //signin w/ authManager
        AuthManager.shared.signUp(firstName: first, lastName: last, email: email, password: password) {[weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    UserDefaults.standard.setValue(user.email, forKey: "email")
                    UserDefaults.standard.setValue(user.firstName, forKey: "firstName")
                    UserDefaults.standard.setValue(user.lastName, forKey: "lastName")
                    
                    self?.navigationController?.popToRootViewController(animated: true)
                    self?.completion?()
                case .failure(let error):
                    print("\n\n Sign Up Error: \(error)")
                }
            }

        }
    }
    
    @objc private func didTapTerms() {
        let vc = TermsViewController()
        /*vc.completion = {
            
        }*/
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func didTapPrivacy() {
        let vc = PrivacyViewController()
        /*vc.completion = {
            
        }*/
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        firstNameField.frame = CGRect(x: 25, y: view.safeAreaInsets.top + 20, width: view.width-50, height: 50)
        lastNameField.frame = CGRect(x: 25, y: firstNameField.bottom + 10, width: view.width-50, height: 50)
        emailField.frame = CGRect(x: 25, y: lastNameField.bottom + 10, width: view.width-50, height: 50)
        passwordField.frame = CGRect(x: 25, y: emailField.bottom + 10, width: view.width-50, height: 50)
        signUpButton.frame = CGRect(x: 35, y: passwordField.bottom + 20, width: view.width-70, height: 50)
        termsButton.frame = CGRect(x: 35, y: signUpButton.bottom + 50, width: view.width-70, height: 40)
        privacyButton.frame = CGRect(x: 35, y: termsButton.bottom + 10, width: view.width-70, height: 40)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == firstNameField {
            lastNameField.becomeFirstResponder()
        }
        else if textField == lastNameField {
            emailField.becomeFirstResponder()
        }
        else if textField == emailField {
            passwordField.becomeFirstResponder()
        }
        else {
            textField.resignFirstResponder()
            didTapSignUp()
        }
        return true
    }

}

